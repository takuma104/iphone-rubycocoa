/** -*-objc-*-
 *
 *   $Id: RBClassUtils.m 979 2006-05-29 01:18:25Z hisa $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni
 *
 **/

#import "RBClassUtils.h"
#import <Foundation/Foundation.h>

#import <objc/runtime.h>

#import "RBObject.h"
#import "OverrideMixin.h"
#import "ocdata_conv.h"


static void* alloc_from_default_zone(unsigned int size)
{
  return NSZoneMalloc(NSDefaultMallocZone(), size);
}

static struct objc_method_list** method_list_alloc(int cnt)
{
  int i;
  struct objc_method_list** mlp;
  mlp = alloc_from_default_zone(cnt * sizeof(void*));
  for (i = 0; i < (cnt-1); i++)
    mlp[i] = NULL;
  mlp[cnt-1] = (struct objc_method_list*)-1; // END_OF_METHODS_LIST
  return mlp;
}


/**
 * Dictionary for Ruby class from  Objective-C class name
 **/
static NSMutableDictionary* class_dic_name_to_value()
{
  static NSMutableDictionary* dic = nil;
  if (!dic) dic = [[NSMutableDictionary alloc] init];
  return dic;
}

/**
 * Dictionary for Objective-C class name from Ruby class
 **/
static NSMutableDictionary* class_dic_value_to_name()
{
  static NSMutableDictionary* dic = nil;
  if (!dic) dic = [[NSMutableDictionary alloc] init];
  return dic;
}

/**
 * add class map entry to dictionaries.
 **/
static void class_map_dic_add (const char* name, VALUE kls)
{
  NSString* kls_name;
  NSNumber* kls_value;

  kls_name = [[NSString alloc] initWithUTF8String: name];
  kls_value = [[NSNumber alloc] initWithUnsignedLong: kls];
  [class_dic_name_to_value() setObject: kls_value forKey: kls_name];
  [class_dic_value_to_name() setObject: kls_name forKey: kls_value];
  [kls_name release];
  [kls_value release];
}


Class RBObjcClassFromRubyClass (VALUE kls)
{
  id pool;
  NSDictionary* dic;
  NSNumber* kls_value;
  NSString* kls_name;
  Class result = nil;

  dic = class_dic_value_to_name();
  pool = [[NSAutoreleasePool alloc] init];

  kls_value = [NSNumber numberWithUnsignedLong: kls];
  kls_name = [dic objectForKey: kls_value];
  result = NSClassFromString (kls_name);
  [pool release];
  return result;
}

VALUE RBRubyClassFromObjcClass (Class cls)
{
  id pool;
  NSDictionary* dic;
  NSNumber* kls_value;
  NSString* kls_name;
  VALUE result = Qnil;

  dic = class_dic_name_to_value();
  pool = [[NSAutoreleasePool alloc] init];

  kls_name = NSStringFromClass(cls);
  kls_value = [dic objectForKey: kls_name];
  result = [kls_value unsignedLongValue];
  [pool release];
  return result;
}

Class RBObjcClassNew(VALUE kls, const char* name, Class super_class)
{
  Class c;

  c = objc_allocateClassPair(super_class, name, sizeof(int)*16);
  objc_registerClassPair(c);
  class_map_dic_add (name, kls);
  return c;
}

Class RBObjcDerivedClassNew(VALUE kls, const char* name, Class super_class)
{
  Class c;

  c = objc_allocateClassPair(super_class, name, sizeof(int)*32);

  // init instance variable (m_proxy)
  class_addIvar(c, "m_slave", sizeof(int), 0, "@");

  // init instance methods
  install_method_list(c);

  // init class methods
  install_class_method_list(c);

  // add class to runtime system
  objc_registerClassPair(c);
  class_map_dic_add (name, kls);
  return c;
}
