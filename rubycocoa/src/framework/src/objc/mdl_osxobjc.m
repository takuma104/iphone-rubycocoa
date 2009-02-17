/** -*-objc-*-
 *
 *   $Id: mdl_osxobjc.m 841 2005-09-27 14:11:33Z kimuraw $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
 *
 *   This program is free software.
 *   You can distribute/modify this program under the terms of
 *   the GNU Lesser General Public License version 2.
 *
 **/

#import "mdl_osxobjc.h"
#import "osx_ruby.h"
#import <Foundation/Foundation.h>
#import "RubyCocoa.h"
#import "Version.h"
#import "RBThreadSwitcher.h"
#import "RBObject.h"
#import "RBClassUtils.h"
#import "ocdata_conv.h"
#import <mach-o/dyld.h>
#import <string.h>

#define OSX_MODULE_NAME "OSX"

static VALUE init_module_OSX()
{
  VALUE module;
  RB_ID id_osx = rb_intern(OSX_MODULE_NAME);

  if (rb_const_defined(rb_cObject, id_osx))
    module = rb_const_get(rb_cObject, id_osx);
  else
    module = rb_define_module(OSX_MODULE_NAME);
  return module;
}

// def OSX.objc_proxy_class_new (kls, kls_name)
// ex1.  OSX.objc_proxy_class_new (AA::BB::AppController, "AppController")
static VALUE
osx_mf_objc_proxy_class_new(VALUE mdl, VALUE kls, VALUE kls_name)
{
  kls_name = rb_obj_as_string(kls_name);
  RBObjcClassNew(kls, STR2CSTR(kls_name), [RBObject class]);
  return Qnil;
}

// def OSX.objc_derived_class_new (kls, kls_name, super_name)
// ex1.  OSX.objc_derived_class_new (AA::BB::CustomView, "CustomView", "NSView")
static VALUE
osx_mf_objc_derived_class_new(VALUE mdl, VALUE kls, VALUE kls_name, VALUE super_name)
{
  Class super_class;
  Class new_cls = nil;
  id pool = [[NSAutoreleasePool alloc] init];

  kls_name = rb_obj_as_string(kls_name);
  super_name = rb_obj_as_string(super_name);
  super_class = NSClassFromString([NSString 
				    stringWithUTF8String: STR2CSTR(super_name)]);
  if (super_class)
    new_cls = RBObjcDerivedClassNew(kls, STR2CSTR(kls_name), super_class);
  [pool release];

  if (new_cls)
    return ocobj_s_new(new_cls);
  return Qnil;
}

// def OSX.objc_derived_class_method_add (kls, method_name)
// ex1.  OSX.objc_derived_class_method_add (AA::BB::CustomView, "drawRect:")
static VALUE
osx_mf_objc_derived_class_method_add(VALUE mdl, VALUE kls, VALUE method_name)
{
  Class a_class;
  SEL a_sel;
  id pool = [[NSAutoreleasePool alloc] init];

  method_name = rb_obj_as_string(method_name);
  a_class = RBObjcClassFromRubyClass (kls);
  a_sel =
    NSSelectorFromString([NSString stringWithCString: STR2CSTR(method_name)]);
  if (a_class && a_sel) {
    [a_class addRubyMethod: a_sel];
  }
  [pool release];
  return Qnil;
}

static VALUE
osx_mf_ruby_thread_switcher_start(int argc, VALUE* argv, VALUE mdl)
{
  VALUE arg_interval, arg_wait;
  double interval, wait;

  rb_scan_args(argc, argv, "02", &arg_interval, &arg_wait);

  if (arg_interval == Qnil) {
    [RBThreadSwitcher start];
  }
  else {
    Check_Type(arg_interval, T_FLOAT);
    interval = RFLOAT(arg_interval)->value;

    if (arg_wait == Qnil) {
      [RBThreadSwitcher start: interval];
    }
    else {
      Check_Type(arg_wait, T_FLOAT);
      wait = RFLOAT(arg_wait)->value;
      [RBThreadSwitcher start: interval wait: wait];
    }
  }
  return Qnil;
}

static VALUE
osx_mf_ruby_thread_switcher_stop(VALUE mdl)
{
  [RBThreadSwitcher stop];
  return Qnil;
}

static VALUE
ns_autorelease_pool(VALUE mdl)
{
  id pool = [[NSAutoreleasePool alloc] init];
  rb_yield(Qnil);
  [pool release];
  return Qnil;
}

static void
thread_switcher_start()
{
  [RBThreadSwitcher start];
}

/******************/

static VALUE
rb_osx_const (const char* name)
{
  VALUE constant = Qnil;
  VALUE mOSX = osx_s_module();
  if (!mOSX) return Qnil;
  if (rb_const_defined(mOSX, rb_intern(name)))
    constant = rb_const_get(mOSX, rb_intern(name));
  return constant;
}

static VALUE
rb_cls_ocobj (const char* name)
{
  VALUE cls = rb_osx_const(name);
  if (cls == Qnil) cls = rb_osx_const("OCObject");
  return cls;
}

static id
rb_obj_ocid(VALUE rcv)
{
  VALUE val = rb_funcall(rcv, rb_intern("__ocid__"), 0);
  return NUM2OCID(val);
}

static VALUE
osx_mf_objc_symbol_to_obj(VALUE mdl, VALUE const_name, VALUE const_type)
{
    rb_raise(rb_eRuntimeError, "osx_mf_objc_symbol_to_obj not implemented.");
	return Qnil;
/*	
  VALUE result = Qnil;
  char buf[BUFSIZ];
  NSSymbol sym = NULL;
  void* addr = NULL;
  int octype;

  const_name = rb_obj_as_string(const_name);
  const_type = rb_obj_as_string(const_type);

  strncpy(buf+1, STR2CSTR(const_name), BUFSIZ - 1);
  buf[0] = '_';
  if (NSIsSymbolNameDefined(buf) == FALSE)
    rb_raise(rb_eRuntimeError, "symbol '%s' not found.", STR2CSTR(const_name));

  sym = NSLookupAndBindSymbol(buf);
  if (sym == NULL)
    rb_raise(rb_eRuntimeError, "symbol'%s' is NULL.", STR2CSTR(const_name));

  addr = NSAddressOfSymbol(sym);
  if (addr == NULL)
    rb_raise(rb_eRuntimeError, "address of '%s' is NULL.", STR2CSTR(const_name));

  octype = to_octype(STR2CSTR(const_type));
  if (!ocdata_to_rbobj(Qnil, octype, addr, &result))
    rb_raise(rb_eRuntimeError, "cannot convert to rbobj for type '%s'.", STR2CSTR(const_type));

  return result;
*/
}

static void
add_attachments(VALUE rcv, id ocid)
{
  VALUE attachment = Qnil;

  NS_DURING  
    if ([ocid isKindOfClass: [NSArray class]])
      attachment = rb_osx_const("RCArrayAttachment");

    else if ([ocid isKindOfClass: [NSDictionary class]])
      attachment = rb_osx_const("RCDictionaryAttachment");

    else if ([ocid isKindOfClass: [NSData class]])
      attachment = rb_osx_const("RCDataAttachment");
  NS_HANDLER
    attachment = Qnil;
  NS_ENDHANDLER

  if (attachment != Qnil)
    rb_extend_object(rcv, attachment);
}

/***/

VALUE
osx_s_module()
{
  RB_ID rid;

  rid = rb_intern("OSX");
  if (! rb_const_defined(rb_cObject, rid))
    return rb_define_module("OSX");
  return rb_const_get(rb_cObject, rid);
}

VALUE
ocobj_s_new(id ocid)
{
  VALUE obj;
  id pool, cls_name;

  pool = [[NSAutoreleasePool alloc] init];

  cls_name = [[ocid class] description];
  obj = rb_funcall(rb_cls_ocobj([cls_name UTF8String]), 
		   rb_intern("new_with_ocid"), 1, OCID2NUM(ocid));
  // add_attachments(obj, ocid);
  [pool release];
  return obj;
}

id
rbobj_get_ocid (VALUE obj)
{
  RB_ID mtd;

  if (rb_obj_is_kind_of(obj, objid_s_class()) == Qtrue)
    return rb_obj_ocid(obj);

  mtd = rb_intern("__ocid__");
  if (rb_respond_to(obj, mtd))
    return rb_obj_ocid(obj);

  if (rb_respond_to(obj, rb_intern("to_nsobj"))) {
    VALUE nso = rb_funcall(obj, rb_intern("to_nsobj"), 0);
    return rb_obj_ocid(nso);
  }

  return nil;
}

VALUE
ocid_get_rbobj (id ocid)
{
  VALUE result = Qnil;

  NS_DURING  
    if ([ocid isProxy] && [ocid isRBObject])
      result = [ocid __rbobj__];

    else if ([ocid respondsToSelector: @selector(__rbobj__)])
      result = [ocid __rbobj__];

  NS_HANDLER
    result = Qnil;

  NS_ENDHANDLER

  return result;
}

/******************/

void initialize_mdl_osxobjc()
{
  VALUE mOSX;
  extern void init_cocoa(VALUE);

  mOSX = init_module_OSX();
  init_cls_ObjcPtr(mOSX);
  init_cls_ObjcID(mOSX);
  init_mdl_OCObjWrapper(mOSX);

  rb_define_module_function(mOSX, "objc_proxy_class_new", 
			    osx_mf_objc_proxy_class_new, 2);
  rb_define_module_function(mOSX, "objc_derived_class_new", 
			    osx_mf_objc_derived_class_new, 3);
  rb_define_module_function(mOSX, "objc_derived_class_method_add",
			    osx_mf_objc_derived_class_method_add, 2);

  rb_define_module_function(mOSX, "ruby_thread_switcher_start",
			    osx_mf_ruby_thread_switcher_start, -1);
  rb_define_module_function(mOSX, "ruby_thread_switcher_stop",
			    osx_mf_ruby_thread_switcher_stop, 0);

  rb_define_module_function(mOSX, "ns_autorelease_pool",
			    ns_autorelease_pool, 0);

  rb_define_const(mOSX, "RUBYCOCOA_VERSION", 
		  rb_obj_freeze(rb_str_new2(RUBYCOCOA_VERSION)));
  rb_define_const(mOSX, "RUBYCOCOA_RELEASE_DATE", 
		  rb_obj_freeze(rb_str_new2(RUBYCOCOA_RELEASE_DATE)));

  rb_define_module_function(mOSX, "objc_symbol_to_obj", osx_mf_objc_symbol_to_obj, 2);

 init_cocoa(mOSX);
 thread_switcher_start();
}
