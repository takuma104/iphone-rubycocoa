/** -*-objc-*-
 *
 *   $Id: RBObject.h.in 840 2005-09-27 14:08:02Z kimuraw $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
 *
 *   This program is free software.
 *   You can distribute/modify this program under the terms of
 *   the GNU Lesser General Public License version 2.
 *
 **/
#import <Foundation/NSProxy.h>
#import "osx_ruby.h"

@interface RBObject : NSProxy
{
  VALUE m_rbobj;
}

+ RBObjectWithRubyScriptCString: (const char*) cstr;
+ RBObjectWithRubyScriptString: (NSString*) str;

- initWithRubyObject: (VALUE) rbobj;
- initWithRubyScriptCString: (const char*) cstr;
- initWithRubyScriptString: (NSString*) str;

- (VALUE) __rbobj__;
- (BOOL) isKindOfClass:(Class)aClass;
- (BOOL) isRBObject;

@end

@interface NSProxy (RubyCocoaEx)

- (BOOL) isRBObject;

@end
