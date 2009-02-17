#
#  $Id: webkit.rb 710 2004-12-09 13:36:44Z kimuraw $
#
#  Copyright (c) 2003 kimura wataru <kimuraw@i.nifty.jp>
#
require 'osx/cocoa'

module OSX

  # load WebKit.framework
  NSBundle.bundleWithPath('/System/Library/Frameworks/WebKit.framework').load

  ## Web Kit
  # import classes
  #  ns_import :WebAuthenticationChallenge	# missing?
  ns_import :WebBackForwardList
  ns_import :WebDataSource
  ns_import :WebDownload
  ns_import :WebFrame
  ns_import :WebFrameView
  ns_import :WebHistory
  ns_import :WebHistoryItem
  ns_import :WebPreferences
  ns_import :WebView


  # enums
  # -- WebNavigationType(in WebKit/WebPolicyDelegate.h)
  WebNavigationTypeLinkClicked = 0x0
  WebNavigationTypeFormSubmitted = 0x1
  WebNavigationTypeBackForward = 0x2
  WebNavigationTypeReload = 0x3
  WebNavigationTypeFormResubmitted = 0x4
  WebNavigationTypeOther = 0x5

  # -- Menu Item Tag(in WebKit/WebUIDelegate.h)
  WebMenuItemTagOpenLinkInNewWindow = 0x1
  WebMenuItemTagDownloadLinkToDisk = 0x2
  WebMenuItemTagCopyLinkToClipboard = 0x3
  WebMenuItemTagOpenImageInNewWindow = 0x4
  WebMenuItemTagDownloadImageToDisk = 0x5
  WebMenuItemTagCopyImageToClipboard = 0x6
  WebMenuItemTagOpenFrameInNewWindow = 0x7
  WebMenuItemTagCopy = 0x8

  # -- Web Kit Policy Errors(in WebKit/WebKitErrors.h)
  WebKitErrorCannotShowMIMEType = 100
  WebKitErrorCannotShowURL = 101
  WebKitErrorFrameLoadInterruptedByPolicyChange = 102

  # -- Web Kit Plug-in and Java Errors(in WebKit/WebKitErrors.h)
  WebKitErrorCannotFindPlugin = 200
  WebKitErrorCannotLoadPlugin = 201
  WebKitErrorJavaUnavailable = 202


  # constants
  [
    # -- WebHistory - User Info Dictionary Key
    :WebHistoryItemsKey,

    # -- WebHistory Notification Names
    :WebHistoryItemsAddedNotification,
    :WebHistoryItemsRemovedNotification,
    :WebHistoryAllItemsRemovedNotification,
    :WebHistoryLoadedNotification,
    :WebHistorySavedNotification,

    # -- WebPolicyDelegate - Action Dictionary Keys
    :WebActionNavigationTypeKey,
    :WebActionElementKey,
    :WebActionButtonKey,
    :WebActionModifierFlagsKey,
    :WebActionOriginalURLKey,

    # -- WebPreferencesChangedNotification,
    :WebPreferencesChangedNotification,

    # -- WebView - Element Dictionary Keys
    :WebElementFrameKey,
    :WebElementImageAltStringKey,
    :WebElementImageKey,
    :WebElementImageRectKey,
    :WebElementImageURLKey,
    :WebElementIsSelectedKey,
    :WebElementLinkURLKey,
    :WebElementLinkTargetFrameKey,
    :WebElementLinkTitleKey,
    :WebElementLinkLabelKey,

    # -- WebView Notification Names
    :WebViewProgressStartedNotification,
    :WebViewProgressEstimateChangedNotification,
    :WebViewProgressFinishedNotification,

    # -- Other Web Kit Errors
    :WebKitErrorDomain,
    :WebKitErrorMIMETypeKey,
    :WebKitErrorPlugInNameKey,
    :WebKitErrorPlugInPageURLStringKey
  ].each do |name|
    module_eval %{
      def #{name}
	objc_symbol_to_obj('#{name}', '@')
      end
      module_function :#{name}
    }
  end


  module WebFoundation
	 ## Web Foundation (needs earlier Jaguar)
	 # import classes
	 OSX.ns_import :NSCachedURLResponse
	 OSX.ns_import :NSError
	 OSX.ns_import :NSHTTPCookie
	 OSX.ns_import :NSHTTPCookieStorage
	 OSX.ns_import :NSHTTPURLResponse
	 OSX.ns_import :NSMutableURLRequest
	 OSX.ns_import :NSURLAuthenticationChallenge
	 OSX.ns_import :NSURLCache
	 OSX.ns_import :NSURLConnection
	 OSX.ns_import :NSURLCredential
	 OSX.ns_import :NSURLCredentialStorage
	 OSX.ns_import :NSURLDownload
	 OSX.ns_import :NSURLProtectionSpace
	 OSX.ns_import :NSURLProtocol
	 OSX.ns_import :NSURLRequest
	 OSX.ns_import :NSURLResponse


	 # enums
	 # -- NSURLCacheStoragePolicy(in Foundation/NSURLCache.h)
	 NSURLCacheStorageAllowed = 0x0
	 NSURLCacheStorageAllowedInMemoryOnly = 0x1
	 NSURLCacheStorageNotAllowed = 0x2

	 # -- NSHTTPCookieAcceptPolicy(in Foundation/NSHTTPCookieStorage.h)
	 NSHTTPCookieAcceptPolicyAlways = 0x0
	 NSHTTPCookieAcceptPolicyNever = 0x1
	 NSHTTPCookieAcceptPolicyOnlyFromMainDocumentDomain = 0x2

	 # -- NSURLCredentialPersistence(in Foundation/NSURLCredential.h)
	 NSURLCredentialPersistenceNone = 0x0
	 NSURLCredentialPersistenceForSession = 0x1
	 NSURLCredentialPersistencePermanent = 0x2
	 
	 # -- NSURLRequestCachePolicy(in Foundation/NSURLRequest.h)
	 NSURLRequestUseProtocolCachePolicy = 0x0
	 NSURLRequestReloadIgnoringCacheData = 0x1
	 NSURLRequestReturnCacheDataElseLoad = 0x2
	 NSURLRequestReturnCacheDataDontLoad = 0x3

	 # -- Web Foundation Error codes(in Foundation/NSURLError.h)
	 NSURLErrorUnknown = -1
	 NSURLErrorCancelled = -999 
	 NSURLErrorBadURL = -1000
	 NSURLErrorTimedOut = -1001
	 NSURLErrorUnsupportedURL = -1002
	 NSURLErrorCannotFindHost = -1003
	 NSURLErrorCannotConnectToHost = -1004
	 NSURLErrorNetworkConnectionLost = -1005
	 NSURLErrorDNSLookupFailed = -1006
	 NSURLErrorHTTPTooManyRedirects = -1007
	 NSURLErrorResourceUnavailable = -1008
	 NSURLErrorNotConnectedToInternet = -1009
	 NSURLErrorRedirectToNonExistentLocation = -1010
	 NSURLErrorBadServerResponse = -1011
	 NSURLErrorUserCancelledAuthentication = -1012
	 NSURLErrorUserAuthenticationRequired = -1013
	 NSURLErrorZeroByteResource = -1014
	 NSURLErrorFileDoesNotExist = -1100
	 NSURLErrorFileIsDirectory = -1101
	 NSURLErrorNoPermissionsToReadFile = -1102
	 NSURLErrorSecureConnectionFailed = -1200
	 NSURLErrorServerCertificateHasBadDate = -1201
	 NSURLErrorServerCertificateUntrusted = -1202
	 NSURLErrorServerCertificateHasUnknownRoot = -1203
	 NSURLErrorCannotLoadFromNetwork = -2000
	 #   -- Download and file I/O errors
	 NSURLErrorCannotCreateFile = -3000
	 NSURLErrorCannotOpenFile = -3001
	 NSURLErrorCannotCloseFile = -3002
	 NSURLErrorCannotWriteToFile = -3003
	 NSURLErrorCannotRemoveFile = -3004
	 NSURLErrorCannotMoveFile = -3005
	 NSURLErrorDownloadDecodingFailedMidStream = -3006
	 NSURLErrorDownloadDecodingFailedToComplete = -3007


	 # constants
	 [
		# -- NSError Description Localization Key
		:NSLocalizedDescriptionKey,

		# -- NSError Error Domains
		:NSPOSIXErrorDomain,
		:NSOSStatusErrorDomain,
		:NSMachErrorDomain,
		:NSURLErrorDomain,		# in Foundation/NSURLError
		:NSURLCFStreamErrorDomain,	# ??? precompiled header ???

		# -- NSError URL Key
		:NSErrorFailingURLStringKey,

		# -- HTTP Cookie Property Keys
		:NSHTTPCookieComment,
		:NSHTTPCookieCommentURL,
		:NSHTTPCookieDiscard,
		:NSHTTPCookieDomain,
		:NSHTTPCookieExpires,
		:NSHTTPCookieMaximumAge,
		:NSHTTPCookieName,
		:NSHTTPCookieOriginURL,
		:NSHTTPCookiePath,
		:NSHTTPCookiePort,
		:NSHTTPCookieSecure,
		:NSHTTPCookieValue,
		:NSHTTPCookieVersion,

		# -- NSURLProtectionSpace Authentication Methods
		:NSURLAuthenticationMethodDefault,
		:NSURLAuthenticationMethodHTTPBasic,
		:NSURLAuthenticationMethodHTTPDigest,
		:NSURLAuthenticationMethodHTMLForm,

		# -- NSURLProtectionSpace Proxy Types
		:NSURLProtectionSpaceHTTPProxy,
		:NSURLProtectionSpaceHTTPSProxy,
		:NSURLProtectionSpaceFTPProxy,
		:NSURLProtectionSpaceSOCKSProxy,

		# -- NSHTTPCookieStorage Notification Names
		:NSHTTPCookieStorageAcceptPolicyChangedNotification,
		:NSHTTPCookieStorageCookiesChangedNotification,

		# -- NSURLCredentialStorage Notification Names
		:NSURLCredentialStorageChangedNotification

	 ].each do |name|
		module_eval %{
		  def #{name}
	  objc_symbol_to_obj('#{name}', '@')
		  end
		  module_function :#{name}
		}
	 end
  end

  if OSX.NSFoundationVersionNumber <= 462.0 then
    include WebFoundation
  end

end
