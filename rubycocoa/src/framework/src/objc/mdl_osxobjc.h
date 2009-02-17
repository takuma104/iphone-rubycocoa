/** -*-objc-*-
 *
 *   $Id: mdl_osxobjc.h 450 2002-12-12 07:05:17Z hisa $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
 *
 *   This program is free software.
 *   You can distribute/modify this program under the terms of
 *   the GNU Lesser General Public License version 2.
 *
 **/
#import <objc/objc.h>
#import "osx_ruby.h"
#import "cls_objcid.h"
#import "cls_objcptr.h"
#import "mdl_objwrapper.h"

#define OCID2NUM(val) UINT2NUM((unsigned int)(val))
#define NUM2OCID(val) ((id)NUM2UINT((VALUE)(val)))

/** OSX module **/
VALUE osx_s_module();

/** OCObject methods **/
VALUE ocobj_s_new (id ocid);

/** getter **/
id    rbobj_get_ocid (VALUE rcv);
VALUE ocid_get_rbobj (id ocid);

/** initialize **/
void initialize_mdl_osxobjc();
