#
#  $Id: oc_wrapper.rb 834 2005-09-11 11:45:30Z kimuraw $
#
#  Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
#
#  This program is free software.
#  You can distribute/modify this program under the terms of
#  the GNU Lesser General Public License version 2.
#

module OSX

  module OCObjWrapper

    def method_missing(mname, *args)
      m_name, m_args, m_predicate = analyze_missing(mname, args)
      ret = self.ocm_send(m_name, *m_args)
      ret.ocm_send(:release) if occur_ownership?(ret, m_name)
      ret = (ret != 0) if m_predicate
      ret
    end

    def ocnil?
      self.__ocid__ == 0
    end

    def to_a
      if self.ocm_send(:isKindOfClass_, OSX::NSArray) != 0 then
	ary = Array.new
	iter = self.ocm_send(:objectEnumerator)
	while obj = iter.ocm_send(:nextObject) do
	  ary.push(obj)
	end
	ary
      elsif self.ocm_send(:isKindOfClass_, OSX::NSEnumerator) != 0 then
	self.ocm_send(:allObjects).to_a
      else
	[ self ]
      end
    end

    def to_i
      if self.ocm_send(:isKindOfClass_, OSX::NSNumber) != 0 then
	self.ocm_send(:stringValue).to_s.to_i
      else
	super
      end
    end

    def to_f
      if self.ocm_send(:isKindOfClass_, OSX::NSNumber) != 0 then
	self.ocm_send(:floatValue)
      else
	super
      end
    end

    private

    def analyze_missing(mname, args)
      m_name = mname.to_s
      m_args = args

      # remove `oc_' prefix
      m_name.sub!(/^oc_/, '')

      # is predicate ?
      m_predicate = m_name.sub!(/\?$/,'')
      # m_predicate = (/^is/ =~ m_name) unless m_predicate

      # check call style
      # as Objective-C: [self aaa: a0 Bbb: a1 Ccc: a2]
      # as Ruby:   self.aaa_Bbb_Ccc_ (a0, a1, a2)
      # as Ruby:   self.aaa_Bbb_Ccc (a0, a1, a2)
      # as Ruby:   self.aaa (a0, :Bbb, a1, :Ccc, a2)
      if (m_args.size >= 3) && ((m_args.size % 2) == 1) && (not m_name.include?('_')) then
	mname = m_name.dup
	args = Array.new
	m_args.each_with_index do |val, index|
	  if (index % 2) == 0 then
	    args.push(val)
	  else
	    mname += "_#{val.to_s}"
	  end
	end
	m_name = "#{mname}_"
	m_args = args
      else
	m_name.sub!(/[^_:]$/, '\0_') if m_args.size > 0
      end
      [ m_name, m_args, m_predicate ]
    end

    def occur_ownership?(obj, m_name)
      obj.is_a?(OSX::OCObjWrapper) &&
	(m_name =~ /^init/ ||
	 m_name =~ /^new/ ||
	 m_name =~ /^copy/ ||
	 m_name =~ /^mutableCopy/)
    end

  end

end				# module OSX
