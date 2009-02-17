/** -*-objc-*-
 *
 *   $Id: cls_objcid.h 450 2002-12-12 07:05:17Z hisa $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
 *
 *   This program is free software.
 *   You can distribute/modify this program under the terms of
 *   the GNU Lesser General Public License version 2.
 *
 **/
#import "osx_ruby.h"
#import <objc/objc.h>

struct _objcid_data {
  id  ocid;
};

/** class methods **/
VALUE objid_s_class ();

/** instance methods 
 * id* objcid_idptr (VALUE rcv);
 * id  objcid_id (VALUE rcv);
 **/
#define OBJCID_DATA_PTR(rcv) ((struct _objcid_data*)(DATA_PTR(rcv)))
#define OBJCID_ID(rcv)     (OBJCID_DATA_PTR(rcv)->ocid)
#define OBJCID_IDPTR(rcv)  (&OBJCID_ID(rcv))

/** initial loading **/
VALUE init_cls_ObjcID (VALUE outer);
