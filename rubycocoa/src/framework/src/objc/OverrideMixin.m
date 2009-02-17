/** -*-objc-*-
 *
 *   $Id: OverrideMixin.m 843 2005-10-04 12:04:03Z kimuraw $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
 *
 *   This program is free software.
 *   You can distribute/modify this program under the terms of
 *   the GNU Lesser General Public License version 2.
 *
 **/
#import <stdarg.h>
#import "OverrideMixin.h"
#import "RBObject.h"
#import "RBSlaveObject.h"
#import "RBRuntime.h"
#import "RBClassUtils.h"
#import "ocdata_conv.h"

#define sel_to_s(a) NSStringFromSelector((a))

#if 0
#  define LOG0(f)
#  define LOG1(f,a0)
#  define LOG2(f,a0,a1)
#  define LOG3(f,a0,a1,a2)
#else
#  define LOG0(f)          NSLog((f))
#  define LOG1(f,a0)       NSLog((f),(a0))
#  define LOG2(f,a0,a1)    NSLog((f),(a0),(a1))
#  define LOG3(f,a0,a1,a2) NSLog((f),(a0),(a1),(a2))
#endif

static void* alloc_from_default_zone(unsigned int size)
{
  return NSZoneMalloc(NSDefaultMallocZone(), size);
}

static SEL super_selector(SEL a_sel)
{
  id pool;
  NSString* str;

  pool = [[NSAutoreleasePool alloc] init];
  str = [@"super:" stringByAppendingString: NSStringFromSelector(a_sel)];
  a_sel = NSSelectorFromString(str);
  [pool release];
  return a_sel;
}

static IMP super_imp(id rcv, SEL a_sel, IMP origin_imp)
{
  IMP ret = NULL;
  Class klass = [rcv class];

  while (klass = [klass superclass]) {
    ret = [klass instanceMethodForSelector: a_sel];
    if (ret && ret != origin_imp)
      return ret;
  }
  return NULL;
}

static id slave_obj_new(id rcv)
{
  return [[RBObject alloc] initWithClass: [rcv class] masterObject: rcv];
}

/**
 *  accessor for instance variables
 **/

static void set_slave(id rcv, id slave)
{
  object_setInstanceVariable(rcv, "m_slave", slave);
}

static id get_slave(id rcv)
{
  id ret;
  object_getInstanceVariable(rcv, "m_slave", (void*)(&ret));
  return ret;
}

/**
 * ruby method handler
 **/

static id handle_ruby_method(id rcv, SEL a_sel, ...)
{
  id ret = nil;
  Method method;
  unsigned  argc, i;
  NSMethodSignature* msig;
  NSInvocation* inv;
  va_list args;
  unsigned retlen;

  // prepare
  msig = [rcv methodSignatureForSelector: a_sel];
  inv = [NSInvocation invocationWithMethodSignature: msig];
  method = class_getInstanceMethod([rcv class], a_sel);
  argc = method_getNumberOfArguments(method);

  // set argument
  va_start(args, a_sel);

  for (i = 2; i < argc; i++) {
    unsigned int size;
    unsigned int align;
    const char* type;
    int offset;
	
    method_getArgumentInfo(method, i, &type, &offset);

    [inv setArgument: args atIndex: i];

    NSGetSizeAndAlignment( type, &size, &align );
    args += align;
  }

  // invoke
  [inv setTarget: [rcv __slave__]];
  [inv setSelector: a_sel];
  [inv invoke];

  // result
  retlen = [msig methodReturnLength];
  if ( retlen > 0) {
    if (retlen < sizeof(ret)) {
      void* data = alloca(retlen);
      [inv getReturnValue: data];
      if (retlen == sizeof(char))
	ret = (id)(unsigned long)(*(unsigned char*)data);
      else if (retlen == sizeof(short))
	ret = (id)(unsigned long)(*(unsigned short*)data);
      else
	rb_raise( rb_eRuntimeError,
		  "handle_ruby_method('%s'): can't handle the return value!",
		  (char*)a_sel);
    }
    else if (retlen == sizeof(ret)) {
      [inv getReturnValue: &ret];
    }
    else {
      // should we raise an error here, because we can't handle the
      // return value properly?
      rb_raise( rb_eRuntimeError,
		"handle_ruby_method('%s'): can't handle the return value!",
		(char*)a_sel);
    }
  }

  va_end(args);
  return ret;
}

/**
 * instance methods implementation
 **/

static id imp_slave (id rcv, SEL method)
{
  return get_slave(rcv);
}

static id imp_rbobj (id rcv, SEL method)
{
  id slave = get_slave(rcv);
  VALUE rbobj = [slave __rbobj__];
  return (id)rbobj;
}

static id imp_respondsToSelector (id rcv, SEL method, SEL arg0)
{
  id ret;
  IMP simp = super_imp(rcv, method, (IMP)imp_respondsToSelector);
  id slave = get_slave(rcv);
  ret = (*simp)(rcv, method, arg0);
  if (ret == NULL)
    ret = (id)([slave respondsToSelector: arg0] != nil ? YES : NO);
  return ret;
}

static id imp_methodSignatureForSelector (id rcv, SEL method, SEL arg0)
{
  id ret;
  IMP simp = super_imp(rcv, method, (IMP)imp_methodSignatureForSelector);
  id slave = get_slave(rcv);
  ret = (*simp)(rcv, method, arg0);
  if (ret == nil)
    ret = [slave methodSignatureForSelector: arg0];
  return ret;
}

static id imp_forwardInvocation (id rcv, SEL method, NSInvocation* arg0)
{
  IMP simp = super_imp(rcv, method, (IMP)imp_forwardInvocation);
  id slave = get_slave(rcv);

  if ([slave respondsToSelector: [arg0 selector]])
    [slave forwardInvocation: arg0];
  else
    (*simp)(rcv, method, arg0);
  return nil;
}

static id imp_valueForUndefinedKey (id rcv, SEL method, NSString* key)
{
  id ret = nil;
  id slave = get_slave(rcv);

  if ([slave respondsToSelector: @selector(rbValueForKey:)])
    ret = (id)[rcv performSelector: @selector(rbValueForKey:) withObject: key];
  else
    ret = [rcv performSelector: super_selector(method) withObject: key];
  return ret;
}

static void imp_setValue_forUndefinedKey (id rcv, SEL method, id value, NSString* key)
{
  id slave = get_slave(rcv);

  if ([slave respondsToSelector: @selector(rbSetValue:forKey:)])
    [slave performSelector: @selector(rbSetValue:forKey:) withObject: value withObject: key];
  else
    [rcv performSelector: super_selector(method) withObject: value withObject: key];
}

/**
 * class methods implementation
 **/
static id imp_c_alloc(Class klass, SEL method)
{
  id new_obj;
  id slave;
  new_obj = class_createInstance(klass, 0);
  slave = slave_obj_new(new_obj);
  set_slave(new_obj, slave);
  return new_obj;
}

static id imp_c_allocWithZone(Class klass, SEL method, NSZone* zone)
{
  id new_obj;
  id slave;
  new_obj = class_createInstanceFromZone(klass, 0, zone);
  slave = slave_obj_new(new_obj);
  set_slave(new_obj, slave);
  return new_obj;
}

static id imp_c_addRubyMethod(Class klass, SEL method, SEL arg0)
{
	rb_raise( rb_eRuntimeError, 
			 "Not implemented: imp_c_addRubyMethod");
	return nil;
}

static id imp_c_addRubyMethod_withType(Class klass, SEL method, SEL arg0, const char *type)
{
  class_addMethod(klass, arg0, (IMP)handle_ruby_method, strdup(type));
  return nil;
}

struct objc_ivar {
    char *ivar_name                                          OBJC2_UNAVAILABLE;
    char *ivar_type                                          OBJC2_UNAVAILABLE;
    int ivar_offset                                          OBJC2_UNAVAILABLE;
#ifdef __LP64__
    int space                                                OBJC2_UNAVAILABLE;
#endif
}                                                            OBJC2_UNAVAILABLE;

static struct objc_ivar imp_ivars[] = {
  {				// struct objc_ivar {
    "m_slave",			//   char *ivar_name;
    "@",			//   char *ivar_type;
    0,				//    int ivar_offset;
#ifdef __alpha__
    0				//    int space;
#endif
  }                             // } ivar_list[1];
};

/**
 *  instance methods
 **/
static const char* imp_method_names[] = {
  "__slave__",
  "__rbobj__",
  "respondsToSelector:",
  "methodSignatureForSelector:",
  "forwardInvocation:",
  "valueForUndefinedKey:",
  "setValue:forUndefinedKey:",
};

struct objc_method {
    SEL method_name                                          OBJC2_UNAVAILABLE;
    char *method_types                                       OBJC2_UNAVAILABLE;
    IMP method_imp                                           OBJC2_UNAVAILABLE;
}                                                            OBJC2_UNAVAILABLE;

static struct objc_method imp_methods[] = {
  { NULL,
    "@4@4:8",
    (IMP)imp_slave 
  },
  { NULL,
    "L4@4:8",
    (IMP)imp_rbobj 
  },
  { NULL,
    "c8@4:8:12",
    (IMP)imp_respondsToSelector
  },
  { NULL,
    "@8@4:8:12",
    (IMP)imp_methodSignatureForSelector
  },
  { NULL,
    "v8@4:8@12",
    (IMP)imp_forwardInvocation
  },
  { NULL,
    "@12@0:4@8",
    (IMP)imp_valueForUndefinedKey
  },
  { NULL,
    "v16@0:4@8@12",
    (IMP)imp_setValue_forUndefinedKey
  },
};


/**
 *  class methods
 **/
static const char* imp_c_method_names[] = {
  "alloc",
  "allocWithZone:",
  "addRubyMethod:",
  "addRubyMethod:withType:",
};

static struct objc_method imp_c_methods[] = {
  { NULL,
    "@4@4:8",
    (IMP)imp_c_alloc
  },
  { NULL,
    "@8@4:8^{_NSZone=}12",
    (IMP)imp_c_allocWithZone
  },
  { NULL,
    "@4@4:8:12",
    (IMP)imp_c_addRubyMethod
  },
  { NULL,
    "@4@4:8:12*16",
    (IMP)imp_c_addRubyMethod_withType
  }
};
/*
long override_mixin_ivar_list_size()
{
  long cnt = sizeof(imp_ivars) / sizeof(struct objc_ivar);
  return (sizeof(struct objc_ivar_list)
	  - sizeof(struct objc_ivar)
	  + (cnt * sizeof(struct objc_ivar)));
}

struct objc_ivar_list* override_mixin_ivar_list()
{
  static struct objc_ivar_list* imp_ilp = NULL;
  if (imp_ilp == NULL) {
    int i;
    imp_ilp = alloc_from_default_zone(override_mixin_ivar_list_size());
    imp_ilp->ivar_count = sizeof(imp_ivars) / sizeof(struct objc_ivar);
    for (i = 0; i < imp_ilp->ivar_count; i++) {
      memcpy(&imp_ilp->ivar_list[i], &imp_ivars[i], sizeof(struct objc_ivar));
    }
  }
  return imp_ilp;
}
*/
void install_method_list(Class c)
{
    long cnt = sizeof(imp_methods) / sizeof(struct objc_method);
	int i;
	for (i = 0; i < cnt; i++) {
		SEL sel = sel_registerName(imp_method_names[i]);
		IMP imp = imp_methods[i].method_imp;
		const char *type = imp_methods[i].method_types;
		class_addMethod(c, sel, imp, type);
    }
}

void install_class_method_list(Class c)
{
    int i;
    long cnt = sizeof(imp_c_methods) / sizeof(struct objc_method);
    for (i = 0; i < cnt; i++) {
		SEL sel = sel_registerName(imp_c_method_names[i]);
		IMP imp = imp_c_methods[i].method_imp;
		const char *type = imp_c_methods[i].method_types;
		class_addMethod(c->isa, sel, imp, type);
    }
}