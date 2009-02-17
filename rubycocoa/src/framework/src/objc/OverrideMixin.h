/** -*-objc-*-
 *
 *   $Id: OverrideMixin.h 450 2002-12-12 07:05:17Z hisa $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
 *
 *   This program is free software.
 *   You can distribute/modify this program under the terms of
 *   the GNU Lesser General Public License version 2.
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
