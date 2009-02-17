/** -*-objc-*-
 *
 *   $Id: cls_objcid.m 786 2005-04-20 14:21:52Z kimuraw $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
 *
 *   This program is free software.
 *   You can distribute/modify this program under the terms of
 *   the GNU Lesser General Public License version 2.
 *
 **/

#import "cls_objcid.h"

#import "osx_ruby.h"
#import "ocdata_conv.h"
#import <Foundation/Foundation.h>
#import <string.h>
#import <stdlib.h>
#import "RBObject.h"

static VALUE _kObjcID = Qnil;

static void
_objcid_data_free(struct _objcid_data* dp)
{
  id pool = [[NSAutoreleasePool alloc] init];
  if (dp != NULL) {
    if (dp->ocid != nil)
      [dp->ocid release];
    free(dp);
  }
  [pool release];
}

static struct _objcid_data*
_objcid_data_new()
{
  struct _objcid_data* dp;
  dp = malloc(sizeof(struct _objcid_data));
  dp->ocid = nil;
  return dp;
}

static void
_objcid_initialize_for_new_with_ocid(int argc, VALUE* argv, VALUE rcv)
{
  VALUE arg_ocid;

  rb_scan_args(argc, argv, "10", &arg_ocid);
  if (arg_ocid != Qnil) {
    id ocid = (id) NUM2UINT(arg_ocid);
    [ocid retain];
    OBJCID_DATA_PTR(rcv)->ocid = ocid;
  }
}

static VALUE
objcid_s_new(int argc, VALUE* argv, VALUE klass)
{
  VALUE obj;
  obj = Data_Wrap_Struct(klass, 0, _objcid_data_free, _objcid_data_new());
  rb_obj_call_init(obj, argc, argv);
  return obj;
}

static VALUE
objcid_s_new_with_ocid(int argc, VALUE* argv, VALUE klass)
{
  VALUE obj;
  obj = Data_Wrap_Struct(klass, 0, _objcid_data_free, _objcid_data_new());
  _objcid_initialize_for_new_with_ocid(argc, argv, obj);
  if (argc > 0) {
    argc--;
    argv++;
    if (argc == 0) argv = NULL;
  }
  rb_obj_call_init(obj, argc, argv);
  return obj;
}

static VALUE
objcid_initialize(int argc, VALUE* argv, VALUE rcv)
{
  return rcv;
}

static VALUE
objcid_ocid(VALUE rcv)
{
  return UINT2NUM((unsigned int) OBJCID_ID(rcv));
}

static VALUE
objcid_inspect(VALUE rcv)
{
  VALUE result;
  char s[512];
  id ocid = OBJCID_ID(rcv);
  id pool = [[NSAutoreleasePool alloc] init];
  const char* class_desc = [[[ocid class] description] UTF8String];
  VALUE rbclass_name = rb_mod_name(CLASS_OF(rcv));
  snprintf(s, sizeof(s), "#<%s:0x%lx class='%s' id=%p>",
	   STR2CSTR(rbclass_name),
	   NUM2ULONG(rb_obj_id(rcv)), 
	   class_desc, ocid);
  result = rb_str_new2(s);
  [pool release];
  return result;
}

/** class methods **/

VALUE
objid_s_class ()
{
  return _kObjcID;
}

/*******/

VALUE
init_cls_ObjcID(VALUE outer)
{
  _kObjcID = rb_define_class_under(outer, "ObjcID", rb_cObject);

  rb_define_singleton_method(_kObjcID, "new", objcid_s_new, -1);
  rb_define_singleton_method(_kObjcID, "new_with_ocid", objcid_s_new_with_ocid, -1);

  rb_define_method(_kObjcID, "initialize", objcid_initialize, -1);
  rb_define_method(_kObjcID, "__ocid__", objcid_ocid, 0);
  rb_define_method(_kObjcID, "__inspect__", objcid_inspect, 0);
  rb_define_method(_kObjcID, "inspect", objcid_inspect, 0);

  return _kObjcID;
}
