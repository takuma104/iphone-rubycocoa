#
#  $Id: tc_nsdata.rb 660 2003-08-09 14:28:02Z hisa $
#
#  Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
#
#  This program is free software.
#  You can distribute/modify this program under the terms of
#  the GNU Lesser General Public License version 2.
#

require 'test/unit'
require 'osx/cocoa'

class TC_NSData < Test::Unit::TestCase
  include OSX

  def test_s_data
    data = NSData.data
    assert( data.isKindOfClass(NSData) )
    assert_equal( 0, data.length )
    assert_kind_of( ObjcPtr, data.bytes )
  end

  def test_s_dataWithBytes_length
    src = "hello world"
    data = NSData.dataWithBytes( src, :length, src.size )
    assert( data.isKindOfClass(NSData) )
    assert_equal( src.size, data.length )
    assert_kind_of( ObjcPtr, data.bytes )
  end

  def test_s_dataWithContentsOfFile
    src = File.open('/etc/passwd').read
    data = NSData.dataWithContentsOfFile('/etc/passwd')
    assert( data.isKindOfClass(NSData) )
    assert_equal( src.size, data.length )
    assert_kind_of( ObjcPtr, data.bytes )
  end

  def test_s_dataWithContentsOfURL
    fpath = '/System/Library/Frameworks/Cocoa.framework/Headers/Cocoa.h'
    src = File.open(fpath).read
    url = NSURL.URLWithString "file://#{fpath}"
    data = NSData.dataWithContentsOfURL( url )
    assert( data.isKindOfClass(NSData) )
    assert_equal( src.size, data.length )
    assert_kind_of( ObjcPtr, data.bytes )
  end

  def test_s_dataWithData
    src = 'hello world'
    srcdata = NSData.dataWithBytes( src, :length, src.size )
    data = NSData.dataWithData( srcdata )
    assert( data.isKindOfClass(NSData) )
    assert_equal( src.size, data.length )
    assert_kind_of( ObjcPtr, data.bytes )
  end

  def test_s_dataWithRubyString
    src = 'hello world'
    data = NSData.dataWithRubyString( src )
    assert( data.isKindOfClass(NSData) )
    assert_equal( src.size, data.length )
    assert_kind_of( ObjcPtr, data.bytes )
  end

  def test_length
    src = 'hello world'
    data = NSData.dataWithRubyString( src )
    assert_equal( src.size, data.length )
  end

  def test_bytes
    src = 'hello world'
    data = NSData.dataWithRubyString( src )
    assert_equal( src, data.bytes.bytestr( src.size ))
    assert( data.bytes.tainted? )
  end

  def test_getBytes
    src = 'hello world'
    data = NSData.dataWithRubyString( src )
    cptr = ObjcPtr.new( src.size )
    data.getBytes( cptr )
    assert_equal( src, cptr.bytestr( src.size ))
    assert( cptr.tainted? )
  end

  # - (void)getBytes:(void *)buffer length:(unsigned)length;
  def test_getBytes_length
    src = 'hello world'
    data = NSData.dataWithRubyString( src )
    cptr = ObjcPtr.new( src.size )
    data.getBytes_length( cptr, src.size - 5 )
    assert_equal( src[0..-6], cptr.bytestr( src.size - 5 ))
    assert( cptr.tainted? )
  end

  # - (void)getBytes:(void *)buffer range:(NSRange)range;
  def test_getBytes_range
    src = 'hello world'
    data = NSData.dataWithRubyString( src )
    cptr = ObjcPtr.new( src.size )
    data.getBytes_range( cptr, 3..8 )
    assert_equal( src[3..8], cptr.bytestr( 8 - 3 + 1))
    assert( cptr.tainted? )
  end

  # - (BOOL)isEqualToData:(NSData *)other;
  def test_isEqualToData
    src = 'hello world'
    srcdata = NSData.dataWithRubyString( src )
    data = NSData.dataWithData( srcdata )
    assert( data.isEqualToData( srcdata ))
  end

  # - (NSData *)subdataWithRange:(NSRange)range;
  def test_subdataWithRange
    src = 'hello world'
    data = NSData.dataWithRubyString( src )
    subdata = data.subdataWithRange( 3..8 )
    assert_equal( 8 - 3 + 1, subdata.length )
  end

# - (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;
# - (BOOL)writeToURL:(NSURL *)url atomically:(BOOL)atomically; // the atomically flag is ignored if the url is not of a type the supports atomic writes

# - (void *)mutableBytes;
# - (void)setLength:(unsigned)length;

# - (void)appendBytes:(const void *)bytes length:(unsigned)length;
# - (void)appendData:(NSData *)other;
# - (void)increaseLengthBy:(unsigned)extraLength;
# - (void)replaceBytesInRange:(NSRange)range withBytes:(const void *)bytes;
# - (void)resetBytesInRange:(NSRange)range;
# - (void)setData:(NSData *)data;
# #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
# - (void)replaceBytesInRange:(NSRange)range withBytes:(const void *)replacementBytes length:(unsigned)replacementLength;

end
