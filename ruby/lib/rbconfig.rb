
# This file was created by mkconfig.rb when ruby was built.  Any
# changes made to this file will be lost the next time ruby is built.

module Config
  RUBY_VERSION == "1.8.7" or
    raise "ruby lib version (1.8.7) doesn't match executable version (#{RUBY_VERSION})"

  TOPDIR = File.dirname(__FILE__).chomp!("/lib/ruby/1.8/universal-darwin9.0")
  DESTDIR = '' unless defined? DESTDIR
  CONFIG = {}
  CONFIG["DESTDIR"] = DESTDIR
  CONFIG["INSTALL"] = '/usr/bin/install -c'
  CONFIG["prefix"] = (TOPDIR || DESTDIR + "/usr/local")
  CONFIG["EXEEXT"] = ""
  CONFIG["ruby_install_name"] = "ruby"
  CONFIG["RUBY_INSTALL_NAME"] = "ruby"
  CONFIG["RUBY_SO_NAME"] = "ruby"
  CONFIG["SHELL"] = "/bin/sh"
  CONFIG["PATH_SEPARATOR"] = ":"
  CONFIG["PACKAGE_NAME"] = ""
  CONFIG["PACKAGE_TARNAME"] = ""
  CONFIG["PACKAGE_VERSION"] = ""
  CONFIG["PACKAGE_STRING"] = ""
  CONFIG["PACKAGE_BUGREPORT"] = ""
  CONFIG["exec_prefix"] = "$(prefix)"
  CONFIG["bindir"] = "$(exec_prefix)/bin"
  CONFIG["sbindir"] = "$(exec_prefix)/sbin"
  CONFIG["libexecdir"] = "$(exec_prefix)/libexec"
  CONFIG["datarootdir"] = "$(prefix)/share"
  CONFIG["datadir"] = "$(datarootdir)"
  CONFIG["sysconfdir"] = "$(prefix)/etc"
  CONFIG["sharedstatedir"] = "$(prefix)/com"
  CONFIG["localstatedir"] = "$(prefix)/var"
  CONFIG["includedir"] = "$(prefix)/include"
  CONFIG["oldincludedir"] = "/usr/include"
  CONFIG["docdir"] = "$(datarootdir)/doc/$(PACKAGE)"
  CONFIG["infodir"] = "$(datarootdir)/info"
  CONFIG["htmldir"] = "$(docdir)"
  CONFIG["dvidir"] = "$(docdir)"
  CONFIG["pdfdir"] = "$(docdir)"
  CONFIG["psdir"] = "$(docdir)"
  CONFIG["libdir"] = "$(exec_prefix)/lib"
  CONFIG["localedir"] = "$(datarootdir)/locale"
  CONFIG["mandir"] = "$(datarootdir)/man"
  CONFIG["DEFS"] = ""
  CONFIG["ECHO_C"] = "\\\\c"
  CONFIG["ECHO_N"] = ""
  CONFIG["ECHO_T"] = ""
  CONFIG["LIBS"] = "-ldl -lobjc "
  CONFIG["build_alias"] = ""
  CONFIG["host_alias"] = "arm-apple-darwin9"
  CONFIG["target_alias"] = "arm-apple-darwin9"
  CONFIG["MAJOR"] = "1"
  CONFIG["MINOR"] = "8"
  CONFIG["TEENY"] = "7"
  CONFIG["build"] = "i686-apple-darwin9.6.0"
  CONFIG["build_cpu"] = "i686"
  CONFIG["build_vendor"] = "apple"
  CONFIG["build_os"] = "darwin9.6.0"
  CONFIG["host"] = "arm-apple-darwin9"
  CONFIG["host_cpu"] = "arm"
  CONFIG["host_vendor"] = "apple"
  CONFIG["host_os"] = "darwin9"
  CONFIG["target"] = "arm-apple-darwin9"
  CONFIG["target_cpu"] = "arm"
  CONFIG["target_vendor"] = "apple"
  CONFIG["target_os"] = "darwin9"
  CONFIG["CC"] = "/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin9-gcc-4.0.1"
  CONFIG["CFLAGS"] = "-arch armv6 -fmessage-length=0 -pipe -Wno-trigraphs -fpascal-strings -fasm-blocks -Os -mdynamic-no-pic  \t\t-Wreturn-type -Wunused-variable -isysroot /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS2.0.sdk -pipe -fno-common $(cflags)"
  CONFIG["LDFLAGS"] = "-L. "
  CONFIG["CPPFLAGS"] = " -D_XOPEN_SOURCE -D_DARWIN_C_SOURCE $(DEFS) $(cppflags)"
  CONFIG["OBJEXT"] = "o"
  CONFIG["CPP"] = "/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/cpp"
  CONFIG["GREP"] = "/usr/bin/grep"
  CONFIG["EGREP"] = "/usr/bin/grep -E"
  CONFIG["GNU_LD"] = "no"
  CONFIG["CPPOUTFILE"] = "> conftest.i"
  CONFIG["OUTFLAG"] = "-o "
  CONFIG["YACC"] = "bison -y"
  CONFIG["YFLAGS"] = ""
  CONFIG["RANLIB"] = "/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/ranlib"
  CONFIG["AR"] = "/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/ar"
  CONFIG["AS"] = "as"
  CONFIG["ASFLAGS"] = ""
  CONFIG["NM"] = ""
  CONFIG["WINDRES"] = ""
  CONFIG["DLLWRAP"] = ""
  CONFIG["OBJDUMP"] = ""
  CONFIG["LN_S"] = "ln -s"
  CONFIG["SET_MAKE"] = ""
  CONFIG["INSTALL_PROGRAM"] = "$(INSTALL)"
  CONFIG["INSTALL_SCRIPT"] = "$(INSTALL)"
  CONFIG["INSTALL_DATA"] = "$(INSTALL) -m 644"
  CONFIG["RM"] = "rm -f"
  CONFIG["CP"] = "cp"
  CONFIG["MAKEDIRS"] = "mkdir -p"
  CONFIG["ALLOCA"] = ""
  CONFIG["DLDFLAGS"] = ""
  CONFIG["ARCH_FLAG"] = ""
  CONFIG["STATIC"] = ""
  CONFIG["CCDLFLAGS"] = " -fno-common"
  CONFIG["LDSHARED"] = "cc -dynamic -bundle -undefined suppress -flat_namespace"
  CONFIG["DLEXT"] = "bundle"
  CONFIG["DLEXT2"] = ""
  CONFIG["LIBEXT"] = "a"
  CONFIG["LINK_SO"] = ""
  CONFIG["LIBPATHFLAG"] = " -L%1$-s"
  CONFIG["RPATHFLAG"] = " -Wl,-R%1$-s"
  CONFIG["LIBPATHENV"] = "DYLD_LIBRARY_PATH"
  CONFIG["TRY_LINK"] = ""
  CONFIG["STRIP"] = "strip -A -n"
  CONFIG["EXTSTATIC"] = "static"
  CONFIG["setup"] = "Setup"
  CONFIG["PREP"] = "fake.rb"
  CONFIG["EXTOUT"] = ".ext"
  CONFIG["ARCHFILE"] = ""
  CONFIG["RDOCTARGET"] = ""
  CONFIG["cppflags"] = ""
  CONFIG["cflags"] = "$(optflags) $(debugflags)"
  CONFIG["optflags"] = ""
  CONFIG["debugflags"] = ""
  CONFIG["LIBRUBY_LDSHARED"] = "cc -dynamic -bundle -undefined suppress -flat_namespace"
  CONFIG["LIBRUBY_DLDFLAGS"] = ""
  CONFIG["rubyw_install_name"] = ""
  CONFIG["RUBYW_INSTALL_NAME"] = ""
  CONFIG["LIBRUBY_A"] = "lib$(RUBY_SO_NAME)-static.a"
  CONFIG["LIBRUBY_SO"] = "lib$(RUBY_SO_NAME).so.$(MAJOR).$(MINOR).$(TEENY)"
  CONFIG["LIBRUBY_ALIASES"] = "lib$(RUBY_SO_NAME).so"
  CONFIG["LIBRUBY"] = "$(LIBRUBY_A)"
  CONFIG["LIBRUBYARG"] = "$(LIBRUBYARG_STATIC)"
  CONFIG["LIBRUBYARG_STATIC"] = "-l$(RUBY_SO_NAME)-static"
  CONFIG["LIBRUBYARG_SHARED"] = "-Wl,-R -Wl,$(libdir) -L$(libdir) "
  CONFIG["SOLIBS"] = ""
  CONFIG["DLDLIBS"] = ""
  CONFIG["ENABLE_SHARED"] = "no"
  CONFIG["MAINLIBS"] = ""
  CONFIG["COMMON_LIBS"] = ""
  CONFIG["COMMON_MACROS"] = ""
  CONFIG["COMMON_HEADERS"] = ""
  CONFIG["EXPORT_PREFIX"] = ""
  CONFIG["MAKEFILES"] = "Makefile"
  CONFIG["arch"] = "arm-darwin9"
  CONFIG["sitearch"] = "arm-darwin9"
  CONFIG["sitedir"] = "$(libdir)/ruby/site_ruby"
  CONFIG["vendordir"] = "$(libdir)/ruby/vendor_ruby"
  CONFIG["configure_args"] = " '--host=arm-apple-darwin9' '--target=arm-apple-darwin9' '--enable-wide-getaddrinfo' '--with-static-linked-ext' 'CC=/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/arm-apple-darwin9-gcc-4.0.1' 'CPP=/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/cpp' 'LD=/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/ld' 'AR=/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/ar' 'RANLIB=/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/ranlib' 'ac_cv_func_getpgrp_void=yes' 'ac_cv_func_setpgrp_void=yes' 'ac_cv_func_sigprocmask=no' 'ac_cv_func_sigsetmask=no' 'CFLAGS=-arch armv6 -fmessage-length=0 -pipe -Wno-trigraphs -fpascal-strings -fasm-blocks -Os -mdynamic-no-pic  \t\t-Wreturn-type -Wunused-variable -isysroot /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS2.0.sdk' 'host_alias=arm-apple-darwin9' 'target_alias=arm-apple-darwin9'"
  CONFIG["NROFF"] = "/usr/bin/nroff"
  CONFIG["MANTYPE"] = "doc"
  CONFIG["ruby_version"] = "$(MAJOR).$(MINOR)"
  CONFIG["rubylibdir"] = "$(libdir)/ruby/$(ruby_version)"
  CONFIG["archdir"] = "$(rubylibdir)/$(arch)"
  CONFIG["sitelibdir"] = "$(sitedir)/$(ruby_version)"
  CONFIG["sitearchdir"] = "$(sitelibdir)/$(sitearch)"
  CONFIG["vendorlibdir"] = "$(vendordir)/$(ruby_version)"
  CONFIG["vendorarchdir"] = "$(vendorlibdir)/$(sitearch)"
  CONFIG["topdir"] = File.dirname(__FILE__)
  MAKEFILE_CONFIG = {}
  CONFIG.each{|k,v| MAKEFILE_CONFIG[k] = v.dup}
  def Config::expand(val, config = CONFIG)
    val.gsub!(/\$\$|\$\(([^()]+)\)|\$\{([^{}]+)\}/) do |var|
      if !(v = $1 || $2)
	'$'
      elsif key = config[v = v[/\A[^:]+(?=(?::(.*?)=(.*))?\z)/]]
	pat, sub = $1, $2
	config[v] = false
	Config::expand(key, config)
	config[v] = key
	key = key.gsub(/#{Regexp.quote(pat)}(?=\s|\z)/n) {sub} if pat
	key
      else
	var
      end
    end
    val
  end
  CONFIG.each_value do |val|
    Config::expand(val)
  end
end
RbConfig = Config # compatibility for ruby-1.9
CROSS_COMPILING = nil unless defined? CROSS_COMPILING
