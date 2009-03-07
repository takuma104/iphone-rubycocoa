##
# Makefile for BridgeSupportTiger 
##

Project = BridgeSupportTiger
ProjectName = $(Project)

include $(MAKEFILEPATH)/CoreOS/ReleaseControl/Common.make

USR_BIN = $(DSTROOT)/usr/bin
DTDS = $(DSTROOT)/System/Library/DTDs
CFLAGS = -arch ppc -arch i386 -isysroot /Developer/SDKs/MacOSX10.4u.sdk

build::
	CFLAGS="$(CFLAGS)" DSTROOT="$(DSTROOT)" ruby build.rb
	$(MKDIR) $(USR_BIN)
	$(INSTALL_PROGRAM) gen_bridge_metadata.rb $(USR_BIN)/gen_bridge_metadata
	$(CHMOD) +x $(USR_BIN)/gen_bridge_metadata
	$(MKDIR) $(DTDS)
	$(CP) BridgeSupport.dtd $(DTDS)
	$(MKDIR) $(DSTROOT)/$(MANDIR)/man1
	$(INSTALL_FILE) $(SRCROOT)/gen_bridge_metadata.1 $(DSTROOT)/$(MANDIR)/man1/gen_bridge_metadata.1
	$(MKDIR) $(DSTROOT)/$(MANDIR)/man5
	$(INSTALL_FILE) $(SRCROOT)/BridgeSupport.5 $(DSTROOT)/$(MANDIR)/man5/BridgeSupport.5
