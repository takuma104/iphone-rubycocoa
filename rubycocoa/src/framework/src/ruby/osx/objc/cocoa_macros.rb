#
#  $Id: cocoa_macros.rb 836 2005-09-18 17:18:47Z kimuraw $
#
#  Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
#
#  This program is free software.
#  You can distribute/modify this program under the terms of
#  the GNU Lesser General Public License version 2.
#

require 'osx/objc/foundation'
require 'osx/objc/appkit'
require 'nkf'

module OSX

  # from NSBundle
  def NSLocalizedString (key, comment = nil)
    OSX::NSBundle.mainBundle.
      localizedStringForKey_value_table(key, "", nil)
  end
  def NSLocalizedStringFromTable (key, tbl, comment = nil)
    OSX::NSBundle.mainBundle.
      localizedStringForKey_value_table(key, "", tbl)
  end
  def NSLocalizedStringFromTableInBundle (key, tbl, bundle, comment = nil)
    bundle.localizedStringForKey_value_table(key, "", tbl)
  end
  module_function :NSLocalizedStringFromTableInBundle
  module_function :NSLocalizedStringFromTable
  module_function :NSLocalizedString

  # for NSData
  class NSData

    def NSData.dataWithRubyString (str)
      NSData.dataWithBytes_length( str, str.size )
    end

  end

  # for NSMutableData
  class NSMutableData

    def NSMutableData.dataWithRubyString (str)
      NSMutableData.dataWithBytes_length( str, str.size )
    end

  end

  # for NSString
  class NSString

    def NSString.guess_nsencoding(rbstr)
      case NSString.guess_encoding(rbstr)
      when NKF::JIS then NSISO2022JPStringEncoding
      when NKF::EUC then NSJapaneseEUCStringEncoding
      when NKF::SJIS then NSShiftJISStringEncoding
      else NSProprietaryStringEncoding
      end
    end

    def NSString.guess_encoding(rbstr)
      NKF.guess(rbstr)
    end

    # NKF.guess fails on ruby-1.8.2
    if NKF.respond_to?('guess1') && NKF::NKF_VERSION == "2.0.4"
      def NSString.guess_encoding(rbstr)
        NKF.guess1(rbstr)
      end
    end

    def NSString.stringWithRubyString (str)
      data = NSData.dataWithRubyString( str )
      enc = guess_nsencoding( str )
      NSString.alloc.initWithData_encoding( data, enc )
    end

  end

  # for NSMutableString
  class NSMutableString
    def NSMutableString.stringWithRubyString (str)
      data = NSData.dataWithRubyString( str )
      enc = NSString.guess_nsencoding( str )
      NSMutableString.alloc.initWithData_encoding( data, enc )
    end
  end

end
