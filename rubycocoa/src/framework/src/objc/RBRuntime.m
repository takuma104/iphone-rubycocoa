/** -*-objc-*-
 *
 *   $Id: RBRuntime.m 786 2005-04-20 14:21:52Z kimuraw $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
 *
 *   This program is free software.
 *   You can distribute/modify this program under the terms of
 *   the GNU Lesser General Public License version 2.
 *
 **/

#import "RBRuntime.h"
#import "RBObject.h"
#import <string.h>
#import <Foundation/NSBundle.h>
#import <Foundation/NSAutoreleasePool.h>
#import <Foundation/NSString.h>
#import <Foundation/NSPathUtilities.h>
#import "mdl_osxobjc.h"

#define RUBY_MAIN_NAME "rb_main.rb"

static char* rb_main_path(const char* rb_main_name)
{
  char* result;
  id path;
  id pool = [[NSAutoreleasePool alloc] init];
  NSBundle* bundle = [NSBundle mainBundle];
  if (rb_main_name == NULL) rb_main_name = RUBY_MAIN_NAME;
  path = [NSString stringWithUTF8String: rb_main_name];
  result = strdup([[bundle pathForResource: path ofType: nil] fileSystemRepresentation]);
  [pool release];
  return result;
}

static char* resource_path()
{
  NSString* str;
  char* result;
  id pool = [[NSAutoreleasePool alloc] init];
  NSBundle* bundle = [NSBundle mainBundle];
  str = [bundle resourcePath];
  result = strdup([str fileSystemRepresentation]);
  [pool release];
  return result;
}

static char* framework_ruby_path()
{
  NSString* str;
  char* result;
  const char* dirname = "/ruby";
  id pool = [[NSAutoreleasePool alloc] init];
  NSBundle* bundle = [NSBundle bundleForClass: [RBObject class]];
  str = [bundle resourcePath];
  result = (char*) malloc (strlen([str fileSystemRepresentation]) + strlen(dirname) + 1);
  strcpy (result, [str fileSystemRepresentation]);
  strcat (result, dirname);
  [pool release];
  return result;
}

static void load_path_unshift(const char* path)
{
  extern VALUE rb_load_path;
  rb_ary_unshift(rb_load_path, rb_str_new2(path));
}

static int
prepare_argv(int argc, const char* argv[], const char* rb_main_name, const char*** ruby_argv_ptr)
{
  int i;
  int ruby_argc;
  const char** ruby_argv;
  int my_argc;
  char* my_argv[] = {
    rb_main_path(rb_main_name)
  };

  my_argc = sizeof(my_argv) / sizeof(char*);

  ruby_argc = 0;
  ruby_argv = malloc (sizeof(char*) * (argc + my_argc + 1));
  for (i = 0; i < argc; i++) {
    if (strncmp(argv[i], "-psn_", 5) == 0) continue;
    ruby_argv[ruby_argc++] = argv[i];
  }
  for (i = 0; i < my_argc; i++) ruby_argv[ruby_argc++] = my_argv[i];
  ruby_argv[ruby_argc] = NULL;

  *ruby_argv_ptr = ruby_argv;
  return ruby_argc;
}

int
RBApplicationMain(const char* rb_main_name, int argc, const char* argv[])
{
  int ruby_argc;
  const char** ruby_argv;
	
  ruby_argc = prepare_argv(argc, argv, rb_main_name, &ruby_argv);
	
  {
    RUBY_INIT_STACK
    ruby_init();
    ruby_options(ruby_argc, (char**) ruby_argv);
    RBRubyCocoaInit();
    load_path_unshift(resource_path()); // add a ruby part of oneself to $LOAD_PATH
    ruby_run();
  }
  return 0;
}

int
RBRubyCocoaInit()
{
  static int init_p = 0;

  if (init_p) return 0;

  initialize_mdl_osxobjc();	// initialize an objc part of rubycocoa
  load_path_unshift(framework_ruby_path()); // add a ruby part of rubycocoa to $LOAD_PATH
  init_p = 1;

  return 1;
}
