#
#  $Id: oc_exception.rb 450 2002-12-12 07:05:17Z hisa $
#
#  Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
#
#  This program is free software.
#  You can distribute/modify this program under the terms of
#  the GNU Lesser General Public License version 2.
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
