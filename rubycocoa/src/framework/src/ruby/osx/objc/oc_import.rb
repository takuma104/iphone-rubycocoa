#
#  $Id: oc_import.rb 889 2005-11-07 14:20:21Z kimuraw $
#
#  Copyright (c) 2001 FUJIMOTO Hisakuni
#

require 'osx/objc/oc_wrapper'

module OSX

  # create Ruby's class for Cocoa class,
  # then define Constant under module 'OSX'.
  def ns_import(sym)
    if not OSX.const_defined?(sym) then
      const_name = sym.to_s
      sym_name = ":#{sym}"
      OSX.module_eval <<-EOE_NS_IMPORT,__FILE__,__LINE__+1
	clsobj = NSClassFromString(#{sym_name})
	rbcls = class_new_for_occlass(clsobj)
	#{const_name} = rbcls if rbcls
      EOE_NS_IMPORT
    end
  end
  module_function :ns_import

  # create Ruby's class for Cocoa class
  def OSX.class_new_for_occlass(occls)
    klass = Class.new(OSX::ObjcID)
    klass.class_eval <<-EOE_CLASS_NEW_FOR_OCCLASS,__FILE__,__LINE__+1
      include OCObjWrapper
      self.extend OCObjWrapper
      self.extend NSBehaviorAttachment
      @ocid = #{occls.__ocid__}
    EOE_CLASS_NEW_FOR_OCCLASS
    def klass.__ocid__() @ocid end
    def klass.to_s() name end
    def klass.inherited(subklass) subklass.ns_inherited() end
    return klass
  end

  module NSBehaviorAttachment

    ERRMSG_FOR_RESTRICT_NEW = "use 'alloc.initXXX' to instantiate Cocoa Object"

    # restrict creating an instance by Class#new of NSObject gruop.
    def new
      raise ERRMSG_FOR_RESTRICT_NEW
    end

    # initializer for definition of a derived class of a class on
    # Objective-C World.
    def ns_inherited()
      return if defined?(@inherited) && @inherited
      spr_name = superclass.name.split('::')[-1]
      kls_name = self.name.split('::')[-1]
      occls = OSX.objc_derived_class_new(self, kls_name, spr_name)
      self.instance_eval "@ocid = #{occls.__ocid__}",__FILE__,__LINE__+1
      include NSKeyValueCodingAttachment
      self.extend NSKVCBehaviorAttachment
      @inherited = true
    end

    # declare to override instance methods of super class which is
    # defined by Objective-C.
    def ns_overrides(*args)
      # In Ruby 1.8 (after 2002.9.27), this method may be called more
      # first than 'Class#inherited'.
      ns_inherited()

      # insert specified selectors to Objective-C method table.
      args.each do |name|
	name = name.to_s.gsub('_',':')
	OSX.objc_derived_class_method_add(self, name)
      end
    end

    # declare write-only attribute accessors which are named IBOutlet
    # in the Objective-C world.
    def ns_outlets(*args)
      attr_writer(*args)
    end

    # for look and feel
    alias_method :ns_override,  :ns_overrides
    alias_method :ib_override,  :ns_overrides
    alias_method :ib_overrides, :ns_overrides
    alias_method :ns_outlet,  :ns_outlets
    alias_method :ib_outlet,  :ns_outlets
    alias_method :ib_outlets, :ns_outlets

  end				# module OSX::NSBehaviorAttachment

  module NSKVCAccessorUtil
    private

    def kvc_internal_setter(key)
      return '_kvc_internal_' + key.to_s + '=' 
    end

    def kvc_setter_wrapper(key)
      return '_kvc_wrapper_' + key.to_s + '=' 
    end
  end				# module OSX::NSKVCAccessorUtil

  module NSKeyValueCodingAttachment
    include NSKVCAccessorUtil

    # invoked from valueForUndefinedKey: of a Cocoa object
    def rbValueForKey(key)
      if m = kvc_getter_method(key.to_s)
	return send(m)
      else
	kvc_accessor_notfound(key)
      end
    end

    # invoked from setValue:forUndefinedKey: of a Cocoa object
    def rbSetValue_forKey(value, key)
      if m = kvc_setter_method(key.to_s)
	willChangeValueForKey(key)
	send(m, value)
	didChangeValueForKey(key)
      else
	kvc_accessor_notfound(key)
      end
    end

    private
    
    # find accesor for key-value coding
    # "key" must be a ruby string

    def kvc_getter_method(key)
      [key, key + '?'].each do |m|
	return m if respond_to? m
      end
      return nil # accessor not found
    end
 
    def kvc_setter_method(key)
      [kvc_internal_setter(key), key + '='].each do |m|
	return m if respond_to? m
      end
      return nil
    end

    def kvc_accessor_notfound(key)
      fmt = '%s: this class is not key value coding-compliant for the key "%s"'
      raise sprintf(fmt, self.class, key.to_s)
    end

  end				# module OSX::NSKeyValueCodingAttachment

  module NSKVCBehaviorAttachment
    include NSKVCAccessorUtil

    def kvc_reader(*args)
      attr_reader(*args)
    end

    def kvc_writer(*args)
      args.flatten.each do |key|
	setter = key.to_s + '='
	attr_writer(key) unless method_defined?(setter)
	alias_method kvc_internal_setter(key), setter
	self.class_eval <<-EOE_KVC_WRITER,__FILE__,__LINE__+1
	  def #{kvc_setter_wrapper(key)}(value)
	    willChangeValueForKey('#{key.to_s}')
	    send('#{kvc_internal_setter(key)}', value)
	    didChangeValueForKey('#{key.to_s}')
	  end
	EOE_KVC_WRITER
	alias_method setter, kvc_setter_wrapper(key)
      end
    end

    def kvc_accessor(*args)
      kvc_reader(*args)
      kvc_writer(*args)
    end

    def kvc_depends_on(keys, *dependencies)
      dependencies.flatten.each do |dependentKey|
        setKeys_triggerChangeNotificationsForDependentKey(keys.to_a, dependentKey)
      end
    end
 
    # define accesor for keys defined in Cocoa, 
    # such as NSUserDefaultsController and NSManagedObject
    def kvc_wrapper(*keys)
      kvc_wrapper_reader(*keys)
      kvc_wrapper_writer(*keys)
    end

    def kvc_wrapper_reader(*keys)
      keys.flatten.compact.each do |key|
        class_eval <<-EOE_KVC_WRAPPER,__FILE__,__LINE__+1
    	def #{key}
  	  valueForKey("#{key}")
	end
  	EOE_KVC_WRAPPER
      end
    end

    def kvc_wrapper_writer(*keys)
      keys.flatten.compact.each do |key|
        class_eval <<-EOE_KVC_WRAPPER,__FILE__,__LINE__+1
	def #{key}=(val)
	  setValue_forKey(val, "#{key}")
	end
  	EOE_KVC_WRAPPER
      end
    end

    # Define accessors that send change notifications for an array.
    # The array instance variable must respond to the following methods:
    #
    #  length
    #  [index]
    #  [index]=
    #  insert(index,obj)
    #  delete_at(index)
    #
    # Notifications are only sent for accesses through the Cocoa methods:
    #  countOfKey, objectInKeyAtIndex_, insertObject_inKeyAtIndex_,
    #  removeObjectFromKeyAtIndex_, replaceObjectInKeyAtIndex_withObject_
    #
    def kvc_array_accessor(*args)
      args.each do |key|
	keyname = key.to_s
	keyname[0..0] = keyname[0..0].upcase
	self.addRubyMethod_withType("countOf#{keyname}".to_sym, "i4@8:12")
	self.addRubyMethod_withType("objectIn#{keyname}AtIndex:".to_sym, "@4@8:12i16")
	self.addRubyMethod_withType("insertObject:in#{keyname}AtIndex:".to_sym, "@4@8:12@16i20")
	self.addRubyMethod_withType("removeObjectFrom#{keyname}AtIndex:".to_sym, "@4@8:12i16")
	self.addRubyMethod_withType("replaceObjectIn#{keyname}AtIndex:withObject:".to_sym, "@4@8:12i16@20")
	# get%s:range: - unimplemented. You can implement this method for performance improvements.
	self.class_eval <<-EOT,__FILE__,__LINE__+1
	  def countOf#{keyname}()
	    return @#{key.to_s}.length
	  end

	  def objectIn#{keyname}AtIndex(index)
	    return @#{key.to_s}[index]
	  end

	  def insertObject_in#{keyname}AtIndex(obj, index)
	    indexes = OSX::NSIndexSet.indexSetWithIndex(index)
	    willChange_valuesAtIndexes_forKey(OSX::NSKeyValueChangeInsertion, indexes, #{key.inspect})
	    @#{key.to_s}.insert(index, obj)
	    didChange_valuesAtIndexes_forKey(OSX::NSKeyValueChangeInsertion, indexes, #{key.inspect})
	    nil
	  end

	  def removeObjectFrom#{keyname}AtIndex(index)
	    indexes = OSX::NSIndexSet.indexSetWithIndex(index)
	    willChange_valuesAtIndexes_forKey(OSX::NSKeyValueChangeRemoval, indexes, #{key.inspect})
	    @#{key.to_s}.delete_at(index)
	    didChange_valuesAtIndexes_forKey(OSX::NSKeyValueChangeRemoval, indexes, #{key.inspect})
	    nil
	  end

	  def replaceObjectIn#{keyname}AtIndex_withObject(index, obj)
	    indexes = OSX::NSIndexSet.indexSetWithIndex(index)
	    willChange_valuesAtIndexes_forKey(OSX::NSKeyValueChangeReplacement, indexes, #{key.inspect})
	    @#{key.to_s}[index] = obj
	    didChange_valuesAtIndexes_forKey(OSX::NSKeyValueChangeReplacement, indexes, #{key.inspect})
	    nil
	  end
	EOT
      end
    end

    # re-wrap at overriding setter method
    def method_added(sym)
      return unless sym.to_s =~ /\A([^=]+)=\z/
      key = $1
      setter = kvc_internal_setter(key)
      wrapper = kvc_setter_wrapper(key)
      return unless method_defined?(setter) && method_defined?(wrapper)
      return if instance_method(wrapper) == instance_method(sym)
      alias_method setter, sym
      alias_method sym, wrapper
    end

  end				# module OSX::NSKVCBehaviorAttachment

end				# module OSX
