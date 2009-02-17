require 'socket'

class LiveConsole::IOMethods::UnixSocketIO
	DefaultOpts = {
		:mode => 0600,
		:uid => Process.uid,
		:gid => Process.gid,
	}
	RequiredOpts = DefaultOpts.keys + [:path]

	include LiveConsole::IOMethods::IOMethod

	def start
		@server ||= UNIXServer.new path
		
		begin
			self.raw_input = self.raw_output = server.accept_nonblock
			raw_input.sync = true
			return true
		rescue Errno::EAGAIN, Errno::ECONNABORTED, Errno::EPROTO,
			   Errno::EINTR => e
			select
			retry
		end
	end

	def stop
		select
		raw_input.close
	end
end
