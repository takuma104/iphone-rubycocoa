# -*-rd-*-
= Building and Installing RubyCocoa from Source

This document describes building and installing RubyCocoa 0.4.2 from
source. Skip this if you are going to install the binary distribution.

Building and installation are done from a shell, using the Terminal
application or another program that provides a shell prompt, such as GLterm.
This document assumes the use of the (({bash})) shell in shell command input
examples. Please adjust the instructions accordingly when another shell (e.g.
(({tcsh}))) is used.


== Build and Installation Procedure

The following steps perform the build and installation.

* ((<Build and Installation of Ruby>))
* ((<Build of RubyCocoa>))
* ((<Unit Test for RubyCocoa>))
* ((<Installation of RubyCocoa>))

Extract RubyCocoa source from the '.tgz' file into a directory somewhere.

  $ cd {somewhere}
  $ tar zxf rubycocoa-0.4.2.tar.gz # use "gnutar" command on Mac OS X 10.2

((*Caution!*)) Using StuffIt, building RubyCocoa will fail because of a file
name length problem.


== Build and Installation of Ruby

To build RubyCocoa, some C language header files and Ruby's libruby library are
required. Here, the build procedure of Ruby which serves as a base of RubyCocoa
in the case shown below at an example is explained.

  * Ruby 1.8.3 installed from source
  * Ruby included in Mac OS X
    * Ruby 1.6.8(Mac OS X 10.3)
    * Ruby 1.6.7(Mac OS X 10.2)

RubyCocoa 0.4.2 binary distribution has been built with the 2nd way.
When Ruby has been installed with a package utility such as
((<Fink|URL:http://fink.sf.net/>)), adapt these instructions accordingly.

=== Check that the necessary Mac OS X packages are installed

The required packages (BSD.pkg and BSDSDK.pkg) may not have been installed,
depending on the options selected when Mac OS X was installed. Please
first check whether packages is installed, and if required, install it from 
the Mac OS X installer.

  $ ls -dF /Library/Receipts/BSD*.pkg
  /Library/Receipts/BSD.pkg/   /Library/Receipts/BSDSDK.pkg/


=== Ruby 1.8.3 installed from source

It moves to the source directory of Ruby 1.8.3, and builds and installs
as follows. Please change an option if needed.
((- RubyCocoa.framework cannot be linked without specifying the
'-fno-common' option for CFLAGS. -))

  $ CFLAGS='-g -O2 -fno-common' ./configure
  $ make
  $ make test
  $ sudo make install
  $ sudo ranlib /usr/local/lib/libruby-static.a


=== Ruby 1.6.8 included in Mac OS X 10.3

Ruby 1.6.8 included in Mac OS X 10.3 works fine.
There is no action to do.

=== Ruby 1.6.7 included in Mac OS X 10.2

==== Apply patch to Ruby 1.6.7 source

Extract source from Ruby 1.6.7 '.tgz' file, and apply the patch which
is contained in RubyCocoa to Ruby 1.6.7.

  $ cd {somewhere}
  $ tar zxf ruby-1.6.7.tar.gz
  $ cd ruby-1.6.7
  $ patch -p1 < {RubyCocoa source}/misc/ruby-1.6.7-osx10.2.patch


==== Build and install libruby

Ruby 1.6.7 is built so that the environment of the Mac OS X attachment
Ruby may be suited.
((- RubyCocoa.framework cannot be linked without specifying the
'-fno-common' option for CFLAGS. -))

  $ rbhost=`ruby -r rbconfig -e "print Config::CONFIG['host']"`
  $ CFLAGS='-g -O2 -fno-common' ./configure --prefix=/usr --host=$rbhost
  $ make
  $ make test

Install only libruby.a.

  $ rubyarchdir=`ruby -r rbconfig -e 'print Config::CONFIG["archdir"]'`
  $ sudo install -m 0644 libruby.a $rubyarchdir
  $ sudo ranlib $rubyarchdir/libruby.a


== Build of RubyCocoa

Type as follows to build RubyCocoa:

  $ ruby install.rb --help   # print all options
  $ ruby install.rb config
  $ ruby install.rb setup

'ruby install.rb config' command have some options for RubyCocoa. If
required, specify option at the time of a config phase.

== Unit Test for RubyCocoa

  $ cd {source}/tests
  $ DYLD_FRAMEWORK_PATH=../framework/build ruby -I../lib -I../ext/rubycocoa testall.rb

((<"Test::Unit"|URL:http://raa.ruby-lang.org/list.rhtml?name=testunit>)) 
is required for unit tests.  This process is optional.
(Test::Unit is not available on RAA. We uploaded a copy 
((<testunit-0.1.8.tar.gz|URL:http://rubycocoa.sourceforge.net/files/testunit-0.1.8.tar.gz>)).)

Ruby 1.8 includes Test::UNIT.


== Installation of RubyCocoa

  $ sudo ruby install.rb install

Installation is completed above. The following were installed:
old procedure.
(case with Ruby 1.6.8 included in Mac OS X 10.3)

: /Library/Frameworks/RubyCocoa.framework
  RubyCocoa framework (real)

: inside of /usr/lib/ruby/site_ruby/1.6/osx/
  RubyCocoa library (stub)
  - addressbook.rb, appkit.rb, cocoa.rb, foundation.rb

: /usr/lib/ruby/site_ruby/1.6/powerpc-darwin7.0/rubycocoa.bundle
  RubyCocoa extended library (stub)

: inside of '/Library/Application Support/Apple/Developer Tools/'
  Some templates for Xcode
  * 'File Templates/Ruby'
  * 'Project Templates/Application/Cocoa-Ruby Document-based Application'
  * 'Project Templates/Application/Cocoa-Ruby Application'

: inside of '/Developer/ProjectBuilder Extras/'
  Some templates for ProjectBuilder
  * 'File Templates/Ruby'
  * 'Project Templates/Application/Cocoa-Ruby Document-based Application'
  * 'Project Templates/Application/Cocoa-Ruby Application'

: /Developer/Documentation/RubyCocoa
  HTML Documentation

: /Developer/Examples/RubyCocoa
  Sample programs

After installation, let's try samples that are written by Ruby. Refer
to ((<'Try RubyCocoa Samples'|URL:trysamples.en.html>)).


== [FYI] Useful Installer Options for Binary Package Maintainers

For a maintainer of a binary package, there are some useful options for the
config phase.

  * --install-prefix  : effect to extended library and library
  * --install-root    : effect to framework, templates, documents and examples

=== e.g.

  $ ruby -r rbconfig -e 'p Config::CONFIG["prefix"]'
  "/usr"
  $ ruby install.rb config \
      --install-prefix=/tmp/build/usr --install-root=/tmp/build
  $ ruby install.rb setup
  $ sudo ruby install.rb install

As a result, these will be installed temporarily.

  /tmp/build/usr/lib/ruby/site_ruby/1.6/osx/addressbook.rb
  /tmp/build/usr/lib/ruby/site_ruby/1.6/osx/appkit.rb
  /tmp/build/usr/lib/ruby/site_ruby/1.6/osx/cocoa.rb
  /tmp/build/usr/lib/ruby/site_ruby/1.6/osx/foundation.rb
  /tmp/build/usr/lib/ruby/site_ruby/1.6/powerpc-darwin6.0/rubycocoa.bundle
  /tmp/build/Library/Frameworks/RubyCocoa.framework
  /tmp/build/Developer/ProjectBuilder Extras/File Templates/Ruby
  /tmp/build/Developer/ProjectBuilder Extras/Project Templates/ \
          Application/Cocoa-Ruby Application
  /tmp/build/Developer/ProjectBuilder Extras/Project Templates/ \
          Application/Cocoa-Ruby Document-based Application
  /tmp/build/Developer/Examples/RubyCocoa
  /tmp/build/Developer/Documentation/RubyCocoa


== Development and testing environment

* iBook G3/900/640MB
* Mac OS X 10.4.2
  * XcodeTools 2.0/2.1
  * ruby-1.8.2 (pre-installed in Mac OS X 10.4)
  * ruby-1.8.3
* Mac OS X 10.3.8
  * XcodeTools 1.5
  * ruby-1.6.8 (pre-installed in Mac OS X 10.3)
  * ruby-1.8.3
* Mac OS X 10.2.8
  * DevTools 10.2
  * ruby-1.6.7 (pre-installed in Mac OS X 10.2)
  * ruby-1.8.3


== Have fun!

Feel free to send comments, bug reports and patches for RubyCocoa.


$Date: 2005-11-06 16:50:33 +0900 (日, 06 11 2005) $
