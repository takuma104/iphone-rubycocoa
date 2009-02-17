#
#  $Id: oc_attachments.rb 617 2003-01-15 09:43:42Z hisa $
#
#  Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
#
#  This program is free software.
#  You can distribute/modify this program under the terms of
#  the GNU Lesser General Public License version 2.
#

module OSX

  # attachment module for NSArray group
  module RCArrayAttachment
    include Enumerable

    def each
      iter = self.objectEnumerator
      while obj = iter.nextObject do
	yield(obj)
      end
      self
    end

    def size
      self.count
    end

    def [] (index)
      index = self.count + index if index < 0
      self.objectAtIndex(index)
    end

    def []= (index, obj)
      index = self.count + index if index < 0
      self.replaceObjectAtIndex_withObject(index, obj)
      obj
    end

    def push (obj)
      self.addObject(obj)
    end

  end				# module RCArrayAttachment


  # attachment module for NSDictionary group
  module RCDictionaryAttachment
    include Enumerable

    def each
      iter = self.keyEnumerator
      while key = iter.nextObject do
	yield(key, self.objectForKey(key))
      end
      self
    end

    def size
      self.count
    end

    def keys
      self.allKeys.to_a
    end

    def values
      self.allValues.to_a
    end

    def [] (key)
      self.objectForKey(key)
    end

    def []= (key, obj)
      self.setObject_forKey(obj, key)
      obj
    end

  end				# module RCDictionaryAttachment


  # attachment module for NSData group
  module RCDataAttachment

    def rubyString
      cptr = self.bytes
      return cptr.bytestr( self.length )
    end

  end


  # attachment module for NSImage group
  module RCImageAttachment
    def focus
      lockFocus
      yield
      unlockFocus
    end
  end

end
