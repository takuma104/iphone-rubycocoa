require 'irb'
require 'socket'

# based on live_console 0.2.0 
# Copyright (c) 2007 Peter Elmore (pete.elmore at gmail.com)
# http://debu.gs/live-console

module IRB
	@inited = false

	# Overridden a la FXIrb to accomodate our needs.
	def IRB.start_with_io(io, bind, &block)
		unless @inited
			setup '/dev/null'
			IRB.parse_opts
			IRB.load_modules
			@inited = true
		end

    bind ||= TOPLEVEL_BINDING
#		bind ||= IRB::Frame.top(1)
		
		ws = IRB::WorkSpace.new(bind)
		irb = Irb.new(ws, io, io)
		@CONF[:IRB_RC].call(irb.context) if @CONF[:IRB_RC]
		@CONF[:MAIN_CONTEXT] = irb.context
		@CONF[:PROMPT_MODE] = :INF_RUBY

		catch(:IRB_EXIT) { 
			begin
				irb.eval_input
			rescue StandardError => e
				irb.print([e.to_s, e.backtrace].flatten.join("\n") + "\n")
				retry
			end
		}
		irb.print "\n"
		io.close
	end

	class Context
		# Fix an IRB bug; it ignores your output method.
		def output *args
			@output_method.print *args
		end
	end

	class Irb
		# Fix an IRB bug; it ignores your output method.
		def printf(*args)
			context.output(sprintf(*args))
		end

		# Fix an IRB bug; it ignores your output method.
		def print(*args)
			context.output *args
		end
	end
end

# The GenericIOMethod is a class that wraps I/O for IRB.
class GenericIOMethod < IRB::StdioInputMethod
	# call-seq:
	# 	GenericIOMethod.new io
	# 	GenericIOMethod.new input, output
	#
	# Creates a GenericIOMethod, using either a single object for both input
	# and output, or one object for input and another for output.
	def initialize(input, output = nil)
		@input, @output = input, output
		@line = []
		@line_no = 0
	end

	attr_reader :input
	def output
		@output || input
	end

	def gets
		output.print @prompt
		output.flush
		@line[@line_no += 1] = input.gets
		# @io.flush	# Not sure this is needed.
		@line[@line_no]
	end

	# Returns the user input history.
	def lines
		@line.dup
	end

	def print(*a)
		output.print *a
	end

	def file_name
		input.inspect
	end

	def eof?
		input.eof?
	end

	def close
		input.close
		output.close if @output
	end
end


class RemoteIRB
  def initialize(port)
    @port = port
  end

  def start
    @gs = TCPServer.open(@port)
    @thread = Thread.new do
      loop do
      	Thread.start(@gs.accept) do |s|
      	  IRB.start_with_io(GenericIOMethod.new(s,s), nil)
      	  s.close
      	end
      end
    end
    @thread
  end

  def stop
    @gs.close
#    @thread.join
  end
end

if $0 == __FILE__
  rirb = RemoteIRB.new(6000)
  rirb.start
  sleep
end

