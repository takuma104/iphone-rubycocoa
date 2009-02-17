/** -*-objc-*-
 *
 *   $Id: init_cocoa.m 710 2004-12-09 13:36:44Z kimuraw $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
 *
 *   This program is free software.
 *   You can distribute/modify this program under the terms of
 *   the GNU Lesser General Public License version 2.
 *
 **/
#import <Foundation/NSAutoreleasePool.h>
#import <Foundation/NSException.h>
#import <Foundation/NSString.h>
#import "osx_ruby.h"
#import "ocdata_conv.h"

static VALUE
_ocdataconv_err_class()
{
  static VALUE exc = Qnil;
  if (exc == Qnil) {
    VALUE mosx = rb_const_get(rb_cObject, rb_intern("OSX"));
    exc = rb_const_get(mosx, rb_intern("OCDataConvException"));
  }
  return exc;
}

static VALUE
_oc_err_class()
{
  static VALUE exc = Qnil;
  if (exc == Qnil) {
    VALUE mosx = rb_const_get(rb_cObject, rb_intern("OSX"));
    exc = rb_const_get(mosx, rb_intern("OCException"));
  }
  return exc;
}

VALUE
oc_err_new (const char* fname, NSException* nsexcp)
{
  id pool = [[NSAutoreleasePool alloc] init];
  VALUE exc = _oc_err_class();
  char buf[BUFSIZ];
  VALUE result;

  snprintf(buf, BUFSIZ, "%s - %s - %s", fname,
	   [[nsexcp name] cString], [[nsexcp reason] cString]);
  result = rb_funcall(exc, rb_intern("new"), 2, ocid_to_rbobj(Qnil, nsexcp), rb_str_new2(buf));
  [pool release];
  return result;
}

void
rbarg_to_nsarg(VALUE rbarg, int octype, void* nsarg, const char* fname, id pool, int index)
{
  if (!rbobj_to_ocdata(rbarg, octype, nsarg)) {
    if (pool) [pool release];
    rb_raise(_ocdataconv_err_class(), "%s - arg #%d cannot convert to nsobj.", fname, index);
  }
}

VALUE
nsresult_to_rbresult(int octype, const void* nsresult, const char* fname, id pool)
{
  VALUE rbresult;
  if (!ocdata_to_rbobj(Qnil, octype, nsresult, &rbresult)) {
    if (pool) [pool release];
    rb_raise(_ocdataconv_err_class(), "%s - result cannot convert to rbobj.", fname);
  }
  return rbresult;
}

extern void init_AppKit(VALUE);
extern void init_Foundation(VALUE);

void init_cocoa(VALUE mOSX)
{
  init_UIKit(mOSX);
  init_Foundation(mOSX);
}
