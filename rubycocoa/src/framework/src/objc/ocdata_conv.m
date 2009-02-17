/** -*-objc-*-
 *
 *   $Id: ocdata_conv.m 868 2005-11-01 16:18:56Z kimuraw $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
 *
 *   This program is free software.
 *   You can distribute/modify this program under the terms of
 *   the GNU Lesser General Public License version 2.
 *
 **/

#import <objc/runtime.h>
#import <Foundation/Foundation.h>
#import "ocdata_conv.h"
#import "RBObject.h"
#import "mdl_osxobjc.h"
#import <CoreFoundation/CFString.h> // CFStringEncoding


static VALUE rbclass_nsrect()
{
  VALUE mOSX = osx_s_module();
  if (!mOSX) return Qnil;
  return rb_const_get(mOSX, rb_intern("CGRect"));
}

static VALUE rbclass_nspoint()
{
  VALUE mOSX = osx_s_module();
  if (!mOSX) return Qnil;
  return rb_const_get(mOSX, rb_intern("CGPoint"));
}

static VALUE rbclass_nssize()
{
  VALUE mOSX = osx_s_module();
  if (!mOSX) return Qnil;
  return rb_const_get(mOSX, rb_intern("CGSize"));
}

static VALUE rbclass_nsrange()
{
  VALUE mOSX = osx_s_module();
  if (!mOSX) return Qnil;
  return rb_const_get(mOSX, rb_intern("NSRange"));
}

int
to_octype(const char* octype_str)
{
  int oct;

  /* avoid first character 'r' which is const meaning */
  if (octype_str[0] == 'r') octype_str++;
  oct = *octype_str;

  //if (octype_str[0] == '{' && octype_str[1] == '_') {
  if (octype_str[0] == '{') {
    if (strcmp(octype_str, @encode(CGRect)) == 0) {
      oct = _PRIV_C_NSRECT;
    }
    else if (strcmp(octype_str, @encode(CGPoint)) == 0) {
      oct = _PRIV_C_NSPOINT;
    }
    else if (strcmp(octype_str, @encode(CGSize)) == 0) {
      oct = _PRIV_C_NSSIZE;
    }
    else if (strcmp(octype_str, @encode(NSRange)) == 0) {
      oct = _PRIV_C_NSRANGE;
    }
  }
  else if (octype_str[0] == '^') {
    if (strcmp(octype_str, "^@") == 0)
      oct = _PRIV_C_ID_PTR;
    else
      oct = _PRIV_C_PTR;
  }

  return oct;
}

size_t
ocdata_size(int octype, const char* octype_str)
{
  size_t result = 0;
  switch (octype) {

  case _C_ID:
  case _C_CLASS:
    result = sizeof(id); break;

  case _C_SEL:
    result = sizeof(SEL); break;

  case _C_CHR:
  case _C_UCHR:
    result = sizeof(char); break;

  case _C_SHT:
  case _C_USHT:
    result = sizeof(short); break;

  case _C_INT:
  case _C_UINT:
    result = sizeof(int); break;

  case _C_LNG:
  case _C_ULNG:
    result = sizeof(long); break;

  case _C_FLT:
    result = sizeof(float); break;

  case _C_DBL:
    result = sizeof(double); break;

    // case _C_PTR:
  case _C_CHARPTR:
    result = sizeof(char*); break;

  case _C_VOID:
    result = 0; break;

  case _PRIV_C_NSRECT:
    result = sizeof(CGRect); break;
    
  case _PRIV_C_NSPOINT:
    result = sizeof(CGPoint); break;

  case _PRIV_C_NSSIZE:
    result = sizeof(CGSize); break;

  case _PRIV_C_NSRANGE:
    result = sizeof(NSRange); break;

  case _PRIV_C_PTR:
    result = sizeof(void*); break;

  case _PRIV_C_ID_PTR:
    result = sizeof(id*); break;

  case _C_BFLD:
  case _C_UNDEF:
  case _C_ARY_B:
  case _C_ARY_E:
  case _C_UNION_B:
  case _C_UNION_E:
  case _C_STRUCT_B:
  case _C_STRUCT_E:

  default: {
    unsigned int size, align;
    NSGetSizeAndAlignment(octype_str, &size, &align);
    result = size; break;
  }
  }
  return result;
}

void*
ocdata_malloc(int octype, const char* octype_str)
{
  size_t s = ocdata_size(octype, octype_str);
  if (s == 0) return NULL;
  return malloc(s);
}

BOOL
ocdata_to_rbobj(VALUE context_obj,
		int octype, const void* ocdata, VALUE* result)
{
  BOOL f_success = YES;
  VALUE rbval = Qnil;

  switch (octype) {

  case _C_ID:
  case _C_CLASS:
    rbval = ocid_to_rbobj(context_obj, *(id*)ocdata);
    break;

  case _PRIV_C_PTR:
    rbval = objcptr_s_new_with_cptr (*(void**)ocdata);
    break;

  case _PRIV_C_BOOL:
    rbval = bool_to_rbobj(*(BOOL*)ocdata);
    break;

  case _C_SEL: {
    id pool = [[NSAutoreleasePool alloc] init];
    NSString* arg_str = NSStringFromSelector(*(SEL*)ocdata);
    rbval = rb_str_new2([arg_str UTF8String]);
    [pool release];
    break;
  }

  case _C_CHR:
    rbval = INT2NUM(*(char*)ocdata); break;

  case _C_UCHR:
    rbval = UINT2NUM(*(unsigned char*)ocdata); break;

  case _C_SHT:
    rbval = INT2NUM(*(short*)ocdata); break;

  case _C_USHT:
    rbval = UINT2NUM(*(unsigned short*)ocdata); break;

  case _C_INT:
    rbval = INT2NUM(*(int*)ocdata); break;

  case _C_UINT:
    rbval = UINT2NUM(*(unsigned int*)ocdata); break;

  case _C_LNG:
    rbval = INT2NUM(*(long*)ocdata); break;

  case _C_ULNG:
    rbval = UINT2NUM(*(unsigned long*)ocdata); break;

  case _C_FLT:
    rbval = rb_float_new((double)(*(float*)ocdata)); break;

  case _C_DBL:
    rbval = rb_float_new(*(double*)ocdata); break;

    // case _C_PTR:
  case _C_CHARPTR:
    rbval = rb_str_new2(*(char**)ocdata); break;

  case _PRIV_C_NSRECT: {
    CGRect* vp = (CGRect*)ocdata;
    VALUE klass = rbclass_nsrect();
    if (klass != Qnil)
      rbval = rb_funcall(klass, rb_intern("new"), 4,
			 rb_float_new((double)vp->origin.x),
			 rb_float_new((double)vp->origin.y),
			 rb_float_new((double)vp->size.width),
			 rb_float_new((double)vp->size.height));
    else
      f_success = NO;
    break;
  }

  case _PRIV_C_NSPOINT: {
    CGPoint* vp = (CGPoint*)ocdata;
    VALUE klass = rbclass_nspoint();
    if (klass != Qnil)
      rbval = rb_funcall(klass, rb_intern("new"), 2,
			 rb_float_new((double)vp->x),
			 rb_float_new((double)vp->y));
    else
      f_success = NO;
    break;
  }

  case _PRIV_C_NSSIZE: {
    CGSize* vp = (CGSize*)ocdata;
    VALUE klass = rbclass_nssize();
    if (klass != Qnil)
      rbval = rb_funcall(klass, rb_intern("new"), 2,
			 rb_float_new((double)vp->width),
			 rb_float_new((double)vp->height));
    else
      f_success = NO;
    break;
  }

  case _PRIV_C_NSRANGE: {
    NSRange* rp = (NSRange*)ocdata;
    VALUE klass = rbclass_nsrange();
    if (klass != Qnil)
      rbval = rb_funcall(klass, rb_intern("new"), 2, 
			 UINT2NUM(rp->location), UINT2NUM(rp->length));
    else
      f_success = NO;
    break;
  }

  case _C_BFLD:
  case _C_VOID:
  case _C_UNDEF:
    
  case _C_ARY_B:
  case _C_ARY_E:
  case _C_UNION_B:
  case _C_UNION_E:
  case _C_STRUCT_B:
  case _C_STRUCT_E:

  default:
    f_success = NO;
    rbval = Qnil;
    break;
  }

  if (f_success) *result = rbval;
  return f_success;
}

static BOOL rbary_to_nsary(VALUE rbary, id* nsary)
{
  long i;
  long len = RARRAY(rbary)->len;
  VALUE* items = RARRAY(rbary)->ptr;
  NSMutableArray* result = [[[NSMutableArray alloc] init] autorelease];
  for (i = 0; i < len; i++) {
    id nsitem;
    if (!rbobj_to_nsobj(items[i], &nsitem)) return NO;
    [result addObject: nsitem];
  }
  *nsary = result;
  return YES;
}

static BOOL rbhash_to_nsdic(VALUE rbhash, id* nsdic)
{
  VALUE ary_keys;
  VALUE* keys;
  VALUE val;
  long i, len;
  NSMutableDictionary* result;
  id nskey, nsval;

  ary_keys = rb_funcall(rbhash, rb_intern("keys"), 0);
  len = RARRAY(ary_keys)->len;
  keys = RARRAY(ary_keys)->ptr;

  result = [[[NSMutableDictionary alloc] init] autorelease];

  for (i = 0; i < len; i++) {
    if (!rbobj_to_nsobj(keys[i], &nskey)) return NO;
    val = rb_hash_aref(rbhash, keys[i]);
    if (!rbobj_to_nsobj(val, &nsval)) return NO;
    [result setObject: nsval forKey: nskey];
  }
  *nsdic = result;
  return YES;
}

static BOOL rbnum_to_nsnum(VALUE rbval, id* nsval)
{
  BOOL result;
  VALUE rbstr = rb_obj_as_string(rbval);
  id pool = [[NSAutoreleasePool alloc] init];
  id nsstr = [NSString stringWithUTF8String: STR2CSTR(rbstr)];
  *nsval = [[NSDecimalNumber alloc] initWithString: nsstr];
  result = [(*nsval) isKindOfClass: [NSDecimalNumber class]];
  [pool release];
  return result;
}

static BOOL rbobj_convert_to_nsobj(VALUE obj, id* nsobj)
{
  
  switch (TYPE(obj)) {

  case T_NIL:
    *nsobj = nil;
    return YES;

  case T_STRING:
    obj = rb_obj_as_string(obj);
    *nsobj = rbstr_to_ocstr(obj);
    return YES;

  case T_SYMBOL:
    obj = rb_obj_as_string(obj);
    *nsobj = [NSString stringWithUTF8String: RSTRING(obj)->ptr];
    return YES;

  case T_ARRAY:
    return rbary_to_nsary(obj, nsobj);

  case T_HASH:
    return  rbhash_to_nsdic(obj, nsobj);
    
  case T_FIXNUM:
  case T_BIGNUM:
  case T_FLOAT:
    return rbnum_to_nsnum(obj, nsobj);

  case T_OBJECT:
  case T_CLASS:
  case T_MODULE:
  case T_REGEXP:
  case T_STRUCT:
  case T_FILE:
  case T_TRUE:
  case T_FALSE:
  case RB_T_DATA:
  default:
    *nsobj = [[[RBObject alloc] initWithRubyObject: obj] autorelease];
    return YES;
  }
  return YES;
}

BOOL rbobj_to_nsobj(VALUE obj, id* nsobj)
{
  if (obj == Qnil) {
    *nsobj = nil;
    return YES;
  }

  *nsobj = rbobj_get_ocid(obj);
  if (*nsobj != nil) return YES;

  if (rbobj_convert_to_nsobj(obj, nsobj))
    return YES;

  return NO;
}

BOOL rbobj_to_bool(VALUE obj)
{
  return ((obj != Qnil) && (obj != Qfalse)) ? YES : NO;
}

VALUE bool_to_rbobj (BOOL val)
{
  return (val ? Qtrue : Qfalse);
}

VALUE sel_to_rbobj (SEL val)
{
  VALUE rbobj;
  if (ocdata_to_rbobj(Qnil, _C_SEL, &val, &rbobj)) {
    rbobj = rb_obj_as_string(rbobj);
    // str.tr!(':','_')
    rb_funcall(rbobj, rb_intern("tr!"), 2, rb_str_new2(":"), rb_str_new2("_"));
    // str.sub!(/_+$/,'')
    rb_funcall(rbobj, rb_intern("sub!"), 2, rb_str_new2("_+$"), rb_str_new2(""));
  }
  else {
    rbobj = Qnil;
  }
  return rbobj;
}

VALUE int_to_rbobj (int val)
{
  return INT2NUM(val);
}

VALUE uint_to_rbobj (unsigned int val)
{
  return UINT2NUM(val);
}

VALUE double_to_rbobj (double val)
{
  return rb_float_new(val);
}

VALUE
ocid_to_rbobj(VALUE context_obj, id ocid)
{
  VALUE result;

  if (ocid == nil) return Qnil;

  result = ocid_get_rbobj(ocid);

  if (result == Qnil) {
    if (rbobj_get_ocid(context_obj) == ocid)
      result = context_obj;
    else
      result = ocobj_s_new (ocid);
  }

  return result;
}


id rbobj_to_nsselstr(VALUE obj)
{
  int i;
  VALUE str = rb_obj_as_string(obj);

  // str[0..0] + str[1..-1].tr('_',':')
  for (i = 1; i < RSTRING(str)->len; i++) {
    if (RSTRING(str)->ptr[i] == '_')
      RSTRING(str)->ptr[i] = ':';
  }
  return [NSString stringWithUTF8String: STR2CSTR(str)];
}

SEL rbobj_to_nssel(VALUE obj)
{
  if (NIL_P(obj)) {
    return NULL;
  }
  else {
    id pool = [[NSAutoreleasePool alloc] init];
    id nsstr = rbobj_to_nsselstr(obj);
    SEL nssel = NSSelectorFromString(nsstr);
    [pool release];
    return nssel;
  }
}

static BOOL rbobj_to_objcptr(VALUE obj, void** cptr)
{
  if (TYPE(obj) == T_NIL) {
    *cptr = NULL;
  }
  else if (TYPE(obj) == T_STRING) {
    *cptr = RSTRING(obj)->ptr;
  }
  else if (rb_obj_is_kind_of(obj, objcptr_s_class()) == Qtrue) {
    *cptr = objcptr_cptr(obj);
  }
  else {
    return NO;
  }
  return YES;
}

static BOOL rbobj_to_idptr(VALUE obj, id** idptr)
{
  if (TYPE(obj) == T_NIL) {
    *idptr = NULL;
  }
  else if (rb_obj_is_kind_of(obj, objid_s_class()) == Qtrue) {
    id old_id = OBJCID_ID(obj);
    if (old_id) [old_id release];
    OBJCID_ID(obj) = nil;
    *idptr = OBJCID_IDPTR(obj);
  }
  else {
    return NO;
  }
  return YES;
}

static BOOL rbobj_to_nspoint(VALUE obj, CGPoint* result)
{
  if (TYPE(obj) != T_ARRAY)
    obj = rb_funcall(obj, rb_intern("to_a"), 0);
  if (RARRAY(obj)->len != 2) return NO;
  result->x = (float) RFLOAT(rb_Float(rb_ary_entry(obj, 0)))->value;
  result->y = (float) RFLOAT(rb_Float(rb_ary_entry(obj, 1)))->value;
  return YES;
}

static BOOL rbobj_to_nssize(VALUE obj, CGSize* result)
{
  if (TYPE(obj) != T_ARRAY)
    obj = rb_funcall(obj, rb_intern("to_a"), 0);
  if (RARRAY(obj)->len != 2) return NO;
  result->width = (float) RFLOAT(rb_Float(rb_ary_entry(obj, 0)))->value;
  result->height = (float) RFLOAT(rb_Float(rb_ary_entry(obj, 1)))->value;
  return YES;
}

static BOOL rbobj_to_nsrange(VALUE obj, NSRange* result)
{
  unsigned long first, last;
  int exclude_end_p;
  if (rb_respond_to(obj, rb_intern("to_range")))
    obj = rb_funcall(obj, rb_intern("to_range"), 0);
  if (rb_obj_is_kind_of(obj, rb_cRange)) {
    first = NUM2UINT(rb_funcall(obj, rb_intern("first"), 0));
    last = NUM2UINT(rb_funcall(obj, rb_intern("last"), 0));
	exclude_end_p = (rb_funcall(obj, rb_intern("exclude_end?"), 0) == Qtrue);
    result->location = first;
    result->length = (last - first + (exclude_end_p ? 0 : 1));
  }
  else {
    if (TYPE(obj) != T_ARRAY)
      obj = rb_funcall(obj, rb_intern("to_a"), 0);
    rb_funcall(obj, rb_intern("flatten!"), 0);
    if (RARRAY(obj)->len != 2) return NO;
    result->location = NUM2UINT(rb_ary_entry(obj, 0));
    result->length = NUM2UINT(rb_ary_entry(obj, 1));
  }
  return YES;
}

static BOOL rbobj_to_nsrect(VALUE obj, CGRect* result)
{
  if (TYPE(obj) != T_ARRAY)
    obj = rb_funcall(obj, rb_intern("to_a"), 0);
  if (RARRAY(obj)->len == 2) {
    VALUE rb_orig = rb_ary_entry(obj, 0);
    VALUE rb_size = rb_ary_entry(obj, 1);
    if (!rbobj_to_nspoint(rb_orig, &(result->origin))) return NO;
    if (!rbobj_to_nssize(rb_size, &(result->size))) return NO;
  }
  else if (RARRAY(obj)->len == 4) {
    result->origin.x = (float) RFLOAT(rb_Float(rb_ary_entry(obj, 0)))->value;
    result->origin.y = (float) RFLOAT(rb_Float(rb_ary_entry(obj, 1)))->value;
    result->size.width = (float) RFLOAT(rb_Float(rb_ary_entry(obj, 2)))->value;
    result->size.height = (float) RFLOAT(rb_Float(rb_ary_entry(obj, 3)))->value;
  }
  else {
    return NO;
  }
  return YES;
}

BOOL
rbobj_to_ocdata(VALUE obj, int octype, void* ocdata)
{
  BOOL f_success = YES;

  if (TYPE(obj) == T_TRUE) {
    obj = INT2NUM(1);
  }
  else if (TYPE(obj) == T_FALSE) {
    obj = INT2NUM(0);
  }

  switch (octype) {

  case _C_ID:
  case _C_CLASS: {
    id nsobj;
    f_success = rbobj_to_nsobj(obj, &nsobj);
    if (f_success) *(id*)ocdata = nsobj;
    break;
  }

  case _C_SEL:
    *(SEL*)ocdata = rbobj_to_nssel(obj);
    break;

  case _C_CHR:
    *(char*)ocdata = (char) NUM2INT(rb_Integer(obj));
    break;

  case _C_UCHR:
    *(unsigned char*)ocdata = (unsigned char) NUM2UINT(rb_Integer(obj));
    break;

  case _C_SHT:
    *(short*)ocdata = (short) NUM2INT(rb_Integer(obj));
    break;

  case _C_USHT:
    *(unsigned short*)ocdata = (unsigned short) NUM2UINT(rb_Integer(obj));
    break;

  case _C_INT:
    *(int*)ocdata = (int) NUM2INT(rb_Integer(obj));
    break;

  case _C_UINT:
    *(unsigned int*)ocdata = (unsigned int) NUM2UINT(rb_Integer(obj));
    break;

  case _C_LNG:
    *(long*)ocdata = (long) NUM2LONG(rb_Integer(obj));
    break;

  case _C_ULNG:
    *(unsigned long*)ocdata = (unsigned long) NUM2ULONG(rb_Integer(obj));
    break;

  case _C_FLT:
    *(float*)ocdata = (float) RFLOAT(rb_Float(obj))->value;
    break;

  case _C_DBL:
    *(double*)ocdata = RFLOAT(rb_Float(obj))->value;
    break;

    // case _C_PTR:
  case _C_CHARPTR:
    *(char**)ocdata = STR2CSTR(rb_obj_as_string(obj));
    break;

  case _PRIV_C_PTR: {
    void* cptr;
    f_success = rbobj_to_objcptr(obj, &cptr);
    if (f_success) *(void**)ocdata = cptr;
    break;
  }

  case _PRIV_C_ID_PTR: {
    id* idptr;
    f_success = rbobj_to_idptr(obj, &idptr);
    if (f_success) *(id**)ocdata = idptr;
    break;
  }

  case _PRIV_C_NSRECT: {
    CGRect nsval;
    f_success = rbobj_to_nsrect(obj, &nsval);
    if (f_success) *(CGRect*)ocdata = nsval;
    break;
  }

  case _PRIV_C_NSPOINT: {
    CGPoint nsval;
    f_success = rbobj_to_nspoint(obj, &nsval);
    if (f_success) *(CGPoint*)ocdata = nsval;
    break;
  }

  case _PRIV_C_NSSIZE: {
    CGSize nsval;
    f_success = rbobj_to_nssize(obj, &nsval);
    if (f_success) *(CGSize*)ocdata = nsval;
    break;
  }

  case _PRIV_C_NSRANGE: {
    NSRange nsval;
    f_success = rbobj_to_nsrange(obj, &nsval);
    if (f_success) *(NSRange*)ocdata = nsval;
    break;
  }

  case _C_BFLD:
  case _C_VOID:
  case _C_UNDEF:
  case _C_ARY_B:
  case _C_ARY_E:
  case _C_UNION_B:
  case _C_UNION_E:
  case _C_STRUCT_B:
  case _C_STRUCT_E:

  default:
    f_success = NO;
    break;

  }

  return f_success;
}

static NSStringEncoding kcode_to_nsencoding(const char* kcode) 
{ 
  if (strcmp(kcode, "UTF8") == 0)
    return NSUTF8StringEncoding;
  else if (strcmp(kcode, "SJIS") == 0)
    return CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingMacJapanese);
  else if (strcmp(kcode, "EUC") == 0)
    return NSJapaneseEUCStringEncoding;
  else // "NONE"
    return NSUTF8StringEncoding;
}
#define KCODE_NSSTRENCODING kcode_to_nsencoding(rb_get_kcode()) 

id
rbstr_to_ocstr(VALUE obj)
{
  return [[[NSString alloc] initWithData:[NSData dataWithBytes:RSTRING(obj)->ptr
			    			 length: RSTRING(obj)->len]
			    encoding:KCODE_NSSTRENCODING] autorelease];
}

VALUE
ocstr_to_rbstr(id ocstr)
{
  NSData * data = [(NSString *)ocstr dataUsingEncoding:KCODE_NSSTRENCODING
				     allowLossyConversion:YES];
  return rb_str_new ([data bytes], [data length]);
}
