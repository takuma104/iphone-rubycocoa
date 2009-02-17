/** -*-objc-*-
 *
 *   $Id: DummyProtocolHandler.m 450 2002-12-12 07:05:17Z hisa $
 *
 *   Copyright (c) 2001 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
 *
 *   This program is free software.
 *   You can distribute/modify this program under the terms of
 *   the GNU Lesser General Public License version 2.
 *
 **/
#import "DummyProtocolHandler.h"
#import <Cocoa/Cocoa.h>

@implementation DummyProtocolHandler

// other
- ruby_method_0 { return nil; }
- ruby_method_1:a1 { return nil; }
- ruby_method_2:a1 :a2 { return nil; }
- ruby_method_3:a1 :a2 :a3 { return nil; }
- ruby_method_4:a1 :a2 :a3 :a4 { return nil; }
- ruby_method_5:a1 :a2 :a3 :a4 :a5 { return nil; }
- ruby_method_6:a1 :a2 :a3 :a4 :a5 :a6 { return nil; }
- ruby_method_7:a1 :a2 :a3 :a4 :a5 :a6 :a7 { return nil; }
- ruby_method_8:a1 :a2 :a3 :a4 :a5 :a6 :a7 :a8 { return nil; }

// Sheet Panel Support
- (void)sheetPanelDidEnd:(NSWindow *)sheet returnCode:(int)returnCode contextInfo:(void  *)contextInfo {}

// as Observer
- (void)receiveNotification: (NSNotification *)notification {}

/**** NSArchiver.h ****/
// @interface NSObject ( NSArchiverCallback )
- ( Class ) classForArchiver { return nil; }
- ( id ) replacementObjectForArchiver : ( NSArchiver * ) archiver { return nil; }

/**** NSArray.h ****/
/**** NSAttributedString.h ****/
/**** NSCalendarDate.h ****/
/**** NSClassDescription.h ****/
// @interface NSObject ( NSClassDescriptionPrimitives )
- ( NSClassDescription * ) classDescription { return nil; }
- ( NSArray * ) attributeKeys { return nil; }
- ( NSArray * ) toOneRelationshipKeys { return nil; }
- ( NSArray * ) toManyRelationshipKeys { return nil; }
- ( NSString * ) inverseForRelationshipKey : ( NSString * ) relationshipKey { return nil; }

/**** NSCoder.h ****/
/**** NSConnection.h ****/
// @interface NSObject ( NSConnectionDelegateMethods )
- ( BOOL ) makeNewConnection : ( NSConnection * ) conn sender : ( NSConnection * ) ancestor { return NO; }
- ( BOOL ) connection : ( NSConnection * ) ancestor shouldMakeNewConnection : ( NSConnection * ) conn { return NO; }
- ( NSData * ) authenticationDataForComponents : ( NSArray * ) components { return nil; }
- ( BOOL ) authenticateComponents : ( NSArray * ) components withData : ( NSData * ) signature { return NO; }
- ( id ) createConversationForConnection : ( NSConnection * ) conn { return nil; }

// @interface NSObject ( NSDistantObjectRequestMethods )
- ( BOOL ) connection : ( NSConnection * ) connection handleRequest : ( NSDistantObjectRequest * ) doreq { return NO; }

/**** NSData.h ****/
/**** NSDate.h ****/
/**** NSDecimalNumber.h ****/
/**** NSDictionary.h ****/
/**** NSEnumerator.h ****/
/**** NSException.h ****/
/**** NSFileHandle.h ****/
/**** NSFileManager.h ****/
// @interface NSObject ( NSCopyLinkMoveHandler )
- ( BOOL ) fileManager : ( NSFileManager * ) fm shouldProceedAfterError : ( NSDictionary * ) errorInfo { return NO; }
- ( void ) fileManager : ( NSFileManager * ) fm willProcessPath : ( NSString * ) path {  }

/**** NSGeometry.h ****/
/**** NSKeyValueCoding.h ****/
// @interface NSObject ( NSKeyValueCoding )
- ( id ) valueForKey : ( NSString * ) key { return nil; }
- ( void ) takeValue : ( id ) value forKey : ( NSString * ) key {  }
- ( id ) storedValueForKey : ( NSString * ) key { return nil; }
- ( void ) takeStoredValue : ( id ) value forKey : ( NSString * ) key {  }
+ ( BOOL ) accessInstanceVariablesDirectly { return NO; }
+ ( BOOL ) useStoredAccessor { return NO; }

// @interface NSObject ( NSKeyValueCodingExtras )
- ( id ) valueForKeyPath : ( NSString * ) key { return nil; }
- ( void ) takeValue : ( id ) value forKeyPath : ( NSString * ) key {  }
- ( NSDictionary * ) valuesForKeys : ( NSArray * ) keys { return nil; }
- ( void ) takeValuesFromDictionary : ( NSDictionary * ) dictionary {  }

// @interface NSObject ( NSKeyValueCodingException )
- ( id ) handleQueryWithUnboundKey : ( NSString * ) key { return nil; }
- ( void ) handleTakeValue : ( id ) value forUnboundKey : ( NSString * ) key {  }
- ( void ) unableToSetNilForKey : ( NSString * ) key {  }

/**** NSKeyedArchiver.h ****/
// @interface NSObject ( NSKeyedArchiverDelegate )
- ( id ) archiver : ( NSKeyedArchiver * ) archiver willEncodeObject : ( id ) object { return nil; }
- ( void ) archiver : ( NSKeyedArchiver * ) archiver didEncodeObject : ( id ) object {  }
- ( void ) archiver : ( NSKeyedArchiver * ) archiver willReplaceObject : ( id ) object withObject : ( id ) newObject {  }
- ( void ) archiverWillFinish : ( NSKeyedArchiver * ) archiver {  }
- ( void ) archiverDidFinish : ( NSKeyedArchiver * ) archiver {  }

// @interface NSObject ( NSKeyedUnarchiverDelegate )
- ( Class ) unarchiver : ( NSKeyedUnarchiver * ) unarchiver cannotDecodeObjectOfClassName : ( NSString * ) name originalClasses : ( NSArray * ) classNames { return nil; }
- ( id ) unarchiver : ( NSKeyedUnarchiver * ) unarchiver didDecodeObject : ( id ) object { return nil; }
- ( void ) unarchiver : ( NSKeyedUnarchiver * ) unarchiver willReplaceObject : ( id ) object withObject : ( id ) newObject {  }
- ( void ) unarchiverWillFinish : ( NSKeyedUnarchiver * ) unarchiver {  }
- ( void ) unarchiverDidFinish : ( NSKeyedUnarchiver * ) unarchiver {  }

// @interface NSObject ( NSKeyedArchiverObjectSubstitution )
- ( Class ) classForKeyedArchiver { return nil; }
- ( id ) replacementObjectForKeyedArchiver : ( NSKeyedArchiver * ) archiver { return nil; }

// @interface NSObject ( NSKeyedUnarchiverObjectSubstitution )
+ ( Class ) classForKeyedUnarchiver { return nil; }

/**** NSNetServices.h ****/
// @interface NSObject ( NSNetServiceDelegateMethods )
- ( void ) netServiceWillPublish : ( NSNetService * ) sender {  }
- ( void ) netServiceWillResolve : ( NSNetService * ) sender {  }
- ( void ) netService : ( NSNetService * ) sender didNotPublish : ( NSDictionary * ) errorDict {  }
- ( void ) netServiceDidResolveAddress : ( NSNetService * ) sender {  }
- ( void ) netService : ( NSNetService * ) sender didNotResolve : ( NSDictionary * ) errorDict {  }
- ( void ) netServiceDidStop : ( NSNetService * ) sender {  }

// @interface NSObject ( NSNetServiceBrowserDelegateMethods )
- ( void ) netServiceBrowserWillSearch : ( NSNetServiceBrowser * ) aNetServiceBrowser {  }
- ( void ) netServiceBrowser : ( NSNetServiceBrowser * ) aNetServiceBrowser didFindDomain : ( NSString * ) domainString moreComing : ( BOOL ) moreComing {  }
- ( void ) netServiceBrowser : ( NSNetServiceBrowser * ) aNetServiceBrowser didFindService : ( NSNetService * ) aNetService moreComing : ( BOOL ) moreComing {  }
- ( void ) netServiceBrowser : ( NSNetServiceBrowser * ) aNetServiceBrowser didNotSearch : ( NSDictionary * ) errorDict {  }
- ( void ) netServiceBrowserDidStopSearch : ( NSNetServiceBrowser * ) aNetServiceBrowser {  }
- ( void ) netServiceBrowser : ( NSNetServiceBrowser * ) aNetServiceBrowser didRemoveDomain : ( NSString * ) domainString moreComing : ( BOOL ) moreComing {  }
- ( void ) netServiceBrowser : ( NSNetServiceBrowser * ) aNetServiceBrowser didRemoveService : ( NSNetService * ) aNetService moreComing : ( BOOL ) moreComing {  }

/**** NSNotification.h ****/
/**** NSPathUtilities.h ****/
/**** NSPort.h ****/
// @interface NSObject ( NSPortDelegateMethods )
- ( void ) handlePortMessage : ( NSPortMessage * ) message {  }

// @interface NSObject ( NSMachPortDelegateMethods )
- ( void ) handleMachMessage : ( void * ) msg {  }

/**** NSPortCoder.h ****/
// @interface NSObject ( NSDistributedObjects )
- ( Class ) classForPortCoder { return nil; }
- ( id ) replacementObjectForPortCoder : ( NSPortCoder * ) coder { return nil; }

/**** NSProtocolChecker.h ****/
/**** NSRange.h ****/
/**** NSRunLoop.h ****/
// @interface NSObject ( NSDelayedPerforming )
- ( void ) performSelector : ( SEL ) aSelector withObject : ( id ) anArgument afterDelay : ( NSTimeInterval ) delay inModes : ( NSArray * ) modes {  }
- ( void ) performSelector : ( SEL ) aSelector withObject : ( id ) anArgument afterDelay : ( NSTimeInterval ) delay {  }
+ ( void ) cancelPreviousPerformRequestsWithTarget : ( id ) aTarget selector : ( SEL ) aSelector object : ( id ) anArgument {  }
+ ( void ) cancelPreviousPerformRequestsWithTarget : ( id ) aTarget {  }

/**** NSScanner.h ****/
/**** NSSet.h ****/
/**** NSSpellServer.h ****/
// @interface NSObject ( NSSpellServerDelegate )
- ( NSRange ) spellServer : ( NSSpellServer * ) sender findMisspelledWordInString : ( NSString * ) stringToCheck language : ( NSString * ) language wordCount : ( int * ) wordCount countOnly : ( BOOL ) countOnly { NSRange r = {0,0}; return r; }
- ( NSArray * ) spellServer : ( NSSpellServer * ) sender suggestGuessesForWord : ( NSString * ) word inLanguage : ( NSString * ) language { return nil; }
- ( void ) spellServer : ( NSSpellServer * ) sender didLearnWord : ( NSString * ) word inLanguage : ( NSString * ) language {  }
- ( void ) spellServer : ( NSSpellServer * ) sender didForgetWord : ( NSString * ) word inLanguage : ( NSString * ) language {  }

/**** NSString.h ****/
/**** NSTask.h ****/
/**** NSThread.h ****/
// @interface NSObject ( NSMainThreadPerformAdditions )
- ( void ) performSelectorOnMainThread : ( SEL ) aSelector withObject : ( id ) arg waitUntilDone : ( BOOL ) wait modes : ( NSArray * ) array {  }
- ( void ) performSelectorOnMainThread : ( SEL ) aSelector withObject : ( id ) arg waitUntilDone : ( BOOL ) wait {  }

/**** NSTimeZone.h ****/
/**** NSURL.h ****/
// @interface NSObject ( NSURLClient )
- ( void ) URL : ( NSURL * ) sender resourceDataDidBecomeAvailable : ( NSData * ) newBytes {  }
- ( void ) URLResourceDidFinishLoading : ( NSURL * ) sender {  }
- ( void ) URLResourceDidCancelLoading : ( NSURL * ) sender {  }
- ( void ) URL : ( NSURL * ) sender resourceDidFailLoadingWithReason : ( NSString * ) reason {  }

/**** NSValue.h ****/
/**** NSObjectScripting.h ****/
// @interface NSObject ( NSScripting )
- ( NSDictionary * ) scriptingProperties { return nil; }
- ( void ) setScriptingProperties : ( NSDictionary * ) properties {  }

/**** NSScriptClassDescription.h ****/
// @interface NSObject ( NSScriptClassDescription )
- ( NSString * ) className { return nil; }
- ( unsigned long ) classCode { return (unsigned long)0; }

/**** NSScriptKeyValueCoding.h ****/
// @interface NSObject ( NSScriptKeyValueCoding )
- ( id ) valueAtIndex : ( unsigned ) index inPropertyWithKey : ( NSString * ) key { return nil; }
- ( id ) valueWithName : ( NSString * ) name inPropertyWithKey : ( NSString * ) key { return nil; }
- ( id ) valueWithUniqueID : ( id ) uniqueID inPropertyWithKey : ( NSString * ) key { return nil; }
- ( void ) replaceValueAtIndex : ( unsigned ) index inPropertyWithKey : ( NSString * ) key withValue : ( id ) value {  }
- ( void ) insertValue : ( id ) value atIndex : ( unsigned ) index inPropertyWithKey : ( NSString * ) key {  }
- ( void ) removeValueAtIndex : ( unsigned ) index fromPropertyWithKey : ( NSString * ) key {  }
- ( void ) insertValue : ( id ) value inPropertyWithKey : ( NSString * ) key {  }
- ( id ) coerceValue : ( id ) value forKey : ( NSString * ) key { return nil; }

/**** NSScriptObjectSpecifiers.h ****/
// @interface NSObject ( NSScriptObjectSpecifiers )
- ( NSScriptObjectSpecifier * ) objectSpecifier { return nil; }
- ( NSArray * ) indicesOfObjectsByEvaluatingObjectSpecifier : ( NSScriptObjectSpecifier * ) specifier { return nil; }

/**** NSScriptWhoseTests.h ****/
// @interface NSObject ( NSComparisonMethods )
- ( BOOL ) isEqualTo : ( id ) object { return NO; }
- ( BOOL ) isLessThanOrEqualTo : ( id ) object { return NO; }
- ( BOOL ) isLessThan : ( id ) object { return NO; }
- ( BOOL ) isGreaterThanOrEqualTo : ( id ) object { return NO; }
- ( BOOL ) isGreaterThan : ( id ) object { return NO; }
- ( BOOL ) isNotEqualTo : ( id ) object { return NO; }
- ( BOOL ) doesContain : ( id ) object { return NO; }
- ( BOOL ) isLike : ( NSString * ) object { return NO; }
- ( BOOL ) isCaseInsensitiveLike : ( NSString * ) object { return NO; }

// @interface NSObject ( NSScriptingComparisonMethods )
- ( BOOL ) scriptingIsEqualTo : ( id ) object { return NO; }
- ( BOOL ) scriptingIsLessThanOrEqualTo : ( id ) object { return NO; }
- ( BOOL ) scriptingIsLessThan : ( id ) object { return NO; }
- ( BOOL ) scriptingIsGreaterThanOrEqualTo : ( id ) object { return NO; }
- ( BOOL ) scriptingIsGreaterThan : ( id ) object { return NO; }
- ( BOOL ) scriptingBeginsWith : ( id ) object { return NO; }
- ( BOOL ) scriptingEndsWith : ( id ) object { return NO; }
- ( BOOL ) scriptingContains : ( id ) object { return NO; }

/**** NSSerialization.h ****/
/**** NSGraphicsContext.h ****/
/**** NSAppleScriptExtensions.h ****/
/**** NSApplication.h ****/
// @interface NSObject ( NSApplicationNotifications )
- ( void ) applicationWillFinishLaunching : ( NSNotification * ) notification {  }
- ( void ) applicationDidFinishLaunching : ( NSNotification * ) notification {  }
- ( void ) applicationWillHide : ( NSNotification * ) notification {  }
- ( void ) applicationDidHide : ( NSNotification * ) notification {  }
- ( void ) applicationWillUnhide : ( NSNotification * ) notification {  }
- ( void ) applicationDidUnhide : ( NSNotification * ) notification {  }
- ( void ) applicationWillBecomeActive : ( NSNotification * ) notification {  }
- ( void ) applicationDidBecomeActive : ( NSNotification * ) notification {  }
- ( void ) applicationWillResignActive : ( NSNotification * ) notification {  }
- ( void ) applicationDidResignActive : ( NSNotification * ) notification {  }
- ( void ) applicationWillUpdate : ( NSNotification * ) notification {  }
- ( void ) applicationDidUpdate : ( NSNotification * ) notification {  }
- ( void ) applicationWillTerminate : ( NSNotification * ) notification {  }
- ( void ) applicationDidChangeScreenParameters : ( NSNotification * ) notification {  }

// @interface NSObject ( NSApplicationDelegate )
- ( NSApplicationTerminateReply ) applicationShouldTerminate : ( NSApplication * ) sender { return (NSApplicationTerminateReply)0; }
- ( BOOL ) application : ( NSApplication * ) sender openFile : ( NSString * ) filename { return NO; }
- ( BOOL ) application : ( NSApplication * ) sender openTempFile : ( NSString * ) filename { return NO; }
- ( BOOL ) applicationShouldOpenUntitledFile : ( NSApplication * ) sender { return NO; }
- ( BOOL ) applicationOpenUntitledFile : ( NSApplication * ) sender { return NO; }
- ( BOOL ) application : ( id ) sender openFileWithoutUI : ( NSString * ) filename { return NO; }
- ( BOOL ) application : ( NSApplication * ) sender printFile : ( NSString * ) filename { return NO; }
- ( BOOL ) applicationShouldTerminateAfterLastWindowClosed : ( NSApplication * ) sender { return NO; }
- ( BOOL ) applicationShouldHandleReopen : ( NSApplication * ) sender hasVisibleWindows : ( BOOL ) flag { return NO; }
- ( NSMenu * ) applicationDockMenu : ( NSApplication * ) sender { return nil; }

// @interface NSObject ( NSServicesRequests )
- ( BOOL ) writeSelectionToPasteboard : ( NSPasteboard * ) pboard types : ( NSArray * ) types { return NO; }
- ( BOOL ) readSelectionFromPasteboard : ( NSPasteboard * ) pboard { return NO; }

/**** NSBox.h ****/
/**** NSButton.h ****/
/**** NSButtonCell.h ****/
/**** NSCell.h ****/
/**** NSClipView.h ****/
/**** NSControl.h ****/
// @interface NSObject ( NSControlSubclassNotifications )
- ( void ) controlTextDidBeginEditing : ( NSNotification * ) obj {  }
- ( void ) controlTextDidEndEditing : ( NSNotification * ) obj {  }
- ( void ) controlTextDidChange : ( NSNotification * ) obj {  }

// @interface NSObject ( NSControlSubclassDelegate )
- ( BOOL ) control : ( NSControl * ) control textShouldBeginEditing : ( NSText * ) fieldEditor { return NO; }
- ( BOOL ) control : ( NSControl * ) control textShouldEndEditing : ( NSText * ) fieldEditor { return NO; }
- ( BOOL ) control : ( NSControl * ) control didFailToFormatString : ( NSString * ) string errorDescription : ( NSString * ) error { return NO; }
- ( void ) control : ( NSControl * ) control didFailToValidatePartialString : ( NSString * ) string errorDescription : ( NSString * ) error {  }
- ( BOOL ) control : ( NSControl * ) control isValidObject : ( id ) obj { return NO; }
- ( BOOL ) control : ( NSControl * ) control textView : ( NSTextView * ) textView doCommandBySelector : ( SEL ) commandSelector { return NO; }

/**** NSFontManager.h ****/
// @interface NSObject ( NSFontManagerDelegate )
- ( BOOL ) fontManager : ( id ) sender willIncludeFont : ( NSString * ) fontName { return NO; }

// @interface NSObject ( NSFontManagerResponderMethod )
- ( void ) changeFont : ( id ) sender {  }

/**** NSFormCell.h ****/
/**** NSMatrix.h ****/
/**** NSMenu.h ****/
// @interface NSObject ( NSMenuValidation )
- ( BOOL ) validateMenuItem : ( id < NSMenuItem > ) menuItem { return NO; }

/**** NSColor.h ****/
/**** NSBitmapImageRep.h ****/
/**** NSBrowser.h ****/
// @interface NSObject ( NSBrowserDelegate )
- ( int ) browser : ( NSBrowser * ) sender numberOfRowsInColumn : ( int ) column { return (int)0; }
- ( void ) browser : ( NSBrowser * ) sender createRowsForColumn : ( int ) column inMatrix : ( NSMatrix * ) matrix {  }
- ( void ) browser : ( NSBrowser * ) sender willDisplayCell : ( id ) cell atRow : ( int ) row column : ( int ) column {  }
- ( NSString * ) browser : ( NSBrowser * ) sender titleOfColumn : ( int ) column { return nil; }
- ( BOOL ) browser : ( NSBrowser * ) sender selectCellWithString : ( NSString * ) title inColumn : ( int ) column { return NO; }
- ( BOOL ) browser : ( NSBrowser * ) sender selectRow : ( int ) row inColumn : ( int ) column { return NO; }
- ( BOOL ) browser : ( NSBrowser * ) sender isColumnValid : ( int ) column { return NO; }
- ( void ) browserWillScroll : ( NSBrowser * ) sender {  }
- ( void ) browserDidScroll : ( NSBrowser * ) sender {  }

/**** NSColorPanel.h ****/
// @interface NSObject ( NSColorPanelResponderMethod )
- ( void ) changeColor : ( id ) sender {  }

/**** NSDragging.h ****/
// @interface NSObject ( NSDraggingDestination )
- ( NSDragOperation ) draggingEntered : ( id < NSDraggingInfo > ) sender { return (NSDragOperation)0; }
- ( NSDragOperation ) draggingUpdated : ( id < NSDraggingInfo > ) sender { return (NSDragOperation)0; }
- ( void ) draggingExited : ( id < NSDraggingInfo > ) sender {  }
- ( BOOL ) prepareForDragOperation : ( id < NSDraggingInfo > ) sender { return NO; }
- ( BOOL ) performDragOperation : ( id < NSDraggingInfo > ) sender { return NO; }
- ( void ) concludeDragOperation : ( id < NSDraggingInfo > ) sender {  }
- ( void ) draggingEnded : ( id < NSDraggingInfo > ) sender {  }

// @interface NSObject ( NSDraggingSource )
- ( NSDragOperation ) draggingSourceOperationMaskForLocal : ( BOOL ) flag { return (NSDragOperation)0; }
- ( NSArray * ) namesOfPromisedFilesDroppedAtDestination : ( NSURL * ) dropDestination { return nil; }
- ( void ) draggedImage : ( NSImage * ) image beganAt : ( NSPoint ) screenPoint {  }
- ( void ) draggedImage : ( NSImage * ) image endedAt : ( NSPoint ) screenPoint operation : ( NSDragOperation ) operation {  }
- ( void ) draggedImage : ( NSImage * ) image movedTo : ( NSPoint ) screenPoint {  }
- ( BOOL ) ignoreModifierKeysWhileDragging { return NO; }
- ( void ) draggedImage : ( NSImage * ) image endedAt : ( NSPoint ) screenPoint deposited : ( BOOL ) flag {  }

/**** NSHelpManager.h ****/
/**** NSImage.h ****/
// @interface NSObject ( NSImageDelegate )
- ( NSImage * ) imageDidNotDraw : ( id ) sender inRect : ( NSRect ) aRect { return nil; }
- ( void ) image : ( NSImage * ) image willLoadRepresentation : ( NSImageRep * ) rep {  }
- ( void ) image : ( NSImage * ) image didLoadRepresentationHeader : ( NSImageRep * ) rep {  }
- ( void ) image : ( NSImage * ) image didLoadPartOfRepresentation : ( NSImageRep * ) rep withValidRows : ( int ) rows {  }
- ( void ) image : ( NSImage * ) image didLoadRepresentation : ( NSImageRep * ) rep withStatus : ( NSImageLoadStatus ) status {  }

/**** NSNibLoading.h ****/
// @interface NSObject ( NSNibAwaking )
- ( void ) awakeFromNib {  }

/**** NSSplitView.h ****/
// @interface NSObject ( NSSplitViewDelegate )
- ( void ) splitView : ( NSSplitView * ) sender resizeSubviewsWithOldSize : ( NSSize ) oldSize {  }
- ( float ) splitView : ( NSSplitView * ) sender constrainMinCoordinate : ( float ) proposedCoord ofSubviewAt : ( int ) offset { return (float)0; }
- ( float ) splitView : ( NSSplitView * ) sender constrainMaxCoordinate : ( float ) proposedCoord ofSubviewAt : ( int ) offset { return (float)0; }
- ( void ) splitViewWillResizeSubviews : ( NSNotification * ) notification {  }
- ( void ) splitViewDidResizeSubviews : ( NSNotification * ) notification {  }
- ( BOOL ) splitView : ( NSSplitView * ) sender canCollapseSubview : ( NSView * ) subview { return NO; }
- ( float ) splitView : ( NSSplitView * ) splitView constrainSplitPosition : ( float ) proposedPosition ofSubviewAt : ( int ) index { return (float)0; }

/**** NSPageLayout.h ****/
/**** NSPasteboard.h ****/
// @interface NSObject ( NSPasteboardOwner )
- ( void ) pasteboard : ( NSPasteboard * ) sender provideDataForType : ( NSString * ) type {  }
- ( void ) pasteboardChangedOwner : ( NSPasteboard * ) sender {  }

/**** NSResponder.h ****/
/**** NSSavePanel.h ****/
// @interface NSObject ( NSSavePanelDelegate )
- ( NSString * ) panel : ( id ) sender userEnteredFilename : ( NSString * ) filename confirmed : ( BOOL ) okFlag { return nil; }
- ( BOOL ) panel : ( id ) sender isValidFilename : ( NSString * ) filename { return NO; }
- ( BOOL ) panel : ( id ) sender shouldShowFilename : ( NSString * ) filename { return NO; }
- ( NSComparisonResult ) panel : ( id ) sender compareFilename : ( NSString * ) file1 with : ( NSString * ) file2 caseSensitive : ( BOOL ) caseSensitive { return (NSComparisonResult)0; }
- ( void ) panel : ( id ) sender willExpand : ( BOOL ) expanding {  }

/**** NSScrollView.h ****/
/**** NSSlider.h ****/
/**** NSSliderCell.h ****/
/**** NSText.h ****/
// @interface NSObject ( NSTextDelegate )
- ( BOOL ) textShouldBeginEditing : ( NSText * ) textObject { return NO; }
- ( BOOL ) textShouldEndEditing : ( NSText * ) textObject { return NO; }
- ( void ) textDidBeginEditing : ( NSNotification * ) notification {  }
- ( void ) textDidEndEditing : ( NSNotification * ) notification {  }
- ( void ) textDidChange : ( NSNotification * ) notification {  }

/**** NSTextField.h ****/
/**** NSView.h ****/
// @interface NSObject ( NSToolTipOwner )
- ( NSString * ) view : ( NSView * ) view stringForToolTip : ( NSToolTipTag ) tag point : ( NSPoint ) point userData : ( void * ) data { return nil; }

/**** NSWindow.h ****/
// @interface NSObject ( NSWindowNotifications )
- ( void ) windowDidResize : ( NSNotification * ) notification {  }
- ( void ) windowDidExpose : ( NSNotification * ) notification {  }
- ( void ) windowWillMove : ( NSNotification * ) notification {  }
- ( void ) windowDidMove : ( NSNotification * ) notification {  }
- ( void ) windowDidBecomeKey : ( NSNotification * ) notification {  }
- ( void ) windowDidResignKey : ( NSNotification * ) notification {  }
- ( void ) windowDidBecomeMain : ( NSNotification * ) notification {  }
- ( void ) windowDidResignMain : ( NSNotification * ) notification {  }
- ( void ) windowWillClose : ( NSNotification * ) notification {  }
- ( void ) windowWillMiniaturize : ( NSNotification * ) notification {  }
- ( void ) windowDidMiniaturize : ( NSNotification * ) notification {  }
- ( void ) windowDidDeminiaturize : ( NSNotification * ) notification {  }
- ( void ) windowDidUpdate : ( NSNotification * ) notification {  }
- ( void ) windowDidChangeScreen : ( NSNotification * ) notification {  }
- ( void ) windowWillBeginSheet : ( NSNotification * ) notification {  }
- ( void ) windowDidEndSheet : ( NSNotification * ) notification {  }

// @interface NSObject ( NSWindowDelegate )
- ( BOOL ) windowShouldClose : ( id ) sender { return NO; }
- ( id ) windowWillReturnFieldEditor : ( NSWindow * ) sender toObject : ( id ) client { return nil; }
- ( NSSize ) windowWillResize : ( NSWindow * ) sender toSize : ( NSSize ) frameSize { NSSize r = {0.0,0.0}; return r; }
- ( NSRect ) windowWillUseStandardFrame : ( NSWindow * ) window defaultFrame : ( NSRect ) newFrame { NSRect r = {{0.0,0.0},{0.0,0.0}}; return r; }
- ( BOOL ) windowShouldZoom : ( NSWindow * ) window toFrame : ( NSRect ) newFrame { return NO; }
- ( NSUndoManager * ) windowWillReturnUndoManager : ( NSWindow * ) window { return nil; }

/**** NSComboBox.h ****/
// @interface NSObject ( NSComboBoxDataSource )
- ( int ) numberOfItemsInComboBox : ( NSComboBox * ) aComboBox { return (int)0; }
- ( id ) comboBox : ( NSComboBox * ) aComboBox objectValueForItemAtIndex : ( int ) index { return nil; }
- ( unsigned int ) comboBox : ( NSComboBox * ) aComboBox indexOfItemWithStringValue : ( NSString * ) string { return (unsigned int)0; }
- ( NSString * ) comboBox : ( NSComboBox * ) aComboBox completedString : ( NSString * ) string { return nil; }

// @interface NSObject ( NSComboBoxNotifications )
- ( void ) comboBoxWillPopUp : ( NSNotification * ) notification {  }
- ( void ) comboBoxWillDismiss : ( NSNotification * ) notification {  }
- ( void ) comboBoxSelectionDidChange : ( NSNotification * ) notification {  }
- ( void ) comboBoxSelectionIsChanging : ( NSNotification * ) notification {  }

/**** NSComboBoxCell.h ****/
// @interface NSObject ( NSComboBoxCellDataSource )
- ( int ) numberOfItemsInComboBoxCell : ( NSComboBoxCell * ) comboBoxCell { return (int)0; }
- ( id ) comboBoxCell : ( NSComboBoxCell * ) aComboBoxCell objectValueForItemAtIndex : ( int ) index { return nil; }
- ( unsigned int ) comboBoxCell : ( NSComboBoxCell * ) aComboBoxCell indexOfItemWithStringValue : ( NSString * ) string { return (unsigned int)0; }
- ( NSString * ) comboBoxCell : ( NSComboBoxCell * ) aComboBoxCell completedString : ( NSString * ) uncompletedString { return nil; }

/**** NSTableView.h ****/
// @interface NSObject ( NSTableViewDelegate )
- ( void ) tableView : ( NSTableView * ) tableView willDisplayCell : ( id ) cell forTableColumn : ( NSTableColumn * ) tableColumn row : ( int ) row {  }
- ( BOOL ) tableView : ( NSTableView * ) tableView shouldEditTableColumn : ( NSTableColumn * ) tableColumn row : ( int ) row { return NO; }
- ( BOOL ) selectionShouldChangeInTableView : ( NSTableView * ) aTableView { return NO; }
- ( BOOL ) tableView : ( NSTableView * ) tableView shouldSelectRow : ( int ) row { return NO; }
- ( BOOL ) tableView : ( NSTableView * ) tableView shouldSelectTableColumn : ( NSTableColumn * ) tableColumn { return NO; }
- ( void ) tableView : ( NSTableView * ) tableView mouseDownInHeaderOfTableColumn : ( NSTableColumn * ) tableColumn {  }
- ( void ) tableView : ( NSTableView * ) tableView didClickTableColumn : ( NSTableColumn * ) tableColumn {  }
- ( void ) tableView : ( NSTableView * ) tableView didDragTableColumn : ( NSTableColumn * ) tableColumn {  }

// @interface NSObject ( NSTableViewNotifications )
- ( void ) tableViewSelectionDidChange : ( NSNotification * ) notification {  }
- ( void ) tableViewColumnDidMove : ( NSNotification * ) notification {  }
- ( void ) tableViewColumnDidResize : ( NSNotification * ) notification {  }
- ( void ) tableViewSelectionIsChanging : ( NSNotification * ) notification {  }

// @interface NSObject ( NSTableDataSource )
- ( int ) numberOfRowsInTableView : ( NSTableView * ) tableView { return (int)0; }
- ( id ) tableView : ( NSTableView * ) tableView objectValueForTableColumn : ( NSTableColumn * ) tableColumn row : ( int ) row { return nil; }
- ( void ) tableView : ( NSTableView * ) tableView setObjectValue : ( id ) object forTableColumn : ( NSTableColumn * ) tableColumn row : ( int ) row {  }
- ( BOOL ) tableView : ( NSTableView * ) tv writeRows : ( NSArray * ) rows toPasteboard : ( NSPasteboard * ) pboard { return NO; }
- ( NSDragOperation ) tableView : ( NSTableView * ) tv validateDrop : ( id < NSDraggingInfo > ) info proposedRow : ( int ) row proposedDropOperation : ( NSTableViewDropOperation ) op { return (NSDragOperation)0; }
- ( BOOL ) tableView : ( NSTableView * ) tv acceptDrop : ( id < NSDraggingInfo > ) info row : ( int ) row dropOperation : ( NSTableViewDropOperation ) op { return NO; }

/**** NSOutlineView.h ****/
// @interface NSObject ( NSOutlineViewDataSource )
- ( id ) outlineView : ( NSOutlineView * ) outlineView child : ( int ) index ofItem : ( id ) item { return nil; }
- ( BOOL ) outlineView : ( NSOutlineView * ) outlineView isItemExpandable : ( id ) item { return NO; }
- ( int ) outlineView : ( NSOutlineView * ) outlineView numberOfChildrenOfItem : ( id ) item { return (int)0; }
- ( id ) outlineView : ( NSOutlineView * ) outlineView objectValueForTableColumn : ( NSTableColumn * ) tableColumn byItem : ( id ) item { return nil; }
- ( void ) outlineView : ( NSOutlineView * ) outlineView setObjectValue : ( id ) object forTableColumn : ( NSTableColumn * ) tableColumn byItem : ( id ) item {  }
- ( id ) outlineView : ( NSOutlineView * ) outlineView itemForPersistentObject : ( id ) object { return nil; }
- ( id ) outlineView : ( NSOutlineView * ) outlineView persistentObjectForItem : ( id ) item { return nil; }
- ( BOOL ) outlineView : ( NSOutlineView * ) olv writeItems : ( NSArray * ) items toPasteboard : ( NSPasteboard * ) pboard { return NO; }
- ( NSDragOperation ) outlineView : ( NSOutlineView * ) olv validateDrop : ( id < NSDraggingInfo > ) info proposedItem : ( id ) item proposedChildIndex : ( int ) index { return (NSDragOperation)0; }
- ( BOOL ) outlineView : ( NSOutlineView * ) olv acceptDrop : ( id < NSDraggingInfo > ) info item : ( id ) item childIndex : ( int ) index { return NO; }

// @interface NSObject ( NSOutlineViewDelegate )
- ( void ) outlineView : ( NSOutlineView * ) outlineView willDisplayCell : ( id ) cell forTableColumn : ( NSTableColumn * ) tableColumn item : ( id ) item {  }
- ( BOOL ) outlineView : ( NSOutlineView * ) outlineView shouldEditTableColumn : ( NSTableColumn * ) tableColumn item : ( id ) item { return NO; }
- ( BOOL ) selectionShouldChangeInOutlineView : ( NSOutlineView * ) outlineView { return NO; }
- ( BOOL ) outlineView : ( NSOutlineView * ) outlineView shouldSelectItem : ( id ) item { return NO; }
- ( BOOL ) outlineView : ( NSOutlineView * ) outlineView shouldSelectTableColumn : ( NSTableColumn * ) tableColumn { return NO; }
- ( BOOL ) outlineView : ( NSOutlineView * ) outlineView shouldExpandItem : ( id ) item { return NO; }
- ( BOOL ) outlineView : ( NSOutlineView * ) outlineView shouldCollapseItem : ( id ) item { return NO; }
- ( void ) outlineView : ( NSOutlineView * ) outlineView willDisplayOutlineCell : ( id ) cell forTableColumn : ( NSTableColumn * ) tableColumn item : ( id ) item {  }

// @interface NSObject ( NSOutlineViewNotifications )
- ( void ) outlineViewSelectionDidChange : ( NSNotification * ) notification {  }
- ( void ) outlineViewColumnDidMove : ( NSNotification * ) notification {  }
- ( void ) outlineViewColumnDidResize : ( NSNotification * ) notification {  }
- ( void ) outlineViewSelectionIsChanging : ( NSNotification * ) notification {  }
- ( void ) outlineViewItemWillExpand : ( NSNotification * ) notification {  }
- ( void ) outlineViewItemDidExpand : ( NSNotification * ) notification {  }
- ( void ) outlineViewItemWillCollapse : ( NSNotification * ) notification {  }
- ( void ) outlineViewItemDidCollapse : ( NSNotification * ) notification {  }

/**** NSAttributedString.h ****/
/**** NSLayoutManager.h ****/
// @interface NSObject ( NSLayoutManagerDelegate )
- ( void ) layoutManagerDidInvalidateLayout : ( NSLayoutManager * ) sender {  }
- ( void ) layoutManager : ( NSLayoutManager * ) layoutManager didCompleteLayoutForTextContainer : ( NSTextContainer * ) textContainer atEnd : ( BOOL ) layoutFinishedFlag {  }

/**** NSTextStorage.h ****/
// @interface NSObject ( NSTextStorageDelegate )
- ( void ) textStorageWillProcessEditing : ( NSNotification * ) notification {  }
- ( void ) textStorageDidProcessEditing : ( NSNotification * ) notification {  }

/**** NSTextView.h ****/
// @interface NSObject ( NSTextViewDelegate )
- ( BOOL ) textView : ( NSTextView * ) textView clickedOnLink : ( id ) link atIndex : ( unsigned ) charIndex { return NO; }
- ( void ) textView : ( NSTextView * ) textView clickedOnCell : ( id < NSTextAttachmentCell > ) cell inRect : ( NSRect ) cellFrame atIndex : ( unsigned ) charIndex {  }
- ( void ) textView : ( NSTextView * ) textView doubleClickedOnCell : ( id < NSTextAttachmentCell > ) cell inRect : ( NSRect ) cellFrame atIndex : ( unsigned ) charIndex {  }
- ( void ) textView : ( NSTextView * ) view draggedCell : ( id < NSTextAttachmentCell > ) cell inRect : ( NSRect ) rect event : ( NSEvent * ) event atIndex : ( unsigned ) charIndex {  }
- ( NSArray * ) textView : ( NSTextView * ) view writablePasteboardTypesForCell : ( id < NSTextAttachmentCell > ) cell atIndex : ( unsigned ) charIndex { return nil; }
- ( BOOL ) textView : ( NSTextView * ) view writeCell : ( id < NSTextAttachmentCell > ) cell atIndex : ( unsigned ) charIndex toPasteboard : ( NSPasteboard * ) pboard type : ( NSString * ) type { return NO; }
- ( NSRange ) textView : ( NSTextView * ) textView willChangeSelectionFromCharacterRange : ( NSRange ) oldSelectedCharRange toCharacterRange : ( NSRange ) newSelectedCharRange { NSRange r = {0,0}; return r; }
- ( void ) textViewDidChangeSelection : ( NSNotification * ) notification {  }
- ( BOOL ) textView : ( NSTextView * ) textView shouldChangeTextInRange : ( NSRange ) affectedCharRange replacementString : ( NSString * ) replacementString { return NO; }
- ( BOOL ) textView : ( NSTextView * ) textView doCommandBySelector : ( SEL ) commandSelector { return NO; }
- ( BOOL ) textView : ( NSTextView * ) textView clickedOnLink : ( id ) link { return NO; }
- ( void ) textView : ( NSTextView * ) textView clickedOnCell : ( id < NSTextAttachmentCell > ) cell inRect : ( NSRect ) cellFrame {  }
- ( void ) textView : ( NSTextView * ) textView doubleClickedOnCell : ( id < NSTextAttachmentCell > ) cell inRect : ( NSRect ) cellFrame {  }
- ( void ) textView : ( NSTextView * ) view draggedCell : ( id < NSTextAttachmentCell > ) cell inRect : ( NSRect ) rect event : ( NSEvent * ) event {  }
- ( NSUndoManager * ) undoManagerForTextView : ( NSTextView * ) view { return nil; }

/**** NSTextAttachment.h ****/
/**** NSStringDrawing.h ****/
/**** NSRulerView.h ****/
/**** NSInterfaceStyle.h ****/
/**** NSTabView.h ****/
// @interface NSObject ( NSTabViewDelegate )
- ( BOOL ) tabView : ( NSTabView * ) tabView shouldSelectTabViewItem : ( NSTabViewItem * ) tabViewItem { return NO; }
- ( void ) tabView : ( NSTabView * ) tabView willSelectTabViewItem : ( NSTabViewItem * ) tabViewItem {  }
- ( void ) tabView : ( NSTabView * ) tabView didSelectTabViewItem : ( NSTabViewItem * ) tabViewItem {  }
- ( void ) tabViewDidChangeNumberOfTabViewItems : ( NSTabView * ) TabView {  }

/**** NSStatusItem.h ****/
/**** NSSound.h ****/
// @interface NSObject ( NSSoundDelegateMethods )
- ( void ) sound : ( NSSound * ) sound didFinishPlaying : ( BOOL ) aBool {  }

/**** NSDrawer.h ****/
// @interface NSObject ( NSDrawerNotifications )
- ( void ) drawerWillOpen : ( NSNotification * ) notification {  }
- ( void ) drawerDidOpen : ( NSNotification * ) notification {  }
- ( void ) drawerWillClose : ( NSNotification * ) notification {  }
- ( void ) drawerDidClose : ( NSNotification * ) notification {  }

// @interface NSObject ( NSDrawerDelegate )
- ( BOOL ) drawerShouldOpen : ( NSDrawer * ) sender { return NO; }
- ( BOOL ) drawerShouldClose : ( NSDrawer * ) sender { return NO; }
- ( NSSize ) drawerWillResizeContents : ( NSDrawer * ) sender toSize : ( NSSize ) contentSize { NSSize r = {0.0,0.0}; return r; }

/**** NSApplicationScripting.h ****/
// @interface NSObject ( NSApplicationScriptingDelegation )
- ( BOOL ) application : ( NSApplication * ) sender delegateHandlesKey : ( NSString * ) key { return NO; }

/**** NSDocumentScripting.h ****/
/**** NSTextStorageScripting.h ****/
/**** NSToolbar.h ****/
// @interface NSObject ( NSToolbarDelegate )
- ( NSToolbarItem * ) toolbar : ( NSToolbar * ) toolbar itemForItemIdentifier : ( NSString * ) itemIdentifier willBeInsertedIntoToolbar : ( BOOL ) flag { return nil; }
- ( NSArray * ) toolbarDefaultItemIdentifiers : ( NSToolbar * ) toolbar { return nil; }
- ( NSArray * ) toolbarAllowedItemIdentifiers : ( NSToolbar * ) toolbar { return nil; }

// @interface NSObject ( NSToolbarNotifications )
- ( void ) toolbarWillAddItem : ( NSNotification * ) notification {  }
- ( void ) toolbarDidRemoveItem : ( NSNotification * ) notification {  }

/**** NSToolbarItem.h ****/
// @interface NSObject ( NSToolbarItemValidation )
- ( BOOL ) validateToolbarItem : ( NSToolbarItem * ) theItem { return NO; }

/**** NSWindowScripting.h ****/


@end
