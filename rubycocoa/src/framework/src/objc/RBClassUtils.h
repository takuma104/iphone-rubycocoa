/** -*-objc-*-
 *
 *   $Id: RBClassUtils.h 450 2002-12-12 07:05:17Z hisa $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
 *
 *   This program is free software.
 *   You can distribute/modify this program under the terms of
 *   the GNU Lesser General Public License version 2.
 *
 **/
#import <objc/objc.h>
#import <Foundation/NSObject.h>
#import "osx_ruby.h"

Class RBObjcClassFromRubyClass (VALUE kls);
VALUE RBRubyClassFromObjcClass (Class cls);

Class RBObjcClassNew(VALUE kls, const char* name, Class super_class);
Class RBObjcDerivedClassNew(VALUE kls, const char* name, Class super_class);

@interface NSObject(RBOverrideMixin)
- __slave__;
- (VALUE) __rbobj__;
+ addRubyMethod: (SEL)a_sel;
@end
