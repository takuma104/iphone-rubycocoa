#
# webdavhandler.rb - WEBrick WebDAV handler
#
#  Author: Tatsuki Sugiura <sugi@nemui.org>
#  License: Ruby's
#

require 'webrick'
require 'time'
require 'fileutils.rb'
require 'rexml/document'
require 'webrick/httpservlet/filehandler'
require 'iconv'
require 'pp'

module WEBrick
  class HTTPRequest
    # buffer is too small to transport huge files...
    if BUFSIZE < 512 * 1024
      remove_const :BUFSIZE
      BUFSIZE = 512 * 1024
    end
  end

  module Config
    webdavconf = {
      :FileSystemCoding        => "UTF-8",
      :DefaultClientCoding     => "UTF-8",
      :DefaultClientCodingWin  => "CP932",
      :DefaultClientCodingMacx => "UTF-8",
      :DefaultClientCodingUnix => "EUC-JP",
      :NotInListName           => %w(.*),
      :NondisclosureName       => %w(.ht*),
    }
    WebDAVHandler = FileHandler.merge(webdavconf)
  end

  module HTTPStatus
    new_StatusMessage = {
      102, 'Processing',
      207, 'Multi-Status',
      422, 'Unprocessable Entity',
      423, 'Locked',
      424, 'Failed Dependency',
      507, 'Insufficient Storage',
    }
    StatusMessage.each_key {|k| new_StatusMessage.delete(k)}
    StatusMessage.update new_StatusMessage

    new_StatusMessage.each{|code, message|
      var_name = message.gsub(/[ \-]/,'_').upcase
      err_name = message.gsub(/[ \-]/,'')
      
      case code
      when 100...200; parent = Info
      when 200...300; parent = Success
      when 300...400; parent = Redirect
      when 400...500; parent = ClientError
      when 500...600; parent = ServerError
      end

      eval %-
        RC_#{var_name} = #{code}
        class #{err_name} < #{parent}
          def self.code() RC_#{var_name} end
          def self.reason_phrase() StatusMessage[code] end
          def code() self::class::code end
          def reason_phrase() self::class::reason_phrase end
          alias to_i code
        end
      -

      CodeToError[code] = const_get(err_name)
    }
  end # HTTPStatus
end # WEBrick

module WEBrick; module HTTPServlet;
class WebDAVHandler < FileHandler
  class Unsupported < NotImplementedError; end
  class IgnoreProp  < StandardError; end

  class CodeConvFilter
    module Detector
      def dav_ua(req)
        case req["USER-AGENT"]
        when /Microsoft Data Access Internet Publishing/
          {@options[:DefaultClientCodingWin] => 70, "UTF-8" => 30}
        when /^gnome-vfs/
          {"UTF-8" => 90}
        when /^WebDAVFS/
          {@options[:DefaultClientCodingMacx] => 80}
        when /Konqueror/
          {@options[:DefaultClientCodingUnix] => 60, "UTF-8" => 40}
        else
          {}
        end
      end

      def chk_utf8(req)
        begin 
          Iconv.iconv("UTF-8", "UTF-8", req.path, req.path_info)
          {"UTF-8" => 40}
        rescue Iconv::IllegalSequence
          {"UTF-8" => -500}
        end
      end

      def chk_os(req)
        case req["USER-AGENT"]
        when /Microsoft|Windows/i
          {@options[:DefaultClientCodingWin] => 10}
        when /UNIX|X11/i
          {@options[:DefaultClientCodingUnix] => 10}
        when /darwin|MacOSX/
          {"UTF-8" => 20}
        else 
          {}
        end
      end

      def default(req)
        {@options[:DefaultClientCoding] => 20}
      end
    end # Detector
  
    def initialize(options={}, default=Config::WebDAVHandler)
      @options = default.merge(options)
      @detect_meth = [:default, :chk_utf8, :dav_ua, :chk_os]
      @enc_score   = Hash.new(0)
    end
    attr_accessor :detect_meth

    def detect(req)
      self.extend Detector
      detect_meth.each { |meth|
        score = self.__send__ meth, req
        @enc_score.update(score) {|enc, cur, new| cur + new}
      }
      #$DEBUG and $stderr.puts "code detection score ===> #{@enc_score.inspect}"
      platform_codename(@enc_score.keys.sort_by{|k| @enc_score[k] }.last)
    end

    def conv(req, from=nil, to="UTF-8")
      from ||= detect(req)
      #$DEBUG and $stderr.puts "=== CONVERT === #{from} -> #{to}"
      return true if from == to
      req.path_info = Iconv.iconv(to, from, req.path_info).first
      req.instance_variable_set :@path, Iconv.iconv(to, from, req.path).first
      req["destination"].nil? or req.instance_eval {
        @header["destination"][0] = HTTPUtils.escape(
          Iconv.iconv(to, from,
            HTTPUtils.unescape(@header["destination"][0])).first)
      }
      true
    end

    def conv2fscode!(req)
      conv(req, nil, @options[:FileSystemCoding])
    end

    def platform_codename(name)
      case RUBY_PLATFORM
      when /linux/
        name
      when /solaris|sunos/
        {
          "CP932"  => "MS932",
          "EUC-JP" => "eucJP"
        }[name]
      when /aix/
        {
          "CP932"  => "IBM-932",
          "EUC-JP" => "IBM-eucJP"
        }[name]
      else
        name
      end
    end
  end # CodeConvFilter

  def initialize(server, root, options={}, default=Config::WebDAVHandler)
    super
    @cconv = CodeConvFilter.new(@options)
  end

  def service(req, res)
    codeconv_req!(req)
    super
  end

  # TODO:
  #   class 2 protocols; LOCK UNLOCK
  def do_LOCK(req, res)
  end
  
  def do_UNLOCK(req, res)
  end

  def do_OPTIONS(req, res)
    @logger.debug "run do_OPTIONS"
    res["DAV"] = "1,2"
#    res["DAV"] = "1"
    res["MS-Author-Via"] = "DAV"
    super
  end

  def do_PROPFIND(req, res)
    map_filename(req, res)
    @logger.debug "propfind requeset depth=#{req['Depth']}"
    depth = (req["Depth"].nil? || req["Depth"] == "infinity") ? nil : req["Depth"].to_i
    raise HTTPStatus::Forbidden unless depth # deny inifinite propfind

    begin
      req_doc = REXML::Document.new req.body
    rescue REXML::ParseException
      raise HTTPStatus::BadRequest
    end

    ns = {""=>"DAV:"}
    req_props = []
    all_props = %w(creationdate getlastmodified getetag
                   resourcetype getcontenttype getcontentlength)

    if req.body.nil? || !REXML::XPath.match(req_doc, "/propfind/allprop", ns).empty?
      req_props = all_props
    elsif !REXML::XPath.match(req_doc, "/propfind/propname", ns).empty?
      # TODO: support propname
      raise HTTPStatus::NotImplemented
    elsif !REXML::XPath.match(req_doc, "/propfind/prop", ns).empty?
      REXML::XPath.each(req_doc, "/propfind/prop/*", ns){|e|
        req_props << e.name
      }
    else
      raise HTTPStatus::BadRequest
    end

    ret = get_rec_prop(req, res, res.filename,
                       HTTPUtils.escape(codeconv_str_fscode2utf(req.path)),
                       req_props, *[depth].compact)
    res.body << build_multistat(ret).to_s
    res["Content-Type"] = 'text/xml; charset="utf-8"'
    raise HTTPStatus::MultiStatus
  end

  def do_PROPPATCH(req, res)
    map_filename(req, res)
    ret = []
    ns = {""=>"DAV:"}
    begin
      req_doc = REXML::Document.new req.body
    rescue REXML::ParseException
      raise HTTPStatus::BadRequest
    end
    REXML::XPath.each(req_doc, "/propertyupdate/remove/prop/*", ns){|e|
      ps = REXML::Element.new "D:propstat"
      ps.add_element("D:prop").add_element "D:"+e.name
      ps << elem_status(req, res, HTTPStatus::Forbidden)
      ret << ps
    }
    REXML::XPath.each(req_doc, "/propertyupdate/set/prop/*", ns){|e|
      ps = REXML::Element.new "D:propstat"
      ps.add_element("D:prop").add_element "D:"+e.name
      begin
        e.namespace.nil? || e.namespace == "DAV:" or raise Unsupported
        case e.name
        when "getlastmodified"
          File.utime(Time.now, Time.httpdate(e.text), res.filename)
        else
          raise Unsupported
        end
        ps << elem_status(req, res, HTTPStatus::OK)
      rescue Errno::EACCES, ArgumentError
        ps << elem_status(req, res, HTTPStatus::Conflict)
      rescue Unsupported
        ps << elem_status(req, res, HTTPStatus::Forbidden)
      rescue
        ps << elem_status(req, res, HTTPStatus::InternalServerError)
      end
      ret << ps
    }
    res.body << build_multistat([[req.request_uri, *ret]]).to_s(0)
    res["Content-Type"] = 'text/xml; charset="utf-8"'
    raise HTTPStatus::MultiStatus
  end

  def do_MKCOL(req, res)
    req.body.nil? or raise HTTPStatus::MethodNotAllowed
    begin
      @logger.debug "mkdir #{@root+req.path_info}"
      Dir.mkdir(@root + req.path_info)
    rescue Errno::ENOENT, Errno::EACCES
      raise HTTPStatus::Forbidden
    rescue Errno::ENOSPC
      raise HTTPStatus::InsufficientStorage
    rescue Errno::EEXIST
      raise HTTPStatus::Conflict
    end
    raise HTTPStatus::Created
  end

  def do_DELETE(req, res)
    map_filename(req, res)
    begin
      @logger.debug "rm_rf #{res.filename}"
      FileUtils.rm_rf(res.filename)
    rescue Errno::EPERM
      raise HTTPStatus::Forbidden
    #rescue
      # FIXME: to return correct error.
      # we needs to stop useing rm_rf and check each deleted entries.
    end
    raise HTTPStatus::NoContent
  end

  def do_PUT(req, res)
    file = @root + req.path_info
    if req['range']
      ranges = HTTPUtils::parse_range_header(req['range']) or
        raise HTTPStatus::BadRequest,
          "Unrecognized range-spec: \"#{req['range']}\""
    end

    if !ranges.nil? && ranges.length != 1
      raise HTTPStatus::NotImplemented
    end

    begin
      File.open(file, "w+") {|f|
        if ranges
          # TODO: supports multiple range
          ranges.each{|range|
            first, last = prepare_range(range, filesize)
            first + req.content_length != last and
              raise HTTPStatus::BadRequest
            f.pos = first
            req.body {|buf| f << buf }
          }
        else
          req.body {|buf| f << buf }
        end
      }
    rescue Errno::ENOENT
      raise HTTPStatus::Conflict
    rescue Errno::ENOSPC
      raise HTTPStatus::InsufficientStorage
    end
  end

  def do_COPY(req, res)
    src, dest, depth, exists_p = cp_mv_precheck(req, res)
    @logger.debug "copy #{src} -> #{dest}"
    begin
      if depth.nil? # infinity
        FileUtils.cp_r(src, dest, {:preserve => true})
      elsif depth == 0
        if File.directory?(src)
          st = File.stat(src)
          Dir.mkdir(dest)
          begin
            File.utime(st.atime, st.mtime, dest)
          rescue
            # simply ignore
          end
        else
          FileUtils.cp(src, dest, {:preserve => true})
        end
      end
    rescue Errno::ENOENT
      raise HTTPStatus::Conflict
      # FIXME: use multi status(?) and check error URL.
    rescue Errno::ENOSPC
      raise HTTPStatus::InsufficientStorage
    end

    raise exists_p ? HTTPStatus::NoContent : HTTPStatus::Created
  end

  def do_MOVE(req, res)
    src, dest, depth, exists_p = cp_mv_precheck(req, res)
    @logger.debug "rename #{src} -> #{dest}"
    begin
      File.rename(src, dest)
    rescue Errno::ENOENT
      raise HTTPStatus::Conflict
      # FIXME: use multi status(?) and check error URL.
    rescue Errno::ENOSPC
      raise HTTPStatus::InsufficientStorage
    end

    if exists_p
      raise HTTPStatus::NoContent
    else
      raise HTTPStatus::Created
    end
  end


  ######################
  private 

  def get_handler(req, res)
    return DefaultFileHandler
  end

  def search_index_file(req, res)
    return nil
  end

  def cp_mv_precheck(req, res)
    depth = (req["Depth"].nil? || req["Depth"] == "infinity") ? nil : req["Depth"].to_i
    depth.nil? || depth == 0 or raise HTTPStatus::BadRequest
    @logger.debug "copy/move requested. Deistnation=#{req['Destination']}"
    dest_uri = URI.parse(req["Destination"])
    unless "#{req.host}:#{req.port}" == "#{dest_uri.host}:#{dest_uri.port}"
      raise HTTPStatus::BadGateway
      # TODO: anyone needs to copy other server?
    end
    src  = @root + req.path_info
    dest = @root + resolv_destpath(req)

    src == dest and raise HTTPStatus::Forbidden

    exists_p = false
    if File.exists?(dest)
      exists_p = true
      if req["Overwrite"] == "T"
        @logger.debug "copy/move precheck: Overwrite flug=T, deleteing #{dest}"
        FileUtils.rm_rf(dest)
      else
        raise HTTPStatus::PreconditionFailed
      end
    end
    return *[src, dest, depth, exists_p]
  end

  def codeconv_req!(req)
    @logger.debug "codeconv req obj: orig; path_info='#{req.path_info}', dest='#{req["Destination"]}'"
    begin
      @cconv.conv2fscode!(req)
    rescue Iconv::IllegalSequence
      @logger.warn "code conversion fail! for request object. #{@cconv.detect(req)}->(fscode)"
    end
    @logger.debug "codeconv req obj: ret; path_info='#{req.path_info}', dest='#{req["Destination"]}'"
    true
  end

  def codeconv_str_fscode2utf(str)
    return str if @options[:FileSystemCoding] == "UTF-8"
    @logger.debug "codeconv str fscode2utf: orig='#{str}'"
    begin
      ret = Iconv.iconv("UTF-8", @options[:FileSystemCoding], str).first
    rescue Iconv::IllegalSequence
      @logger.warn "code conversion fail! #{@options[:FileSystemCoding]}->UTF-8 str=#{str.dump}"
      ret = str
    end
    @logger.debug "codeconv str fscode2utf: ret='#{ret}'"
    ret
  end

  def map_filename(req, res)
    raise HTTPStatus::NotFound, "`#{req.path}' not found" unless @root
    set_filename(req, res)
  end

  def build_multistat(rs)
    m = elem_multistat
    rs.each {|href, *cont|
      res = m.add_element "D:response"
      res.add_element("D:href").text = href
      cont.flatten.each {|c| res.elements << c}
    }
    REXML::Document.new << m
  end

  def elem_status(req, res, retcodesym)
    gen_element("D:status",
                "HTTP/#{req.http_version} #{retcodesym.code} #{retcodesym.reason_phrase}")
  end

  def get_rec_prop(req, res, file, r_uri, props, depth = 5000)
    ret_set = []
    depth -= 1
    ret_set << [r_uri, get_propstat(req, res, file, props)]
    @logger.debug "get prop file='#{file}' depth=#{depth}"
    return ret_set if !(File.directory?(file) && depth >= 0)
    Dir.entries(file).each {|d|
      d == ".." || d == "." and next
      (@options[:NondisclosureName]+@options[:NotInListName]).find {|pat|
        File.fnmatch(pat, d) } and next
      if File.directory?("#{file}/#{d}")
        ret_set += get_rec_prop(req, res, "#{file}/#{d}",
                                HTTPUtils.normalize_path(
                                  r_uri+HTTPUtils.escape(
                                    codeconv_str_fscode2utf("/#{d}/"))),
                                props, depth)
      else 
        ret_set << [HTTPUtils.normalize_path(
                      r_uri+HTTPUtils.escape(
                        codeconv_str_fscode2utf("/#{d}"))),
          get_propstat(req, res, "#{file}/#{d}", props)]
      end
    }
    ret_set
  end

  def get_propstat(req, res, file, props)
    propstat = REXML::Element.new "D:propstat"
    errstat = {}
    begin
      st = File::lstat(file)
      pe = REXML::Element.new "D:prop"
      props.each {|pname|
        pname.gsub!('-','_')
        begin 
          if respond_to?("get_prop_#{pname}", true)
            pe << __send__("get_prop_#{pname}", file, st)
          else
            raise HTTPStatus::NotFound
          end
        rescue IgnoreProp
          # simple ignore
        rescue HTTPStatus::Status
          # FIXME: add to errstat
        end
      }
      propstat.elements << pe
      propstat.elements << elem_status(req, res, HTTPStatus::OK)
    rescue
      propstat.elements << elem_status(req, res, HTTPStatus::InternalServerError)
    end
    propstat
  end

  def get_prop_creationdate(file, st)
    gen_element "D:creationdate", st.ctime.xmlschema
  end

  def get_prop_getlastmodified(file, st)
    gen_element "D:getlastmodified", st.mtime.httpdate
  end

  def get_prop_getetag(file, st)
    gen_element "D:getetag", sprintf('%x-%x-%x', st.ino, st.size, st.mtime.to_i)
  end

  def get_prop_resourcetype(file, st)
    t = gen_element "D:resourcetype"
    File.directory?(file) and t.add_element("D:collection")
    t
  end

  def get_prop_getcontenttype(file, st)
    gen_element("D:getcontenttype",
                File.file?(file) ?
                  HTTPUtils::mime_type(file, @config[:MimeTypes]) :
                  "httpd/unix-directory")
  end

  def get_prop_getcontentlength(file, st)
    File.file?(file) or raise HTTPStatus::NotFound
    gen_element "D:getcontentlength", st.size
  end
  
#  def get_prop_quota_available_bytes(file, st)
#    p "D:quota-available-bytes"
#    gen_element "D:quota-available-bytes", sprintf('%d', 12580065280)
#  end

#  def get_prop_quota_used_bytes(file, st)
#    p "D:quota-used-bytes"
#    gen_element "D:quota-used-bytes", sprintf('%d', 3135574016)
#  end


  def elem_multistat
    gen_element "D:multistatus", nil, {"xmlns:D" => "DAV:"}
  end

  def gen_element(elem, text = nil, attrib = {})
    e = REXML::Element.new elem
    text and e.text = text
    attrib.each {|k, v| e.attributes[k] = v }
    e
  end

  def resolv_destpath(req)
    if /^#{Regexp.escape(req.script_name)}/ =~
         HTTPUtils.unescape(URI.parse(req["Destination"]).path)
      return $'
    else
      @logger.error "[BUG] can't resolv destination path. script='#{req.script_name}', path='#{req.path}', dest='#{req["Destination"]}', root='#{@root}'"
      raise HTTPStatus::InternalServerError
    end
  end

end # WebDAVHandler
end; end # HTTPServlet; WEBrick

module WebDAV
  def WebDAV.start(port)
    server = WEBrick::HTTPServer.new({:Port=>port})
    server.mount("/", WEBrick::HTTPServlet::WebDAVHandler, OSX.NSHomeDirectory.to_s)
    trap('INT') { server.shutdown }
    Thread.new { server.start }
    server
  end
end