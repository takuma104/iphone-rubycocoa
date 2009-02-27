#
#  $Id: oc_exception.rb 979 2006-05-29 01:18:25Z hisa $
#
#  Copyright (c) 2001 FUJIMOTO Hisakuni
#

module OSX

  class OCException < RuntimeError

    attr_reader :name, :reason, :userInfo, :nsexception

    def initialize(ocexcp, msg = nil)
      @nsexception = ocexcp
      @name = @nsexception.ocm_send(:name).to_s
      @reason = @nsexception.ocm_send(:reason).to_s
      @user_info = @nsexception.ocm_send(:userInfo)
      msg = "#{@name} - #{@reason}" if msg.nil?
      super(msg)
    end

  end

  class OCDataConvException < RuntimeError
  end

  class OCMessageSendException < RuntimeError
  end

end
