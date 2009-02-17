# -*-rd-*-
= Getting RubyCocoa

== Binary Distribution

=== for Mac OS X 10.3

RubyCocoa's binary distribution has been built for the Ruby 1.6.8 distributed
with Mac OS X 10.3.

Download
((<RubyCocoa-0.4.2-panther.dmg|URL:http://prdownloads.sourceforge.net/rubycocoa/RubyCocoa-0.4.2-panther.dmg?download>))
from ((<file list|URL:http://sourceforge.net/project/showfiles.php?group_id=44114>)).

It includes library, samples, templates for Project Builder, etc. for both
RubyCocoa and RubyAEOSA. Everything necessary for execution and development is
included in an easy-to-install '.pkg' package file.

A successful installation of the binary package will add the following items:

: /Library/Frameworks/RubyCocoa.framework
  RubyCocoa framework (core)

: inside of /usr/lib/ruby/site_ruby/1.6/osx/
  RubyCocoa library (stub)

: /usr/lib/ruby/site_ruby/1.6/powerpc-darwin7.0/rubycocoa.bundle
  RubyCocoa extended library (stub)

: inside of '/Library/Application Support/Apple/Developer Tools'
  Some templates for Xcode

: inside of '/Developer/ProjectBuilder Extras/'
  Some templates for ProjectBuilder

: /Developer/Documentation/RubyCocoa
  HTML documentation

: /Developer/Examples/RubyCocoa
  Sample programs

After installation, try the samples that are written in Ruby. Refer
to ((<'Try RubyCocoa Samples'|URL:trysamples.en.html>)).

=== for Mac OS X 10.4

RubyCocoa's binary distribution has been built for the Ruby 1.8.2 distributed
with Mac OS X 10.4.

Download
((<RubyCocoa-0.4.2-tiger.dmg|URL:http://prdownloads.sourceforge.net/rubycocoa/RubyCocoa-0.4.2-tiger.dmg?download>))
from ((<file list|URL:http://sourceforge.net/project/showfiles.php?group_id=44114>)).

=== for Mac OS X 10.2

RubyCocoa's binary distribution has been built for the Ruby 1.6.7 distributed
with Mac OS X 10.2.

Download
((<RubyCocoa-0.4.2-jaguar.dmg|URL:http://prdownloads.sourceforge.net/rubycocoa/RubyCocoa-0.4.2-jaguar.dmg?download>))
from ((<file list|URL:http://sourceforge.net/project/showfiles.php?group_id=44114>)).

== Source Distribution

Download
((<rubycocoa-0.4.2.tgz|URL:http://prdownloads.sourceforge.net/rubycocoa/rubycocoa-0.4.2.tgz?download>))
from ((<file list|URL:http://sourceforge.net/project/showfiles.php?group_id=44114>)).

To build and install RubyCocoa, refer to 
((<"Build and Install RubyCocoa from Source"|URL:build.en.html>)).


== Getting Development Source from CVS Server

The latest (or the oldest) development source is available from the 
((<CVS Server|URL:http://sourceforge.net/cvs/?group_id=44114>)).

You can
((<view the CVS Repository|URL:http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/rubycocoa/>))
for RubyCocoa. On the shell command line, type this:

  $ cvs -d:pserver:anonymous@cvs.sf.net:/cvsroot/rubycocoa login
  $ cvs -z3 -d:pserver:anonymous@cvs.sf.net:/cvsroot/rubycocoa co \
        -P -d rubycocoa src
  $ cd rubycocoa
  $ cvs update -d -P

All of the source for RubyCocoa is downloaded into a directory named 'rubycocoa'.

Building may fail because of the nature of CVS. Some cvs commands such as
'cvs update' or 'cvs status -v' will be helpful. Use these commands
with appropriate options.


== DarwinPorts 

((<DarwinPorts|URL:http://darwinports.opendarwin.org/>)) has a port 
"rb-cocoa" for RubyCocoa(0.4.1). 

The port requires DarwinPorts version 1.1. You can update your DarwinPorts 
with following command:

  $ sudo port -d selfupdate

== PINEAPPLE RPM Package

RPM format binary (0.2.x) exist on
((<Project PINEAPPLE (Japanese)|URL:http://sacral.c.u-tokyo.ac.jp/~hasimoto/Pineapple/>)).


$Date: 2005-11-06 20:24:54 +0900 (日, 06 11 2005) $
