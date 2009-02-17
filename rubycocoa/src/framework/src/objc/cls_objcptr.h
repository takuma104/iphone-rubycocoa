/** -*-objc-*-
 *
 *   $Id: cls_objcptr.h 450 2002-12-12 07:05:17Z hisa $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
 *
 *   This program is free software.
 *   You can distribute/modify this program under the terms of
 *   the GNU Lesser General Public License version 2.
 *
 **/
#import "osx_ruby.h"

/** class methods **/
VALUE objcptr_s_class ();
VALUE objcptr_s_new_with_cptr (void* cptr);

/** instance methods **/
void* objcptr_cptr (VALUE rcv);

/** initial loading **/
VALUE init_cls_ObjcPtr (VALUE outer);
