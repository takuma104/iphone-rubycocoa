/** -*-objc-*-
 *
 *   $Id: ocdata_conv.h 783 2005-04-19 15:26:58Z kimuraw $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
 *
 *   This program is free software.
 *   You can distribute/modify this program under the terms of
 *   the GNU Lesser General Public License version 2.
 *
 **/

#import <objc/runtime.h>
#import <stdarg.h>
#import "osx_ruby.h"

enum osxobjc_nsdata_type {
  _PRIV_C_BOOL = 1024,
  _PRIV_C_NSRECT,
  _PRIV_C_NSPOINT,
  _PRIV_C_NSSIZE,
  _PRIV_C_NSRANGE,
  _PRIV_C_PTR,
  _PRIV_C_ID_PTR,
};

int     to_octype       (const char* oc_type_str);
size_t  ocdata_size     (int octype, const char* octype_str);
void*   ocdata_malloc   (int octype, const char* octype_str);
#define OCDATA_ALLOCA(octype,s)  alloca(ocdata_size((octype),(s)))

id    rbobj_to_nsselstr (VALUE obj);
SEL   rbobj_to_nssel    (VALUE obj);
BOOL  rbobj_to_nsobj    (VALUE obj, id* nsobj);
BOOL  rbobj_to_bool     (VALUE obj);
id    rbstr_to_ocstr    (VALUE obj);

VALUE    sel_to_rbobj (SEL val);
VALUE    int_to_rbobj (int val);
VALUE   uint_to_rbobj (unsigned int val);
VALUE double_to_rbobj (double val);
VALUE   bool_to_rbobj (BOOL val);
VALUE   ocid_to_rbobj (VALUE context_obj, id ocid);
VALUE  ocstr_to_rbstr (id ocstr);

BOOL  ocdata_to_rbobj (VALUE context_obj,
		       int octype, const void* ocdata, VALUE* result);
BOOL  rbobj_to_ocdata (VALUE obj, int octype, void* ocdata);
