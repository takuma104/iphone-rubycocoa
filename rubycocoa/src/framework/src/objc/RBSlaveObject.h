/** -*-objc-*-
 *
 *   $Id: RBSlaveObject.h.in 648 2003-07-28 01:06:18Z hisa $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
 *
 *   This program is free software.
 *   You can distribute/modify this program under the terms of
 *   the GNU Lesser General Public License version 2.
 *
 **/
#import "RBObject.h"
#import "osx_ruby.h"

@interface RBObject(RBSlaveObject)
- initWithMasterObject: master;
- initWithClass: (Class)occlass masterObject: master;
- initWithRubyClass: (VALUE)rbclass masterObject: master;
@end
