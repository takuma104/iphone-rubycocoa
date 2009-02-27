/** -*-objc-*-
 *
 *   $Id: RBThreadSwitcher.h 979 2006-05-29 01:18:25Z hisa $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni
 *
 **/

#import <Foundation/NSObject.h>
#import <Foundation/NSTimer.h>
#import <sys/time.h>

@interface RBThreadSwitcher : NSObject
{
  id timer;
  struct timeval wait;
}
+ (void) start: (double)interval wait: (double) a_wait;
+ (void) start: (double)interval;
+ (void) start;
+ (void) stop;
@end
