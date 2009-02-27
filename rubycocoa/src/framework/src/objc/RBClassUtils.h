/** -*-objc-*-
 *
 *   $Id: RBClassUtils.h 979 2006-05-29 01:18:25Z hisa $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni
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
