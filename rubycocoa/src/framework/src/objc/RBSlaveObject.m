/** -*-objc-*-
 *
 *   $Id: RBSlaveObject.m 648 2003-07-28 01:06:18Z hisa $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
 *
 *   This program is free software.
 *   You can distribute/modify this program under the terms of
 *   the GNU Lesser General Public License version 2.
 *
 **/
#import <Foundation/Foundation.h>
#import "RBObject.h"
#import "RBSlaveObject.h"
#import "RBRuntime.h"
#import "RBClassUtils.h"
#import "osx_ruby.h"
#import "ocdata_conv.h"
#import "mdl_osxobjc.h"

static VALUE rbobj_for(VALUE rbclass, id master)
{
  return rb_funcall(rbclass, rb_intern("new_with_ocid"), 1, OCID2NUM(master));
}

@implementation RBObject(RBSlaveObject)

- initWithMasterObject: master
{
  return [self initWithClass: [self class] masterObject: master];
}

- initWithClass: (Class)occlass masterObject: master
{
  VALUE rb_class = RBRubyClassFromObjcClass (occlass);
  return [self initWithRubyClass: rb_class masterObject: master];
}

///////

- initWithRubyClass: (VALUE)rbclass masterObject: master
{
  VALUE rbobj;
  rbobj = rbobj_for(rbclass, master);
  return [self initWithRubyObject: rbobj];
}

@end
