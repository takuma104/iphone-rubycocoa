/** -*-objc-*-
 *
 *   $Id: cls_objcptr.h 979 2006-05-29 01:18:25Z hisa $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni
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
