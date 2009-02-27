/** -*-objc-*-
 *
 *   $Id: OverrideMixin.h 979 2006-05-29 01:18:25Z hisa $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni
 *
 **/
#import <objc/runtime.h>
#import <Foundation/NSObject.h>

long override_mixin_ivar_list_size();
struct objc_ivar_list* override_mixin_ivar_list();

struct objc_method_list* override_mixin_method_list();
struct objc_method_list* override_mixin_class_method_list();

void install_method_list(Class c);
void install_class_method_list(Class c);
