/** -*-objc-*-
 *
 *   $Id: mdl_objwrapper.m 826 2005-08-10 12:56:27Z kimuraw $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
 *
 *   This program is free software.
 *   You can distribute/modify this program under the terms of
 *   the GNU Lesser General Public License version 2.
 *
 **/

#import "osx_ruby.h"
#import "ocdata_conv.h"
#import "mdl_osxobjc.h"
#import <Foundation/Foundation.h>
#import <string.h>
#import <stdlib.h>
#import <stdarg.h>

static VALUE _mObjWrapper = Qnil;

#define DLOG0(f)          if (ruby_debug == Qtrue) _debug_log((f))
#define DLOG1(f,a1)       if (ruby_debug == Qtrue) _debug_log((f),(a1))
#define DLOG2(f,a1,a2)    if (ruby_debug == Qtrue) _debug_log((f),(a1),(a2))
#define DLOG3(f,a1,a2,a3) if (ruby_debug == Qtrue) _debug_log((f),(a1),(a2),(a3))

static void
_debug_log(const char* fmt,...)
{
  if (ruby_debug == Qtrue) {
    id pool = [[NSAutoreleasePool alloc] init];
    NSString* nsfmt = [NSString stringWithFormat: @"OBJWRP:%s", fmt];
    va_list args;
    va_start(args, fmt);
    NSLogv(nsfmt, args);
    va_end(args);
    [pool release];
  }
}

static VALUE
_oc_exception_class(const char* name)
{
  VALUE mosx = rb_const_get(rb_cObject, rb_intern("OSX"));;
  return rb_const_get(mosx, rb_intern(name));
}

static VALUE
_oc_exception_new(VALUE exc, id rcv, SEL sel, const char *fmt, va_list args)
{
  char buf_a[BUFSIZ];
  char buf_b[BUFSIZ];
  snprintf(buf_a, BUFSIZ, "%s#%s - %s", rcv->isa->name, (char*)sel, fmt);
  vsnprintf(buf_b, BUFSIZ, buf_a, args);
  return rb_exc_new2(exc, buf_b);
}

static VALUE
oc_err_new(id rcv, SEL sel, NSException* nsexcp)
{
  id pool;
  char buf[BUFSIZ];
  static VALUE klass = Qnil;

  if ([[nsexcp name] hasPrefix: @"RBException_"]) {
      // This is a wrapped Ruby exception
      id rberr = [[nsexcp userInfo] objectForKey: @"$!"];
      if (rberr) {
          VALUE err = ocid_get_rbobj(rberr);
          if (err != Qnil)
              return err;
      }
  }
  
  if (klass == Qnil) klass = _oc_exception_class ("OCException");
  pool = [[NSAutoreleasePool alloc] init];
  snprintf(buf, BUFSIZ, "%s#%s - %s - %s",
	   rcv->isa->name, (char*)sel, [[nsexcp name] UTF8String], [[nsexcp reason] UTF8String]);
  [pool release];
  return rb_funcall(klass, rb_intern("new"), 2, ocid_to_rbobj(Qnil, nsexcp), rb_str_new2(buf));
}

static VALUE
ocdataconv_err_new(id rcv, SEL sel, const char *fmt, ...)
{
  va_list args;
  VALUE ret;
  static VALUE klass = Qnil;

  if (klass == Qnil) klass = _oc_exception_class ("OCDataConvException");
  va_start(args,fmt);
  ret = _oc_exception_new (klass, rcv, sel, fmt, args);
  va_end(args);
  return ret;
}

static VALUE
ocmsend_err_new(id rcv, SEL sel, const char *fmt, ...)
{
  va_list args;
  VALUE ret;
  static VALUE klass = Qnil;

  if (klass == Qnil) klass = _oc_exception_class ("OCMessageSendException");
  va_start(args,fmt);
  ret = _oc_exception_new (klass, rcv, sel, fmt, args);
  va_end(args);
  return ret;
}

static VALUE
ocm_perform(int argc, VALUE* argv, VALUE rcv, VALUE* result)
{
  id oc_rcv = rbobj_get_ocid(rcv);
  SEL oc_sel;
  id oc_sel_str;
  const char* ret_type;
  int num_of_args;
  id args[2];
  id pool;
  id oc_result = nil;
  id oc_msig;
  int i;
  VALUE excp = Qnil;

  if (oc_rcv == nil) return ocmsend_err_new (nil, NULL, "receiver is nil.");

  if ((argc < 1) || (argc > 3))
    return ocmsend_err_new (oc_rcv, NULL, "require 0 to 2 arguments.");

  oc_sel = rbobj_to_nssel(argv[0]);
  argc--;
  argv++;

  oc_msig = [oc_rcv methodSignatureForSelector: oc_sel];
  if (oc_msig == nil)
    return ocmsend_err_new (oc_rcv, oc_sel, "methodSignature is nil.");

  ret_type = [oc_msig methodReturnType];
  if (*ret_type != _C_ID && *ret_type != _C_CLASS)
    return ocmsend_err_new (oc_rcv, oc_sel, "return type is not Object. (%s)", ret_type);

  num_of_args = [oc_msig numberOfArguments] - 2;
  if (num_of_args > 2)
    return ocmsend_err_new (oc_rcv, oc_sel, "numberOfArguments is bigger than 2");

  pool = [[NSAutoreleasePool alloc] init];
  oc_sel_str = NSStringFromSelector(oc_sel);
  DLOG2("ocm_perform (%@): ret_type=%s", oc_sel_str, ret_type);

  for (i = 0; i < num_of_args; i++) {
    const char* arg_type = [oc_msig getArgumentTypeAtIndex: (i+2)];
    DLOG2("    arg_type[%d]: %s", i, arg_type);
    if (*arg_type != _C_ID && *arg_type != _C_CLASS)
      return ocmsend_err_new
	(oc_rcv, oc_sel, "argument[%d] type is not Object. (%s)", i, arg_type);
    args[i] = nil;
    if (i < argc) {
      if (!rbobj_to_nsobj(argv[i], &(args[i]))) {
	[pool release];
	return ocdataconv_err_new 
	  (oc_rcv, oc_sel, "cannot convert the argument[%d] as '%s' to NSObject.", i, arg_type);
      }
    }
  }

  DLOG3("    %@#performSelector (%@) num_of_args=%d...", oc_rcv, oc_sel_str, num_of_args);

  NS_DURING  
    switch (num_of_args) {
    case 0:
      oc_result = [oc_rcv performSelector: oc_sel];
      break;
    case 1:
      oc_result = [oc_rcv performSelector: oc_sel withObject: args[0]];
      break;
    case 2:
      oc_result = [oc_rcv performSelector: oc_sel withObject: args[0]
			  withObject: args[1]];
      break;
    default:
      oc_result = nil;
    }

  NS_HANDLER
    DLOG2("    NSObject#performSelector (%@): raise %@",
	  oc_sel_str, localException);
    excp = oc_err_new (oc_rcv, oc_sel, localException);

  NS_ENDHANDLER
  if (excp != Qnil) return excp;
  
  DLOG1("    NSObject#performSelector (%@): done.", oc_sel_str);

  if (oc_result == oc_rcv)
    *result = rcv;
  else
    *result = ocid_to_rbobj(rcv, oc_result);

  [pool release];
  return Qnil;
}

static VALUE
ocm_invoke(int argc, VALUE* argv, VALUE rcv, VALUE* result)
{
  id oc_rcv = rbobj_get_ocid(rcv);
  SEL oc_sel;
  id oc_sel_str;
  const char* ret_type;
  int num_of_args;
  id pool;
  id oc_msig;
  id oc_inv;
  int i;
  unsigned ret_len;
  VALUE excp = Qnil;

  if (oc_rcv == nil) return ocmsend_err_new (nil, NULL, "receiver is nil.");

  if (argc < 1) return ocmsend_err_new (oc_rcv, NULL, "argc is less than 1.");

  oc_sel = rbobj_to_nssel(argv[0]);
  argc--;
  argv++;

  oc_msig = [oc_rcv methodSignatureForSelector: oc_sel];
  if (oc_msig == nil)
    return ocmsend_err_new (oc_rcv, oc_sel, "methodSignature is nil.");

  ret_type = [oc_msig methodReturnType];
  num_of_args = [oc_msig numberOfArguments] - 2;

  pool = [[NSAutoreleasePool alloc] init];
  oc_sel_str = NSStringFromSelector(oc_sel);
  DLOG2("ocm_invoke (%@): ret_type=%s", oc_sel_str, ret_type);

  oc_inv = [NSInvocation invocationWithMethodSignature: oc_msig];
  [oc_inv setTarget: oc_rcv];
  [oc_inv setSelector: oc_sel];

  // set arguments
  for (i = 0; i < num_of_args; i++) {
    VALUE arg = (i < argc) ? argv[i] : Qnil;
    const char* octype_str = [oc_msig getArgumentTypeAtIndex: (i+2)];
    int octype = to_octype(octype_str);
    void* ocdata;
    DLOG2("    arg_type[%d]: %s", i, octype_str);
    ocdata = OCDATA_ALLOCA(octype, octype_str);
    if (rbobj_to_ocdata(arg, octype, ocdata)) {
      [oc_inv setArgument: ocdata atIndex: (i+2)];
    }
    else {
      [pool release];
      return ocdataconv_err_new 
	(oc_rcv, oc_sel, "cannot convert the argument #%d as '%s' to NS argument.", i, octype_str);
    }
  }

  DLOG1("    NSInvocation#invoke (%@) ...", oc_sel_str);
  NS_DURING
    [oc_inv invoke];

  NS_HANDLER
    DLOG2("    NSInvocation#invoke (%@): raise %@", oc_sel_str, localException);
    excp = oc_err_new (oc_rcv, oc_sel, localException);

  NS_ENDHANDLER
  if (excp != Qnil) return excp;

  DLOG1("    NSInvocation#invoke (%@): done.", oc_sel_str);

  // get result as argument
  for (i = 0; i < num_of_args; i++) {
    VALUE arg = argv[i];
    if (arg == Qnil) continue;
    if (rb_obj_is_kind_of(arg, objid_s_class()) != Qtrue) continue;
    if (to_octype([oc_msig getArgumentTypeAtIndex: (i+2)]) != _PRIV_C_ID_PTR) continue;
    if (OBJCID_ID(arg))
      [OBJCID_ID(arg) retain];
  }

  // get result
  ret_len = [oc_msig methodReturnLength];
  if (ret_len > 0) {
    int octype = to_octype([oc_msig methodReturnType]);
    BOOL f_conv_success;
    void* result_data = alloca(ret_len);
    [oc_inv getReturnValue: result_data];
    f_conv_success = ocdata_to_rbobj(rcv, octype, result_data, result);
    if (!f_conv_success) {
      [pool release];
      return ocdataconv_err_new 
	(oc_rcv, oc_sel, "cannot convert the result as '%s' to Ruby Object.", ret_type);
    }
  }
  else {
    *result = Qnil;
  }

  [pool release];
  return Qnil;
}

static VALUE
ocm_send(int argc, VALUE* argv, VALUE rcv, VALUE* result)
{
  VALUE exc;
  if (argc < 1) return Qnil;

  DLOG0("ocm_send ...");

  exc = ocm_perform(argc, argv, rcv, result);
  if (exc != Qnil) {
    exc = ocm_invoke(argc, argv, rcv, result);
    if (exc != Qnil) return exc;
  }

  DLOG0("ocm_send done");

  return exc;
}

/*************************************************/

static VALUE
wrapper_ocm_responds_p(VALUE rcv, VALUE sel)
{
  id oc_rcv = rbobj_get_ocid(rcv);
  SEL oc_sel = rbobj_to_nssel(sel);
  return [oc_rcv respondsToSelector: oc_sel] ? Qtrue : Qfalse;
}

static VALUE
wrapper_ocm_perform(int argc, VALUE* argv, VALUE rcv)
{
  VALUE result;
  VALUE exc;
  exc = ocm_perform(argc, argv, rcv, &result);
  if (exc != Qnil) rb_exc_raise (exc);
  return result;
}

static VALUE
wrapper_ocm_invoke(int argc, VALUE* argv, VALUE rcv)
{
  VALUE result;
  VALUE exc;
  exc = ocm_invoke(argc, argv, rcv, &result);
  if (exc != Qnil) rb_exc_raise (exc);
  return result;
}

static VALUE
wrapper_ocm_send(int argc, VALUE* argv, VALUE rcv)
{
  VALUE result;
  VALUE exc;
  exc = ocm_send(argc, argv, rcv, &result);
  if (exc != Qnil) rb_exc_raise (exc);
  return result;
}

static VALUE
wrapper_to_s (VALUE rcv)
{
  VALUE ret;
  id oc_rcv;
  id pool;

  pool = [[NSAutoreleasePool alloc] init];
  oc_rcv = rbobj_get_ocid(rcv);
  if ([oc_rcv isKindOfClass: [NSString class]] == NO)
    oc_rcv = [oc_rcv description];
  ret = ocstr_to_rbstr(oc_rcv);
  [pool release];
  return ret;
}

static void
_ary_push_objc_methods (VALUE ary, Class cls)
{
  struct objc_method_list** list;
  int i, cnt;
  struct objc_method* methods;

  list = cls->methodLists;
  while (*list && *list != (struct objc_method_list*)-1) {
    cnt = (*list)->method_count;
    methods = (*list)->method_list;
    for (i = 0; i < cnt; i++) {
      rb_ary_push (ary, rb_str_new2((const char*)(methods[i].method_name)));
    }
    list++;
  }
  if (cls->super_class)
    _ary_push_objc_methods (ary, cls->super_class);
  rb_funcall(ary, rb_intern("uniq!"), 0);
}

static VALUE
wrapper_objc_methods (VALUE rcv)
{
  VALUE ary;
  id oc_rcv;

  ary = rb_ary_new();
  oc_rcv = rbobj_get_ocid (rcv);
  _ary_push_objc_methods (ary, oc_rcv->isa);
  return ary;
}

static const char*
_objc_method_type (Class cls, const char* name)
{
  struct objc_method_list** list;
  int i, cnt;
  struct objc_method* methods;

  list = cls->methodLists;
  while (*list && *list != (struct objc_method_list*)-1) {
    cnt = (*list)->method_count;
    methods = (*list)->method_list;
    for (i = 0; i < cnt; i++) {
      if (strcmp ((const char*)(methods[i].method_name), name) == 0) {
	return methods[i].method_types;
      }
    }
    list++;
  }
  if (cls->super_class)
    return _objc_method_type (cls->super_class, name);
  return NULL;
}

static VALUE
_name_to_selstr (VALUE name)
{
  VALUE re;
  const char* patstr = "([^^])_";
  const char* repstr = "\\1:";

  name = rb_obj_as_string (name);
  re = rb_reg_new (patstr, strlen(patstr), 0);
  rb_funcall (name, rb_intern("gsub!"), 2, re, rb_str_new2(repstr));
  return name;
}

static VALUE
wrapper_objc_method_type (VALUE rcv, VALUE name)
{
  VALUE ary;
  id oc_rcv;
  const char* str;

  ary = rb_ary_new();
  oc_rcv = rbobj_get_ocid (rcv);
  name = _name_to_selstr (name);
  str = _objc_method_type (oc_rcv, STR2CSTR(name));
  if (str == NULL) return Qnil;
  return rb_str_new2(str);
}

/*****************************************/

VALUE
init_mdl_OCObjWrapper(VALUE outer)
{
  _mObjWrapper = rb_define_module_under(outer, "OCObjWrapper");

  rb_define_method(_mObjWrapper, "ocm_responds?", wrapper_ocm_responds_p, 1);
  rb_define_method(_mObjWrapper, "ocm_perform", wrapper_ocm_perform, -1);
  rb_define_method(_mObjWrapper, "ocm_invoke", wrapper_ocm_invoke, -1);
  rb_define_method(_mObjWrapper, "ocm_send", wrapper_ocm_send, -1);
  rb_define_method(_mObjWrapper, "to_s", wrapper_to_s, 0);

  rb_define_method(_mObjWrapper, "objc_methods", wrapper_objc_methods, 0);
  rb_define_method(_mObjWrapper, "objc_method_type", wrapper_objc_method_type, 1);

  return _mObjWrapper;
}
