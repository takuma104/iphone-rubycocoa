/** -*-objc-*-
 *
 *   $Id: RBObject.m 979 2006-05-29 01:18:25Z hisa $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni
 *
 **/
#import <Foundation/Foundation.h>
#import <ctype.h>
#import "RBObject.h"
#import "mdl_osxobjc.h"
#import "ocdata_conv.h"
#import "DummyProtocolHandler.h"

#if 1
#  define DLOG0(f)          if (ruby_debug == Qtrue) debug_log((f))
#  define DLOG1(f,a1)       if (ruby_debug == Qtrue) debug_log((f),(a1))
#  define DLOG2(f,a1,a2)    if (ruby_debug == Qtrue) debug_log((f),(a1),(a2))
#  define DLOG3(f,a1,a2,a3) if (ruby_debug == Qtrue) debug_log((f),(a1),(a2),(a3))
#else
#  define DLOG0(f)          debug_log((f))
#  define DLOG1(f,a1)       debug_log((f),(a1))
#  define DLOG2(f,a1,a2)    debug_log((f),(a1),(a2))
#  define DLOG3(f,a1,a2,a3) debug_log((f),(a1),(a2),(a3))
#endif

static void debug_log(const char* fmt,...)
{
  //  if (ruby_debug == Qtrue) {
    id pool = [[NSAutoreleasePool alloc] init];
    NSString* nsfmt = [NSString stringWithFormat: @"RBOBJ:%s", fmt];
    va_list args;
    va_start(args, fmt);
    NSLogv(nsfmt, args);
    va_end(args);
    [pool release];
    //  }
}

static RB_ID sel_to_mid(SEL a_sel)
{
  int i;
  id pool;
  NSString* selstr;
  char mname[1024];

  pool = [[NSAutoreleasePool alloc] init];
  selstr = NSStringFromSelector(a_sel);
  memset(mname, 0, sizeof(mname));
  strncpy(mname, [selstr UTF8String], sizeof(mname) - 1);

  // selstr.sub(/:/,'_').sub(/^(.*)_$/, "\1")
  for (i = 0; i < [selstr length]; i++)
    if (mname[i] == ':') mname[i] = '_';
  for (i = [selstr length] - 1; i >= 0; i--) {
    if (mname[i] != '_') break;
    mname[i] = '\0';
  }
  [pool release];

  return rb_intern(mname);
}

static RB_ID sel_to_mid_as_setter(SEL a_sel)
{
  id pool = [[NSAutoreleasePool alloc] init];
  VALUE str = rb_str_new2([NSStringFromSelector(a_sel) UTF8String]);

  // if str.sub!(/^set([A-Z][^:]*):$/, '\1=') then
  //   str = str[0].chr.downcase + str[1..-1]
  // end
  const char* re_pattern = "^set([A-Z][^:]*):$";
  VALUE re = rb_reg_new(re_pattern, strlen(re_pattern), 0);
  if (rb_funcall(str, rb_intern("sub!"), 2, re, rb_str_new2("\\1=")) != Qnil) {
    int c = (int)(RSTRING(str)->ptr[0]);
    c = tolower(c);
    RSTRING(str)->ptr[0] = (char) c;
  }

  [pool release];
  return rb_to_id(str);
}

static RB_ID rb_obj_sel_to_mid(VALUE rcv, SEL a_sel)
{
  RB_ID mid = sel_to_mid(a_sel);
  if (rb_respond_to(rcv, mid) == 0)
    mid = sel_to_mid_as_setter(a_sel);
  return mid;
}

static int rb_obj_arity_of_method(VALUE rcv, SEL a_sel)
{
  id pool = [[NSAutoreleasePool alloc] init];
  VALUE mstr;
  RB_ID mid;
  VALUE method;
  VALUE argc;

  mid = rb_obj_sel_to_mid(rcv, a_sel);
  mstr = rb_str_new2(rb_id2name(mid)); // mstr = sel_to_rbobj (a_sel);
  method = rb_funcall(rcv, rb_intern("method"), 1, mstr);
  argc = rb_funcall(method, rb_intern("arity"), 0);
  [pool release];
  return NUM2INT(argc);
}

static SEL ruby_method_sel(int argc)
{
  SEL result;
  id pool = [[NSAutoreleasePool alloc] init];
  NSString* s = [@"ruby_method_" stringByAppendingFormat: @"%d", argc];
  int i;
  for (i = 0; i < argc; i++) {
    s = [s stringByAppendingString: @":"];
  }
  result = NSSelectorFromString(s);
  [pool release];
  return result;
}

@implementation RBObject

// private methods

- (BOOL)rbobjRespondsToSelector: (SEL)a_sel
{
  BOOL ret;
  RB_ID mid;
  DLOG1("rbobjRespondsToSelector(%s)", a_sel);
  mid = rb_obj_sel_to_mid(m_rbobj, a_sel);
  ret = (rb_respond_to(m_rbobj, mid) != 0);
  DLOG1("   --> %d", ret);
  return ret;
}

- (NSMethodSignature*)rbobjMethodSignatureForSelector: (SEL)a_sel
{
  NSMethodSignature* msig;
  int argc;
  DLOG1("rbobjMethodSignatureForSelector(%s)", a_sel);
  argc = rb_obj_arity_of_method(m_rbobj, a_sel);
  if (argc < 0) argc *= -1;
  msig = [DummyProtocolHandler 
	   instanceMethodSignatureForSelector: ruby_method_sel(argc)];
  DLOG1("   --> %@", msig);
  return msig;
}

- (NSMethodSignature*) rbobjMethodSignatureForSheetSelector: (SEL)a_sel
{
  const char* tail = ":returnCode:contextInfo:";
  const SEL dummy_sel = @selector(sheetPanelDidEnd:returnCode:contextInfo:);

  const char* name;
  int name_len, tail_len;
  NSMethodSignature* msig;
  id pool;

  msig = nil;
  pool = [[NSAutoreleasePool alloc] init];
  name = [NSStringFromSelector(a_sel) UTF8String];
  name_len = strlen(name);
  tail_len = strlen(tail);
  if (name_len > tail_len) {
    if (strcmp(name + name_len - tail_len, tail) == 0) {
      // it's sheet panel selector
      msig = [DummyProtocolHandler
	       instanceMethodSignatureForSelector: dummy_sel];
    }
  }
  [pool release];
  return msig;
}

- (VALUE)fetchForwardArgumentsOf: (NSInvocation*)an_inv
{
  int i;
  NSMethodSignature* msig = [an_inv methodSignature];
  int arg_cnt = ([msig numberOfArguments] - 2);
  VALUE args = rb_ary_new2(arg_cnt);
  for (i = 0; i < arg_cnt; i++) {
    VALUE arg_val;
    const char* octstr = [msig getArgumentTypeAtIndex: (i+2)];
    int octype = to_octype(octstr);
    void* ocdata = OCDATA_ALLOCA(octype, octstr);
    BOOL f_conv_success;
    [an_inv getArgument: ocdata atIndex: (i+2)];
    f_conv_success = ocdata_to_rbobj(Qnil, octype, ocdata, &arg_val);
    if (f_conv_success == NO) {
      arg_val = Qnil;
    }
    rb_ary_store(args, i, arg_val);
  }
  return args;
}

- (BOOL)stuffForwardResult: (VALUE)result to: (NSInvocation*)an_inv
{
  NSMethodSignature* msig = [an_inv methodSignature];
  const char* octype_str = [msig methodReturnType];
  int octype = to_octype(octype_str);
  BOOL f_success;

  if (octype == _C_VOID) {
    f_success = true;
  }
  else if ((octype == _C_ID) || (octype == _C_CLASS)) {
    id ocdata = rbobj_get_ocid(result);
    if (ocdata == nil) {
      if (result == m_rbobj)
	ocdata = self;
      else
	rbobj_to_nsobj(result, &ocdata);
    }
    [an_inv setReturnValue: &ocdata];
    f_success = YES;
  }
  else {
    void* ocdata = OCDATA_ALLOCA(octype, octype_str);
    f_success = rbobj_to_ocdata (result, octype, ocdata);
    if (f_success) [an_inv setReturnValue: ocdata];
  }
  return f_success;
}

-(void)rbobjRaiseRubyException
{
  VALUE lasterr = rb_gv_get("$!");
  RB_ID mtd = rb_intern("nsexception");
  if (rb_respond_to(lasterr, mtd)) {
      VALUE nso = rb_funcall(lasterr, mtd, 0);
      NSException *exc = rbobj_get_ocid(nso);
      [exc raise];
      return; // not reached
  }
  
  NSMutableDictionary *info = [NSMutableDictionary dictionary];
  
  id ocdata = rbobj_get_ocid(lasterr);
  if (ocdata == nil) {
      rbobj_to_nsobj(lasterr, &ocdata);
  }
  [info setObject: ocdata forKey: @"$!"];

  VALUE klass = rb_class_path(CLASS_OF(lasterr));
  NSString *rbclass = [NSString stringWithUTF8String:STR2CSTR(klass)];
  
  VALUE rbmessage = rb_obj_as_string(lasterr);
  NSString *message = [NSString stringWithUTF8String:STR2CSTR(rbmessage)];
  
  NSMutableArray *backtraceArray = [NSMutableArray array];
  VALUE ary = rb_funcall(ruby_errinfo, rb_intern("backtrace"), 0);
  int c;
  for (c=0; c<RARRAY(ary)->len; c++) {
      const char *path = STR2CSTR(RARRAY(ary)->ptr[c]);
      NSString *nspath = [NSString stringWithUTF8String:path];
      [backtraceArray addObject: nspath];
  }
  
  [info setObject: backtraceArray forKey: @"backtrace"];
  
  NSException* myException = [NSException
      exceptionWithName:[@"RBException_" stringByAppendingString: rbclass]
			 reason:message
			 userInfo:info];
  [myException raise];
}

static VALUE rbobject_protected_apply(VALUE a)
{
  VALUE *args = (VALUE*) a;
  return rb_apply(args[0],(RB_ID)args[1],(VALUE)args[2]);
}

- (void)rbobjForwardInvocation: (NSInvocation *)an_inv
{
  VALUE rb_args;
  VALUE rb_result;
  RB_ID mid;
  VALUE args[3];
  int err;

  DLOG1("rbobjForwardInvocation(%@)", an_inv);
  mid = rb_obj_sel_to_mid(m_rbobj, [an_inv selector]);
  rb_args = [self fetchForwardArgumentsOf: an_inv];
  args[0] = m_rbobj;
  args[1] = mid;
  args[2] = rb_args;
  
  rb_result = rb_protect(rbobject_protected_apply,(VALUE)args,&err);
  if (err) {
      [self rbobjRaiseRubyException];
  }

  [self stuffForwardResult: rb_result to: an_inv];
  DLOG1("   --> rb_result=%s", STR2CSTR(rb_inspect(rb_result)));
}

// public class methods
+ RBObjectWithRubyScriptCString: (const char*) cstr
{
  return [[self alloc] initWithRubyScriptCString: cstr];
}

+ RBObjectWithRubyScriptString: (NSString*) str
{
  return [[self alloc] initWithRubyScriptString: str];
}

// public methods

- (VALUE) __rbobj__  { return m_rbobj; }

- (void) dealloc
{
  rb_gc_unregister_address (&m_rbobj);
  [super dealloc];
}

- initWithRubyObject: (VALUE)rbobj
{
  m_rbobj = rbobj;
  rb_gc_register_address (&m_rbobj);
  return self;
}

- initWithRubyScriptCString: (const char*) cstr
{
  return [self initWithRubyObject: rb_eval_string(cstr)];
}

- initWithRubyScriptString: (NSString*) str
{
  return [self initWithRubyScriptCString: [str UTF8String]];
}

- (NSString*) _copyDescription
{
  return [[NSString alloc] initWithUTF8String: STR2CSTR(rb_inspect(m_rbobj))];
}

- (BOOL)isKindOfClass: (Class)klass
{
  BOOL ret;
  DLOG1("isKindOfClass(%@)", NSStringFromClass(klass));
  ret = NO;
  DLOG1("   --> %d", ret);
  return ret;
}

- (BOOL)isRBObject
{
  return YES;
}

- (void)forwardInvocation: (NSInvocation *)an_inv
{
  DLOG1("forwardInvocation(%@)", an_inv);
  if ([self rbobjRespondsToSelector: [an_inv selector]]) {
    DLOG0("   -> forward to Ruby Object");
    [self rbobjForwardInvocation: an_inv];
  }
  else {
    DLOG0("   -> forward to super Objective-C Object");
    [super forwardInvocation: an_inv];
  }
}

- (NSMethodSignature*)methodSignatureForSelector: (SEL)a_sel
{
  NSMethodSignature* ret = nil;
  DLOG1("methodSignatureForSelector(%s)", a_sel);
  if (*(char*)a_sel == NULL) return nil;
  ret = [DummyProtocolHandler instanceMethodSignatureForSelector: a_sel];
  if (ret == nil)
    ret = [self rbobjMethodSignatureForSheetSelector: a_sel];
  if (ret == nil)
    ret = [self rbobjMethodSignatureForSelector: a_sel];
  DLOG1("   --> %@", ret);
  return ret;
}

- (BOOL)respondsToSelector: (SEL)a_sel
{
  BOOL ret;
  DLOG1("respondsToSelector(%s)", a_sel);
  ret = [self rbobjRespondsToSelector: a_sel];
  DLOG1("   --> %d", ret);
  return ret;
}

@end

@implementation NSProxy (RubyCocoaEx)

- (BOOL)isRBObject
{
  return NO;
}

@end
