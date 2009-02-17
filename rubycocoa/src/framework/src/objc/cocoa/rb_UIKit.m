#import "osx_ruby.h"
#import "ocdata_conv.h"
#import <UIKit/UIKit.h>

extern VALUE oc_err_new (const char* fname, NSException* nsexcp);
extern void rbarg_to_nsarg(VALUE rbarg, int octype, void* nsarg, const char* fname, id pool, int index);
extern VALUE nsresult_to_rbresult(int octype, const void* nsresult, const char* fname, id pool);
static const int VA_MAX = 4;


void init_UIActivityIndicatorView(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UIActivityIndicatorViewStyleWhiteLarge", INT2NUM(UIActivityIndicatorViewStyleWhiteLarge));
  rb_define_const(mOSX, "UIActivityIndicatorViewStyleWhite", INT2NUM(UIActivityIndicatorViewStyleWhite));
  rb_define_const(mOSX, "UIActivityIndicatorViewStyleGray", INT2NUM(UIActivityIndicatorViewStyleGray));

}
void init_UIAlert(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UIActionSheetStyleAutomatic", INT2NUM(UIActionSheetStyleAutomatic));
  rb_define_const(mOSX, "UIActionSheetStyleDefault", INT2NUM(UIActionSheetStyleDefault));
  rb_define_const(mOSX, "UIActionSheetStyleBlackTranslucent", INT2NUM(UIActionSheetStyleBlackTranslucent));
  rb_define_const(mOSX, "UIActionSheetStyleBlackOpaque", INT2NUM(UIActionSheetStyleBlackOpaque));

}
  /**** constants ****/
// NSString *const UITrackingRunLoopMode;
static VALUE
osx_UITrackingRunLoopMode(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UITrackingRunLoopMode, "UITrackingRunLoopMode", nil);
}

// NSString *const UIApplicationDidFinishLaunchingNotification;
static VALUE
osx_UIApplicationDidFinishLaunchingNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIApplicationDidFinishLaunchingNotification, "UIApplicationDidFinishLaunchingNotification", nil);
}

// NSString *const UIApplicationDidBecomeActiveNotification;
static VALUE
osx_UIApplicationDidBecomeActiveNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIApplicationDidBecomeActiveNotification, "UIApplicationDidBecomeActiveNotification", nil);
}

// NSString *const UIApplicationWillResignActiveNotification;
static VALUE
osx_UIApplicationWillResignActiveNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIApplicationWillResignActiveNotification, "UIApplicationWillResignActiveNotification", nil);
}

// NSString *const UIApplicationDidReceiveMemoryWarningNotification;
static VALUE
osx_UIApplicationDidReceiveMemoryWarningNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIApplicationDidReceiveMemoryWarningNotification, "UIApplicationDidReceiveMemoryWarningNotification", nil);
}

// NSString *const UIApplicationWillTerminateNotification;
static VALUE
osx_UIApplicationWillTerminateNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIApplicationWillTerminateNotification, "UIApplicationWillTerminateNotification", nil);
}

// NSString *const UIApplicationSignificantTimeChangeNotification;
static VALUE
osx_UIApplicationSignificantTimeChangeNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIApplicationSignificantTimeChangeNotification, "UIApplicationSignificantTimeChangeNotification", nil);
}

// NSString *const UIApplicationWillChangeStatusBarOrientationNotification;
static VALUE
osx_UIApplicationWillChangeStatusBarOrientationNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIApplicationWillChangeStatusBarOrientationNotification, "UIApplicationWillChangeStatusBarOrientationNotification", nil);
}

// NSString *const UIApplicationDidChangeStatusBarOrientationNotification;
static VALUE
osx_UIApplicationDidChangeStatusBarOrientationNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIApplicationDidChangeStatusBarOrientationNotification, "UIApplicationDidChangeStatusBarOrientationNotification", nil);
}

// NSString *const UIApplicationStatusBarOrientationUserInfoKey;
static VALUE
osx_UIApplicationStatusBarOrientationUserInfoKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIApplicationStatusBarOrientationUserInfoKey, "UIApplicationStatusBarOrientationUserInfoKey", nil);
}

// NSString *const UIApplicationWillChangeStatusBarFrameNotification;
static VALUE
osx_UIApplicationWillChangeStatusBarFrameNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIApplicationWillChangeStatusBarFrameNotification, "UIApplicationWillChangeStatusBarFrameNotification", nil);
}

// NSString *const UIApplicationDidChangeStatusBarFrameNotification;
static VALUE
osx_UIApplicationDidChangeStatusBarFrameNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIApplicationDidChangeStatusBarFrameNotification, "UIApplicationDidChangeStatusBarFrameNotification", nil);
}

// NSString *const UIApplicationStatusBarFrameUserInfoKey;
static VALUE
osx_UIApplicationStatusBarFrameUserInfoKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIApplicationStatusBarFrameUserInfoKey, "UIApplicationStatusBarFrameUserInfoKey", nil);
}

  /**** functions ****/
// int UIApplicationMain(int argc, char *argv[], NSString *principalClassName, NSString *delegateClassName);
static VALUE
osx_UIApplicationMain(VALUE mdl, VALUE a0, VALUE a1, VALUE a2, VALUE a3)
{
  int ns_result;

  int ns_a0;
  char ** ns_a1;
  NSString * ns_a2;
  NSString * ns_a3;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _C_INT, &ns_a0, "UIApplicationMain", pool, 0);
  /* a1 */
  rbarg_to_nsarg(a1, _PRIV_C_PTR, &ns_a1, "UIApplicationMain", pool, 1);
  /* a2 */
  rbarg_to_nsarg(a2, _C_ID, &ns_a2, "UIApplicationMain", pool, 2);
  /* a3 */
  rbarg_to_nsarg(a3, _C_ID, &ns_a3, "UIApplicationMain", pool, 3);

NS_DURING
  ns_result = UIApplicationMain(ns_a0, ns_a1, ns_a2, ns_a3);
NS_HANDLER
  excp = oc_err_new ("UIApplicationMain", localException);
NS_ENDHANDLER
  if (excp != Qnil) {
    [pool release];
    rb_exc_raise (excp);
    return Qnil;
  }

  rb_result = nsresult_to_rbresult(_C_INT, &ns_result, "UIApplicationMain", pool);
  [pool release];
  return rb_result;
}

void init_UIApplication(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UIStatusBarStyleDefault", INT2NUM(UIStatusBarStyleDefault));
  rb_define_const(mOSX, "UIStatusBarStyleBlackTranslucent", INT2NUM(UIStatusBarStyleBlackTranslucent));
  rb_define_const(mOSX, "UIStatusBarStyleBlackOpaque", INT2NUM(UIStatusBarStyleBlackOpaque));
  rb_define_const(mOSX, "UIInterfaceOrientationPortrait", INT2NUM(UIInterfaceOrientationPortrait));
  rb_define_const(mOSX, "UIInterfaceOrientationPortraitUpsideDown", INT2NUM(UIInterfaceOrientationPortraitUpsideDown));
  rb_define_const(mOSX, "UIInterfaceOrientationLandscapeLeft", INT2NUM(UIInterfaceOrientationLandscapeLeft));
  rb_define_const(mOSX, "UIInterfaceOrientationLandscapeRight", INT2NUM(UIInterfaceOrientationLandscapeRight));

  /**** constants ****/
  rb_define_module_function(mOSX, "UITrackingRunLoopMode", osx_UITrackingRunLoopMode, 0);
  rb_define_module_function(mOSX, "UIApplicationDidFinishLaunchingNotification", osx_UIApplicationDidFinishLaunchingNotification, 0);
  rb_define_module_function(mOSX, "UIApplicationDidBecomeActiveNotification", osx_UIApplicationDidBecomeActiveNotification, 0);
  rb_define_module_function(mOSX, "UIApplicationWillResignActiveNotification", osx_UIApplicationWillResignActiveNotification, 0);
  rb_define_module_function(mOSX, "UIApplicationDidReceiveMemoryWarningNotification", osx_UIApplicationDidReceiveMemoryWarningNotification, 0);
  rb_define_module_function(mOSX, "UIApplicationWillTerminateNotification", osx_UIApplicationWillTerminateNotification, 0);
  rb_define_module_function(mOSX, "UIApplicationSignificantTimeChangeNotification", osx_UIApplicationSignificantTimeChangeNotification, 0);
  rb_define_module_function(mOSX, "UIApplicationWillChangeStatusBarOrientationNotification", osx_UIApplicationWillChangeStatusBarOrientationNotification, 0);
  rb_define_module_function(mOSX, "UIApplicationDidChangeStatusBarOrientationNotification", osx_UIApplicationDidChangeStatusBarOrientationNotification, 0);
  rb_define_module_function(mOSX, "UIApplicationStatusBarOrientationUserInfoKey", osx_UIApplicationStatusBarOrientationUserInfoKey, 0);
  rb_define_module_function(mOSX, "UIApplicationWillChangeStatusBarFrameNotification", osx_UIApplicationWillChangeStatusBarFrameNotification, 0);
  rb_define_module_function(mOSX, "UIApplicationDidChangeStatusBarFrameNotification", osx_UIApplicationDidChangeStatusBarFrameNotification, 0);
  rb_define_module_function(mOSX, "UIApplicationStatusBarFrameUserInfoKey", osx_UIApplicationStatusBarFrameUserInfoKey, 0);
  /**** functions ****/
  rb_define_module_function(mOSX, "UIApplicationMain", osx_UIApplicationMain, 4);
}
void init_UIBarButtonItem(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UIBarButtonItemStylePlain", INT2NUM(UIBarButtonItemStylePlain));
  rb_define_const(mOSX, "UIBarButtonItemStyleBordered", INT2NUM(UIBarButtonItemStyleBordered));
  rb_define_const(mOSX, "UIBarButtonItemStyleDone", INT2NUM(UIBarButtonItemStyleDone));
  rb_define_const(mOSX, "UIBarButtonSystemItemDone", INT2NUM(UIBarButtonSystemItemDone));
  rb_define_const(mOSX, "UIBarButtonSystemItemCancel", INT2NUM(UIBarButtonSystemItemCancel));
  rb_define_const(mOSX, "UIBarButtonSystemItemEdit", INT2NUM(UIBarButtonSystemItemEdit));
  rb_define_const(mOSX, "UIBarButtonSystemItemSave", INT2NUM(UIBarButtonSystemItemSave));
  rb_define_const(mOSX, "UIBarButtonSystemItemAdd", INT2NUM(UIBarButtonSystemItemAdd));
  rb_define_const(mOSX, "UIBarButtonSystemItemFlexibleSpace", INT2NUM(UIBarButtonSystemItemFlexibleSpace));
  rb_define_const(mOSX, "UIBarButtonSystemItemFixedSpace", INT2NUM(UIBarButtonSystemItemFixedSpace));
  rb_define_const(mOSX, "UIBarButtonSystemItemCompose", INT2NUM(UIBarButtonSystemItemCompose));
  rb_define_const(mOSX, "UIBarButtonSystemItemReply", INT2NUM(UIBarButtonSystemItemReply));
  rb_define_const(mOSX, "UIBarButtonSystemItemAction", INT2NUM(UIBarButtonSystemItemAction));
  rb_define_const(mOSX, "UIBarButtonSystemItemOrganize", INT2NUM(UIBarButtonSystemItemOrganize));
  rb_define_const(mOSX, "UIBarButtonSystemItemBookmarks", INT2NUM(UIBarButtonSystemItemBookmarks));
  rb_define_const(mOSX, "UIBarButtonSystemItemSearch", INT2NUM(UIBarButtonSystemItemSearch));
  rb_define_const(mOSX, "UIBarButtonSystemItemRefresh", INT2NUM(UIBarButtonSystemItemRefresh));
  rb_define_const(mOSX, "UIBarButtonSystemItemStop", INT2NUM(UIBarButtonSystemItemStop));
  rb_define_const(mOSX, "UIBarButtonSystemItemCamera", INT2NUM(UIBarButtonSystemItemCamera));
  rb_define_const(mOSX, "UIBarButtonSystemItemTrash", INT2NUM(UIBarButtonSystemItemTrash));
  rb_define_const(mOSX, "UIBarButtonSystemItemPlay", INT2NUM(UIBarButtonSystemItemPlay));
  rb_define_const(mOSX, "UIBarButtonSystemItemPause", INT2NUM(UIBarButtonSystemItemPause));
  rb_define_const(mOSX, "UIBarButtonSystemItemRewind", INT2NUM(UIBarButtonSystemItemRewind));
  rb_define_const(mOSX, "UIBarButtonSystemItemFastForward", INT2NUM(UIBarButtonSystemItemFastForward));

}
void init_UIButton(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UIButtonTypeCustom", INT2NUM(UIButtonTypeCustom));
  rb_define_const(mOSX, "UIButtonTypeRoundedRect", INT2NUM(UIButtonTypeRoundedRect));
  rb_define_const(mOSX, "UIButtonTypeDetailDisclosure", INT2NUM(UIButtonTypeDetailDisclosure));
  rb_define_const(mOSX, "UIButtonTypeInfoLight", INT2NUM(UIButtonTypeInfoLight));
  rb_define_const(mOSX, "UIButtonTypeInfoDark", INT2NUM(UIButtonTypeInfoDark));
  rb_define_const(mOSX, "UIButtonTypeContactAdd", INT2NUM(UIButtonTypeContactAdd));

}
void init_UIControl(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UIControlEventTouchDown", INT2NUM(UIControlEventTouchDown));
  rb_define_const(mOSX, "UIControlEventTouchDownRepeat", INT2NUM(UIControlEventTouchDownRepeat));
  rb_define_const(mOSX, "UIControlEventTouchDragInside", INT2NUM(UIControlEventTouchDragInside));
  rb_define_const(mOSX, "UIControlEventTouchDragOutside", INT2NUM(UIControlEventTouchDragOutside));
  rb_define_const(mOSX, "UIControlEventTouchDragEnter", INT2NUM(UIControlEventTouchDragEnter));
  rb_define_const(mOSX, "UIControlEventTouchDragExit", INT2NUM(UIControlEventTouchDragExit));
  rb_define_const(mOSX, "UIControlEventTouchUpInside", INT2NUM(UIControlEventTouchUpInside));
  rb_define_const(mOSX, "UIControlEventTouchUpOutside", INT2NUM(UIControlEventTouchUpOutside));
  rb_define_const(mOSX, "UIControlEventTouchCancel", INT2NUM(UIControlEventTouchCancel));
  rb_define_const(mOSX, "UIControlEventValueChanged", INT2NUM(UIControlEventValueChanged));
  rb_define_const(mOSX, "UIControlEventEditingDidBegin", INT2NUM(UIControlEventEditingDidBegin));
  rb_define_const(mOSX, "UIControlEventEditingChanged", INT2NUM(UIControlEventEditingChanged));
  rb_define_const(mOSX, "UIControlEventEditingDidEnd", INT2NUM(UIControlEventEditingDidEnd));
  rb_define_const(mOSX, "UIControlEventEditingDidEndOnExit", INT2NUM(UIControlEventEditingDidEndOnExit));
  rb_define_const(mOSX, "UIControlEventAllTouchEvents", INT2NUM(UIControlEventAllTouchEvents));
  rb_define_const(mOSX, "UIControlEventAllEditingEvents", INT2NUM(UIControlEventAllEditingEvents));
  rb_define_const(mOSX, "UIControlEventApplicationReserved", INT2NUM(UIControlEventApplicationReserved));
  rb_define_const(mOSX, "UIControlEventSystemReserved", INT2NUM(UIControlEventSystemReserved));
  rb_define_const(mOSX, "UIControlEventAllEvents", INT2NUM(UIControlEventAllEvents));
  rb_define_const(mOSX, "UIControlContentVerticalAlignmentCenter", INT2NUM(UIControlContentVerticalAlignmentCenter));
  rb_define_const(mOSX, "UIControlContentVerticalAlignmentTop", INT2NUM(UIControlContentVerticalAlignmentTop));
  rb_define_const(mOSX, "UIControlContentVerticalAlignmentBottom", INT2NUM(UIControlContentVerticalAlignmentBottom));
  rb_define_const(mOSX, "UIControlContentVerticalAlignmentFill", INT2NUM(UIControlContentVerticalAlignmentFill));
  rb_define_const(mOSX, "UIControlContentHorizontalAlignmentCenter", INT2NUM(UIControlContentHorizontalAlignmentCenter));
  rb_define_const(mOSX, "UIControlContentHorizontalAlignmentLeft", INT2NUM(UIControlContentHorizontalAlignmentLeft));
  rb_define_const(mOSX, "UIControlContentHorizontalAlignmentRight", INT2NUM(UIControlContentHorizontalAlignmentRight));
  rb_define_const(mOSX, "UIControlContentHorizontalAlignmentFill", INT2NUM(UIControlContentHorizontalAlignmentFill));
  rb_define_const(mOSX, "UIControlStateNormal", INT2NUM(UIControlStateNormal));
  rb_define_const(mOSX, "UIControlStateHighlighted", INT2NUM(UIControlStateHighlighted));
  rb_define_const(mOSX, "UIControlStateDisabled", INT2NUM(UIControlStateDisabled));
  rb_define_const(mOSX, "UIControlStateSelected", INT2NUM(UIControlStateSelected));
  rb_define_const(mOSX, "UIControlStateApplication", INT2NUM(UIControlStateApplication));
  rb_define_const(mOSX, "UIControlStateReserved", INT2NUM(UIControlStateReserved));

}
void init_UIDatePicker(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UIDatePickerModeTime", INT2NUM(UIDatePickerModeTime));
  rb_define_const(mOSX, "UIDatePickerModeDate", INT2NUM(UIDatePickerModeDate));
  rb_define_const(mOSX, "UIDatePickerModeDateAndTime", INT2NUM(UIDatePickerModeDateAndTime));
  rb_define_const(mOSX, "UIDatePickerModeCountDownTimer", INT2NUM(UIDatePickerModeCountDownTimer));

}
  /**** constants ****/
// NSString *const UIDeviceOrientationDidChangeNotification;
static VALUE
osx_UIDeviceOrientationDidChangeNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIDeviceOrientationDidChangeNotification, "UIDeviceOrientationDidChangeNotification", nil);
}

void init_UIDevice(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UIDeviceOrientationUnknown", INT2NUM(UIDeviceOrientationUnknown));
  rb_define_const(mOSX, "UIDeviceOrientationPortrait", INT2NUM(UIDeviceOrientationPortrait));
  rb_define_const(mOSX, "UIDeviceOrientationPortraitUpsideDown", INT2NUM(UIDeviceOrientationPortraitUpsideDown));
  rb_define_const(mOSX, "UIDeviceOrientationLandscapeLeft", INT2NUM(UIDeviceOrientationLandscapeLeft));
  rb_define_const(mOSX, "UIDeviceOrientationLandscapeRight", INT2NUM(UIDeviceOrientationLandscapeRight));
  rb_define_const(mOSX, "UIDeviceOrientationFaceUp", INT2NUM(UIDeviceOrientationFaceUp));
  rb_define_const(mOSX, "UIDeviceOrientationFaceDown", INT2NUM(UIDeviceOrientationFaceDown));

  /**** constants ****/
  rb_define_module_function(mOSX, "UIDeviceOrientationDidChangeNotification", osx_UIDeviceOrientationDidChangeNotification, 0);
}
  /**** constants ****/
// const UIEdgeInsets UIEdgeInsetsZero;
static VALUE
osx_UIEdgeInsetsZero(VALUE mdl)
{
  rb_notimplement();
}

  /**** functions ****/
// NSString *NSStringFromCGPoint(CGPoint point);
static VALUE
osx_NSStringFromCGPoint(VALUE mdl, VALUE a0)
{
  rb_notimplement();
}

// NSString *NSStringFromCGSize(CGSize size);
static VALUE
osx_NSStringFromCGSize(VALUE mdl, VALUE a0)
{
  rb_notimplement();
}

// NSString *NSStringFromCGRect(CGRect rect);
static VALUE
osx_NSStringFromCGRect(VALUE mdl, VALUE a0)
{
  rb_notimplement();
}

// NSString *NSStringFromCGAffineTransform(CGAffineTransform transform);
static VALUE
osx_NSStringFromCGAffineTransform(VALUE mdl, VALUE a0)
{
  rb_notimplement();
}

// NSString *NSStringFromUIEdgeInsets(UIEdgeInsets insets);
static VALUE
osx_NSStringFromUIEdgeInsets(VALUE mdl, VALUE a0)
{
  rb_notimplement();
}

// CGPoint CGPointFromString(NSString *string);
static VALUE
osx_CGPointFromString(VALUE mdl, VALUE a0)
{
  rb_notimplement();
}

// CGSize CGSizeFromString(NSString *string);
static VALUE
osx_CGSizeFromString(VALUE mdl, VALUE a0)
{
  rb_notimplement();
}

// CGRect CGRectFromString(NSString *string);
static VALUE
osx_CGRectFromString(VALUE mdl, VALUE a0)
{
  rb_notimplement();
}

// CGAffineTransform CGAffineTransformFromString(NSString *string);
static VALUE
osx_CGAffineTransformFromString(VALUE mdl, VALUE a0)
{
  rb_notimplement();
}

// UIEdgeInsets UIEdgeInsetsFromString(NSString *string);
static VALUE
osx_UIEdgeInsetsFromString(VALUE mdl, VALUE a0)
{
  rb_notimplement();
}

void init_UIGeometry(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "UIEdgeInsetsZero", osx_UIEdgeInsetsZero, 0);
  /**** functions ****/
  rb_define_module_function(mOSX, "NSStringFromCGPoint", osx_NSStringFromCGPoint, 1);
  rb_define_module_function(mOSX, "NSStringFromCGSize", osx_NSStringFromCGSize, 1);
  rb_define_module_function(mOSX, "NSStringFromCGRect", osx_NSStringFromCGRect, 1);
  rb_define_module_function(mOSX, "NSStringFromCGAffineTransform", osx_NSStringFromCGAffineTransform, 1);
  rb_define_module_function(mOSX, "NSStringFromUIEdgeInsets", osx_NSStringFromUIEdgeInsets, 1);
  rb_define_module_function(mOSX, "CGPointFromString", osx_CGPointFromString, 1);
  rb_define_module_function(mOSX, "CGSizeFromString", osx_CGSizeFromString, 1);
  rb_define_module_function(mOSX, "CGRectFromString", osx_CGRectFromString, 1);
  rb_define_module_function(mOSX, "CGAffineTransformFromString", osx_CGAffineTransformFromString, 1);
  rb_define_module_function(mOSX, "UIEdgeInsetsFromString", osx_UIEdgeInsetsFromString, 1);
}
  /**** functions ****/
// CGContextRef UIGraphicsGetCurrentContext(void);
static VALUE
osx_UIGraphicsGetCurrentContext(VALUE mdl)
{
  rb_notimplement();
}

// void UIGraphicsPushContext(CGContextRef context);
static VALUE
osx_UIGraphicsPushContext(VALUE mdl, VALUE a0)
{
  rb_notimplement();
}

// void UIGraphicsPopContext(void);
static VALUE
osx_UIGraphicsPopContext(VALUE mdl)
{
  UIGraphicsPopContext();
  return Qnil;
}

// void UIRectFillUsingBlendMode(CGRect rect, CGBlendMode blendMode);
static VALUE
osx_UIRectFillUsingBlendMode(VALUE mdl, VALUE a0, VALUE a1)
{
  rb_notimplement();
}

// void UIRectFill(CGRect rect);
static VALUE
osx_UIRectFill(VALUE mdl, VALUE a0)
{
  rb_notimplement();
}

// void UIRectFrameUsingBlendMode(CGRect rect, CGBlendMode blendMode);
static VALUE
osx_UIRectFrameUsingBlendMode(VALUE mdl, VALUE a0, VALUE a1)
{
  rb_notimplement();
}

// void UIRectFrame(CGRect rect);
static VALUE
osx_UIRectFrame(VALUE mdl, VALUE a0)
{
  rb_notimplement();
}

// void UIRectClip(CGRect rect);
static VALUE
osx_UIRectClip(VALUE mdl, VALUE a0)
{
  rb_notimplement();
}

// void UIGraphicsBeginImageContext(CGSize size);
static VALUE
osx_UIGraphicsBeginImageContext(VALUE mdl, VALUE a0)
{
  rb_notimplement();
}

// UIImage* UIGraphicsGetImageFromCurrentImageContext(void);
static VALUE
osx_UIGraphicsGetImageFromCurrentImageContext(VALUE mdl)
{
  UIImage* ns_result = UIGraphicsGetImageFromCurrentImageContext();
  return nsresult_to_rbresult(_PRIV_C_PTR, &ns_result, "UIGraphicsGetImageFromCurrentImageContext", nil);
}

// void UIGraphicsEndImageContext(void);
static VALUE
osx_UIGraphicsEndImageContext(VALUE mdl)
{
  UIGraphicsEndImageContext();
  return Qnil;
}

void init_UIGraphics(VALUE mOSX)
{
  /**** functions ****/
  rb_define_module_function(mOSX, "UIGraphicsGetCurrentContext", osx_UIGraphicsGetCurrentContext, 0);
  rb_define_module_function(mOSX, "UIGraphicsPushContext", osx_UIGraphicsPushContext, 1);
  rb_define_module_function(mOSX, "UIGraphicsPopContext", osx_UIGraphicsPopContext, 0);
  rb_define_module_function(mOSX, "UIRectFillUsingBlendMode", osx_UIRectFillUsingBlendMode, 2);
  rb_define_module_function(mOSX, "UIRectFill", osx_UIRectFill, 1);
  rb_define_module_function(mOSX, "UIRectFrameUsingBlendMode", osx_UIRectFrameUsingBlendMode, 2);
  rb_define_module_function(mOSX, "UIRectFrame", osx_UIRectFrame, 1);
  rb_define_module_function(mOSX, "UIRectClip", osx_UIRectClip, 1);
  rb_define_module_function(mOSX, "UIGraphicsBeginImageContext", osx_UIGraphicsBeginImageContext, 1);
  rb_define_module_function(mOSX, "UIGraphicsGetImageFromCurrentImageContext", osx_UIGraphicsGetImageFromCurrentImageContext, 0);
  rb_define_module_function(mOSX, "UIGraphicsEndImageContext", osx_UIGraphicsEndImageContext, 0);
}
  /**** functions ****/
// NSData *UIImagePNGRepresentation(UIImage *image);
static VALUE
osx_UIImagePNGRepresentation(VALUE mdl, VALUE a0)
{
  NSData * ns_result;

  UIImage * ns_a0;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _PRIV_C_PTR, &ns_a0, "UIImagePNGRepresentation", pool, 0);

NS_DURING
  ns_result = UIImagePNGRepresentation(ns_a0);
NS_HANDLER
  excp = oc_err_new ("UIImagePNGRepresentation", localException);
NS_ENDHANDLER
  if (excp != Qnil) {
    [pool release];
    rb_exc_raise (excp);
    return Qnil;
  }

  rb_result = nsresult_to_rbresult(_C_ID, &ns_result, "UIImagePNGRepresentation", pool);
  [pool release];
  return rb_result;
}

// NSData *UIImageJPEGRepresentation(UIImage *image, CGFloat compressionQuality);
static VALUE
osx_UIImageJPEGRepresentation(VALUE mdl, VALUE a0, VALUE a1)
{
  rb_notimplement();
}

void init_UIImage(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UIImageOrientationUp", INT2NUM(UIImageOrientationUp));
  rb_define_const(mOSX, "UIImageOrientationDown", INT2NUM(UIImageOrientationDown));
  rb_define_const(mOSX, "UIImageOrientationLeft", INT2NUM(UIImageOrientationLeft));
  rb_define_const(mOSX, "UIImageOrientationRight", INT2NUM(UIImageOrientationRight));
  rb_define_const(mOSX, "UIImageOrientationUpMirrored", INT2NUM(UIImageOrientationUpMirrored));
  rb_define_const(mOSX, "UIImageOrientationDownMirrored", INT2NUM(UIImageOrientationDownMirrored));
  rb_define_const(mOSX, "UIImageOrientationLeftMirrored", INT2NUM(UIImageOrientationLeftMirrored));
  rb_define_const(mOSX, "UIImageOrientationRightMirrored", INT2NUM(UIImageOrientationRightMirrored));

  /**** functions ****/
  rb_define_module_function(mOSX, "UIImagePNGRepresentation", osx_UIImagePNGRepresentation, 1);
  rb_define_module_function(mOSX, "UIImageJPEGRepresentation", osx_UIImageJPEGRepresentation, 2);
}
  /**** constants ****/
// NSString *const UIImagePickerControllerOriginalImage;
static VALUE
osx_UIImagePickerControllerOriginalImage(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIImagePickerControllerOriginalImage, "UIImagePickerControllerOriginalImage", nil);
}

// NSString *const UIImagePickerControllerCropRect;
static VALUE
osx_UIImagePickerControllerCropRect(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIImagePickerControllerCropRect, "UIImagePickerControllerCropRect", nil);
}

  /**** functions ****/
// void UIImageWriteToSavedPhotosAlbum(UIImage *image, id completionTarget, SEL completionSelector, void *contextInfo);
static VALUE
osx_UIImageWriteToSavedPhotosAlbum(VALUE mdl, VALUE a0, VALUE a1, VALUE a2, VALUE a3)
{

  UIImage * ns_a0;
  id ns_a1;
  SEL ns_a2;
  void * ns_a3;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _PRIV_C_PTR, &ns_a0, "UIImageWriteToSavedPhotosAlbum", pool, 0);
  /* a1 */
  rbarg_to_nsarg(a1, _C_ID, &ns_a1, "UIImageWriteToSavedPhotosAlbum", pool, 1);
  /* a2 */
  rbarg_to_nsarg(a2, _C_SEL, &ns_a2, "UIImageWriteToSavedPhotosAlbum", pool, 2);
  /* a3 */
  rbarg_to_nsarg(a3, _PRIV_C_PTR, &ns_a3, "UIImageWriteToSavedPhotosAlbum", pool, 3);

NS_DURING
  UIImageWriteToSavedPhotosAlbum(ns_a0, ns_a1, ns_a2, ns_a3);
NS_HANDLER
  excp = oc_err_new ("UIImageWriteToSavedPhotosAlbum", localException);
NS_ENDHANDLER
  if (excp != Qnil) {
    [pool release];
    rb_exc_raise (excp);
    return Qnil;
  }

  rb_result = Qnil;
  [pool release];
  return rb_result;
}

void init_UIImagePickerController(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UIImagePickerControllerSourceTypePhotoLibrary", INT2NUM(UIImagePickerControllerSourceTypePhotoLibrary));
  rb_define_const(mOSX, "UIImagePickerControllerSourceTypeCamera", INT2NUM(UIImagePickerControllerSourceTypeCamera));
  rb_define_const(mOSX, "UIImagePickerControllerSourceTypeSavedPhotosAlbum", INT2NUM(UIImagePickerControllerSourceTypeSavedPhotosAlbum));

  /**** constants ****/
  rb_define_module_function(mOSX, "UIImagePickerControllerOriginalImage", osx_UIImagePickerControllerOriginalImage, 0);
  rb_define_module_function(mOSX, "UIImagePickerControllerCropRect", osx_UIImagePickerControllerCropRect, 0);
  /**** functions ****/
  rb_define_module_function(mOSX, "UIImageWriteToSavedPhotosAlbum", osx_UIImageWriteToSavedPhotosAlbum, 4);
}
void init_UIInterface(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UIBarStyleDefault", INT2NUM(UIBarStyleDefault));
  rb_define_const(mOSX, "UIBarStyleBlackOpaque", INT2NUM(UIBarStyleBlackOpaque));
  rb_define_const(mOSX, "UIBarStyleBlackTranslucent", INT2NUM(UIBarStyleBlackTranslucent));

}
  /**** constants ****/
// const CGFloat UINavigationControllerHideShowBarDuration;
static VALUE
osx_UINavigationControllerHideShowBarDuration(VALUE mdl)
{
  rb_notimplement();
}

void init_UINavigationController(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "UINavigationControllerHideShowBarDuration", osx_UINavigationControllerHideShowBarDuration, 0);
}
  /**** constants ****/
// NSString * const UINibProxiedObjectsKey;
static VALUE
osx_UINibProxiedObjectsKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UINibProxiedObjectsKey, "UINibProxiedObjectsKey", nil);
}

void init_UINibLoading(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "UINibProxiedObjectsKey", osx_UINibProxiedObjectsKey, 0);
}
void init_UIProgressView(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UIProgressViewStyleDefault", INT2NUM(UIProgressViewStyleDefault));
  rb_define_const(mOSX, "UIProgressViewStyleBar", INT2NUM(UIProgressViewStyleBar));

}
void init_UIScrollView(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UIScrollViewIndicatorStyleDefault", INT2NUM(UIScrollViewIndicatorStyleDefault));
  rb_define_const(mOSX, "UIScrollViewIndicatorStyleBlack", INT2NUM(UIScrollViewIndicatorStyleBlack));
  rb_define_const(mOSX, "UIScrollViewIndicatorStyleWhite", INT2NUM(UIScrollViewIndicatorStyleWhite));

}
void init_UISegmentedControl(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UISegmentedControlStylePlain", INT2NUM(UISegmentedControlStylePlain));
  rb_define_const(mOSX, "UISegmentedControlStyleBordered", INT2NUM(UISegmentedControlStyleBordered));
  rb_define_const(mOSX, "UISegmentedControlStyleBar", INT2NUM(UISegmentedControlStyleBar));
  rb_define_const(mOSX, "UISegmentedControlNoSegment", INT2NUM(UISegmentedControlNoSegment));

}
void init_UIStringDrawing(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UILineBreakModeWordWrap", INT2NUM(UILineBreakModeWordWrap));
  rb_define_const(mOSX, "UILineBreakModeCharacterWrap", INT2NUM(UILineBreakModeCharacterWrap));
  rb_define_const(mOSX, "UILineBreakModeClip", INT2NUM(UILineBreakModeClip));
  rb_define_const(mOSX, "UILineBreakModeHeadTruncation", INT2NUM(UILineBreakModeHeadTruncation));
  rb_define_const(mOSX, "UILineBreakModeTailTruncation", INT2NUM(UILineBreakModeTailTruncation));
  rb_define_const(mOSX, "UILineBreakModeMiddleTruncation", INT2NUM(UILineBreakModeMiddleTruncation));
  rb_define_const(mOSX, "UITextAlignmentLeft", INT2NUM(UITextAlignmentLeft));
  rb_define_const(mOSX, "UITextAlignmentCenter", INT2NUM(UITextAlignmentCenter));
  rb_define_const(mOSX, "UITextAlignmentRight", INT2NUM(UITextAlignmentRight));
  rb_define_const(mOSX, "UIBaselineAdjustmentAlignBaselines", INT2NUM(UIBaselineAdjustmentAlignBaselines));
  rb_define_const(mOSX, "UIBaselineAdjustmentAlignCenters", INT2NUM(UIBaselineAdjustmentAlignCenters));
  rb_define_const(mOSX, "UIBaselineAdjustmentNone", INT2NUM(UIBaselineAdjustmentNone));

}
void init_UITabBarItem(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UITabBarSystemItemMore", INT2NUM(UITabBarSystemItemMore));
  rb_define_const(mOSX, "UITabBarSystemItemFavorites", INT2NUM(UITabBarSystemItemFavorites));
  rb_define_const(mOSX, "UITabBarSystemItemFeatured", INT2NUM(UITabBarSystemItemFeatured));
  rb_define_const(mOSX, "UITabBarSystemItemTopRated", INT2NUM(UITabBarSystemItemTopRated));
  rb_define_const(mOSX, "UITabBarSystemItemRecents", INT2NUM(UITabBarSystemItemRecents));
  rb_define_const(mOSX, "UITabBarSystemItemContacts", INT2NUM(UITabBarSystemItemContacts));
  rb_define_const(mOSX, "UITabBarSystemItemHistory", INT2NUM(UITabBarSystemItemHistory));
  rb_define_const(mOSX, "UITabBarSystemItemBookmarks", INT2NUM(UITabBarSystemItemBookmarks));
  rb_define_const(mOSX, "UITabBarSystemItemSearch", INT2NUM(UITabBarSystemItemSearch));
  rb_define_const(mOSX, "UITabBarSystemItemDownloads", INT2NUM(UITabBarSystemItemDownloads));
  rb_define_const(mOSX, "UITabBarSystemItemMostRecent", INT2NUM(UITabBarSystemItemMostRecent));
  rb_define_const(mOSX, "UITabBarSystemItemMostViewed", INT2NUM(UITabBarSystemItemMostViewed));

}
  /**** constants ****/
// NSString *const UITableViewSelectionDidChangeNotification;
static VALUE
osx_UITableViewSelectionDidChangeNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UITableViewSelectionDidChangeNotification, "UITableViewSelectionDidChangeNotification", nil);
}

void init_UITableView(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UITableViewStylePlain", INT2NUM(UITableViewStylePlain));
  rb_define_const(mOSX, "UITableViewStyleGrouped", INT2NUM(UITableViewStyleGrouped));
  rb_define_const(mOSX, "UITableViewScrollPositionNone", INT2NUM(UITableViewScrollPositionNone));
  rb_define_const(mOSX, "UITableViewScrollPositionTop", INT2NUM(UITableViewScrollPositionTop));
  rb_define_const(mOSX, "UITableViewScrollPositionMiddle", INT2NUM(UITableViewScrollPositionMiddle));
  rb_define_const(mOSX, "UITableViewScrollPositionBottom", INT2NUM(UITableViewScrollPositionBottom));
  rb_define_const(mOSX, "UITableViewRowAnimationFade", INT2NUM(UITableViewRowAnimationFade));
  rb_define_const(mOSX, "UITableViewRowAnimationRight", INT2NUM(UITableViewRowAnimationRight));
  rb_define_const(mOSX, "UITableViewRowAnimationLeft", INT2NUM(UITableViewRowAnimationLeft));
  rb_define_const(mOSX, "UITableViewRowAnimationTop", INT2NUM(UITableViewRowAnimationTop));
  rb_define_const(mOSX, "UITableViewRowAnimationBottom", INT2NUM(UITableViewRowAnimationBottom));

  /**** constants ****/
  rb_define_module_function(mOSX, "UITableViewSelectionDidChangeNotification", osx_UITableViewSelectionDidChangeNotification, 0);
}
void init_UITableViewCell(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UITableViewCellSeparatorStyleNone", INT2NUM(UITableViewCellSeparatorStyleNone));
  rb_define_const(mOSX, "UITableViewCellSeparatorStyleSingleLine", INT2NUM(UITableViewCellSeparatorStyleSingleLine));
  rb_define_const(mOSX, "UITableViewCellSelectionStyleNone", INT2NUM(UITableViewCellSelectionStyleNone));
  rb_define_const(mOSX, "UITableViewCellSelectionStyleBlue", INT2NUM(UITableViewCellSelectionStyleBlue));
  rb_define_const(mOSX, "UITableViewCellSelectionStyleGray", INT2NUM(UITableViewCellSelectionStyleGray));
  rb_define_const(mOSX, "UITableViewCellEditingStyleNone", INT2NUM(UITableViewCellEditingStyleNone));
  rb_define_const(mOSX, "UITableViewCellEditingStyleDelete", INT2NUM(UITableViewCellEditingStyleDelete));
  rb_define_const(mOSX, "UITableViewCellEditingStyleInsert", INT2NUM(UITableViewCellEditingStyleInsert));
  rb_define_const(mOSX, "UITableViewCellAccessoryNone", INT2NUM(UITableViewCellAccessoryNone));
  rb_define_const(mOSX, "UITableViewCellAccessoryDisclosureIndicator", INT2NUM(UITableViewCellAccessoryDisclosureIndicator));
  rb_define_const(mOSX, "UITableViewCellAccessoryDetailDisclosureButton", INT2NUM(UITableViewCellAccessoryDetailDisclosureButton));
  rb_define_const(mOSX, "UITableViewCellAccessoryCheckmark", INT2NUM(UITableViewCellAccessoryCheckmark));

}
  /**** constants ****/
// NSString *const UITextFieldTextDidBeginEditingNotification;
static VALUE
osx_UITextFieldTextDidBeginEditingNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UITextFieldTextDidBeginEditingNotification, "UITextFieldTextDidBeginEditingNotification", nil);
}

// NSString *const UITextFieldTextDidEndEditingNotification;
static VALUE
osx_UITextFieldTextDidEndEditingNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UITextFieldTextDidEndEditingNotification, "UITextFieldTextDidEndEditingNotification", nil);
}

// NSString *const UITextFieldTextDidChangeNotification;
static VALUE
osx_UITextFieldTextDidChangeNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UITextFieldTextDidChangeNotification, "UITextFieldTextDidChangeNotification", nil);
}

void init_UITextField(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UITextBorderStyleNone", INT2NUM(UITextBorderStyleNone));
  rb_define_const(mOSX, "UITextBorderStyleLine", INT2NUM(UITextBorderStyleLine));
  rb_define_const(mOSX, "UITextBorderStyleBezel", INT2NUM(UITextBorderStyleBezel));
  rb_define_const(mOSX, "UITextBorderStyleRoundedRect", INT2NUM(UITextBorderStyleRoundedRect));
  rb_define_const(mOSX, "UITextFieldViewModeNever", INT2NUM(UITextFieldViewModeNever));
  rb_define_const(mOSX, "UITextFieldViewModeWhileEditing", INT2NUM(UITextFieldViewModeWhileEditing));
  rb_define_const(mOSX, "UITextFieldViewModeUnlessEditing", INT2NUM(UITextFieldViewModeUnlessEditing));
  rb_define_const(mOSX, "UITextFieldViewModeAlways", INT2NUM(UITextFieldViewModeAlways));

  /**** constants ****/
  rb_define_module_function(mOSX, "UITextFieldTextDidBeginEditingNotification", osx_UITextFieldTextDidBeginEditingNotification, 0);
  rb_define_module_function(mOSX, "UITextFieldTextDidEndEditingNotification", osx_UITextFieldTextDidEndEditingNotification, 0);
  rb_define_module_function(mOSX, "UITextFieldTextDidChangeNotification", osx_UITextFieldTextDidChangeNotification, 0);
}
void init_UITextInputTraits(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UITextAutocapitalizationTypeNone", INT2NUM(UITextAutocapitalizationTypeNone));
  rb_define_const(mOSX, "UITextAutocapitalizationTypeWords", INT2NUM(UITextAutocapitalizationTypeWords));
  rb_define_const(mOSX, "UITextAutocapitalizationTypeSentences", INT2NUM(UITextAutocapitalizationTypeSentences));
  rb_define_const(mOSX, "UITextAutocapitalizationTypeAllCharacters", INT2NUM(UITextAutocapitalizationTypeAllCharacters));
  rb_define_const(mOSX, "UITextAutocorrectionTypeDefault", INT2NUM(UITextAutocorrectionTypeDefault));
  rb_define_const(mOSX, "UITextAutocorrectionTypeNo", INT2NUM(UITextAutocorrectionTypeNo));
  rb_define_const(mOSX, "UITextAutocorrectionTypeYes", INT2NUM(UITextAutocorrectionTypeYes));
  rb_define_const(mOSX, "UIKeyboardTypeDefault", INT2NUM(UIKeyboardTypeDefault));
  rb_define_const(mOSX, "UIKeyboardTypeASCIICapable", INT2NUM(UIKeyboardTypeASCIICapable));
  rb_define_const(mOSX, "UIKeyboardTypeNumbersAndPunctuation", INT2NUM(UIKeyboardTypeNumbersAndPunctuation));
  rb_define_const(mOSX, "UIKeyboardTypeURL", INT2NUM(UIKeyboardTypeURL));
  rb_define_const(mOSX, "UIKeyboardTypeNumberPad", INT2NUM(UIKeyboardTypeNumberPad));
  rb_define_const(mOSX, "UIKeyboardTypePhonePad", INT2NUM(UIKeyboardTypePhonePad));
  rb_define_const(mOSX, "UIKeyboardTypeNamePhonePad", INT2NUM(UIKeyboardTypeNamePhonePad));
  rb_define_const(mOSX, "UIKeyboardTypeEmailAddress", INT2NUM(UIKeyboardTypeEmailAddress));
  rb_define_const(mOSX, "UIKeyboardTypeAlphabet", INT2NUM(UIKeyboardTypeAlphabet));
  rb_define_const(mOSX, "UIKeyboardAppearanceDefault", INT2NUM(UIKeyboardAppearanceDefault));
  rb_define_const(mOSX, "UIKeyboardAppearanceAlert", INT2NUM(UIKeyboardAppearanceAlert));
  rb_define_const(mOSX, "UIReturnKeyDefault", INT2NUM(UIReturnKeyDefault));
  rb_define_const(mOSX, "UIReturnKeyGo", INT2NUM(UIReturnKeyGo));
  rb_define_const(mOSX, "UIReturnKeyGoogle", INT2NUM(UIReturnKeyGoogle));
  rb_define_const(mOSX, "UIReturnKeyJoin", INT2NUM(UIReturnKeyJoin));
  rb_define_const(mOSX, "UIReturnKeyNext", INT2NUM(UIReturnKeyNext));
  rb_define_const(mOSX, "UIReturnKeyRoute", INT2NUM(UIReturnKeyRoute));
  rb_define_const(mOSX, "UIReturnKeySearch", INT2NUM(UIReturnKeySearch));
  rb_define_const(mOSX, "UIReturnKeySend", INT2NUM(UIReturnKeySend));
  rb_define_const(mOSX, "UIReturnKeyYahoo", INT2NUM(UIReturnKeyYahoo));
  rb_define_const(mOSX, "UIReturnKeyDone", INT2NUM(UIReturnKeyDone));
  rb_define_const(mOSX, "UIReturnKeyEmergencyCall", INT2NUM(UIReturnKeyEmergencyCall));

}
  /**** constants ****/
// NSString * const UITextViewTextDidBeginEditingNotification;
static VALUE
osx_UITextViewTextDidBeginEditingNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UITextViewTextDidBeginEditingNotification, "UITextViewTextDidBeginEditingNotification", nil);
}

// NSString * const UITextViewTextDidChangeNotification;
static VALUE
osx_UITextViewTextDidChangeNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UITextViewTextDidChangeNotification, "UITextViewTextDidChangeNotification", nil);
}

// NSString * const UITextViewTextDidEndEditingNotification;
static VALUE
osx_UITextViewTextDidEndEditingNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UITextViewTextDidEndEditingNotification, "UITextViewTextDidEndEditingNotification", nil);
}

void init_UITextView(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "UITextViewTextDidBeginEditingNotification", osx_UITextViewTextDidBeginEditingNotification, 0);
  rb_define_module_function(mOSX, "UITextViewTextDidChangeNotification", osx_UITextViewTextDidChangeNotification, 0);
  rb_define_module_function(mOSX, "UITextViewTextDidEndEditingNotification", osx_UITextViewTextDidEndEditingNotification, 0);
}
void init_UITouch(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UITouchPhaseBegan", INT2NUM(UITouchPhaseBegan));
  rb_define_const(mOSX, "UITouchPhaseMoved", INT2NUM(UITouchPhaseMoved));
  rb_define_const(mOSX, "UITouchPhaseStationary", INT2NUM(UITouchPhaseStationary));
  rb_define_const(mOSX, "UITouchPhaseEnded", INT2NUM(UITouchPhaseEnded));
  rb_define_const(mOSX, "UITouchPhaseCancelled", INT2NUM(UITouchPhaseCancelled));

}
void init_UIView(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UIViewAnimationCurveEaseInOut", INT2NUM(UIViewAnimationCurveEaseInOut));
  rb_define_const(mOSX, "UIViewAnimationCurveEaseIn", INT2NUM(UIViewAnimationCurveEaseIn));
  rb_define_const(mOSX, "UIViewAnimationCurveEaseOut", INT2NUM(UIViewAnimationCurveEaseOut));
  rb_define_const(mOSX, "UIViewAnimationCurveLinear", INT2NUM(UIViewAnimationCurveLinear));
  rb_define_const(mOSX, "UIViewContentModeScaleToFill", INT2NUM(UIViewContentModeScaleToFill));
  rb_define_const(mOSX, "UIViewContentModeScaleAspectFit", INT2NUM(UIViewContentModeScaleAspectFit));
  rb_define_const(mOSX, "UIViewContentModeScaleAspectFill", INT2NUM(UIViewContentModeScaleAspectFill));
  rb_define_const(mOSX, "UIViewContentModeRedraw", INT2NUM(UIViewContentModeRedraw));
  rb_define_const(mOSX, "UIViewContentModeCenter", INT2NUM(UIViewContentModeCenter));
  rb_define_const(mOSX, "UIViewContentModeTop", INT2NUM(UIViewContentModeTop));
  rb_define_const(mOSX, "UIViewContentModeBottom", INT2NUM(UIViewContentModeBottom));
  rb_define_const(mOSX, "UIViewContentModeLeft", INT2NUM(UIViewContentModeLeft));
  rb_define_const(mOSX, "UIViewContentModeRight", INT2NUM(UIViewContentModeRight));
  rb_define_const(mOSX, "UIViewContentModeTopLeft", INT2NUM(UIViewContentModeTopLeft));
  rb_define_const(mOSX, "UIViewContentModeTopRight", INT2NUM(UIViewContentModeTopRight));
  rb_define_const(mOSX, "UIViewContentModeBottomLeft", INT2NUM(UIViewContentModeBottomLeft));
  rb_define_const(mOSX, "UIViewContentModeBottomRight", INT2NUM(UIViewContentModeBottomRight));
  rb_define_const(mOSX, "UIViewAnimationTransitionNone", INT2NUM(UIViewAnimationTransitionNone));
  rb_define_const(mOSX, "UIViewAnimationTransitionFlipFromLeft", INT2NUM(UIViewAnimationTransitionFlipFromLeft));
  rb_define_const(mOSX, "UIViewAnimationTransitionFlipFromRight", INT2NUM(UIViewAnimationTransitionFlipFromRight));
  rb_define_const(mOSX, "UIViewAnimationTransitionCurlUp", INT2NUM(UIViewAnimationTransitionCurlUp));
  rb_define_const(mOSX, "UIViewAnimationTransitionCurlDown", INT2NUM(UIViewAnimationTransitionCurlDown));
  rb_define_const(mOSX, "UIViewAutoresizingNone", INT2NUM(UIViewAutoresizingNone));
  rb_define_const(mOSX, "UIViewAutoresizingFlexibleLeftMargin", INT2NUM(UIViewAutoresizingFlexibleLeftMargin));
  rb_define_const(mOSX, "UIViewAutoresizingFlexibleWidth", INT2NUM(UIViewAutoresizingFlexibleWidth));
  rb_define_const(mOSX, "UIViewAutoresizingFlexibleRightMargin", INT2NUM(UIViewAutoresizingFlexibleRightMargin));
  rb_define_const(mOSX, "UIViewAutoresizingFlexibleTopMargin", INT2NUM(UIViewAutoresizingFlexibleTopMargin));
  rb_define_const(mOSX, "UIViewAutoresizingFlexibleHeight", INT2NUM(UIViewAutoresizingFlexibleHeight));
  rb_define_const(mOSX, "UIViewAutoresizingFlexibleBottomMargin", INT2NUM(UIViewAutoresizingFlexibleBottomMargin));

}
void init_UIWebView(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "UIWebViewNavigationTypeLinkClicked", INT2NUM(UIWebViewNavigationTypeLinkClicked));
  rb_define_const(mOSX, "UIWebViewNavigationTypeFormSubmitted", INT2NUM(UIWebViewNavigationTypeFormSubmitted));
  rb_define_const(mOSX, "UIWebViewNavigationTypeBackForward", INT2NUM(UIWebViewNavigationTypeBackForward));
  rb_define_const(mOSX, "UIWebViewNavigationTypeReload", INT2NUM(UIWebViewNavigationTypeReload));
  rb_define_const(mOSX, "UIWebViewNavigationTypeFormResubmitted", INT2NUM(UIWebViewNavigationTypeFormResubmitted));
  rb_define_const(mOSX, "UIWebViewNavigationTypeOther", INT2NUM(UIWebViewNavigationTypeOther));

}
  /**** constants ****/
// const UIWindowLevel UIWindowLevelNormal;
static VALUE
osx_UIWindowLevelNormal(VALUE mdl)
{
  rb_notimplement();
}

// const UIWindowLevel UIWindowLevelAlert;
static VALUE
osx_UIWindowLevelAlert(VALUE mdl)
{
  rb_notimplement();
}

// const UIWindowLevel UIWindowLevelStatusBar;
static VALUE
osx_UIWindowLevelStatusBar(VALUE mdl)
{
  rb_notimplement();
}

// NSString *const UIWindowDidBecomeVisibleNotification;
static VALUE
osx_UIWindowDidBecomeVisibleNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIWindowDidBecomeVisibleNotification, "UIWindowDidBecomeVisibleNotification", nil);
}

// NSString *const UIWindowDidBecomeHiddenNotification;
static VALUE
osx_UIWindowDidBecomeHiddenNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIWindowDidBecomeHiddenNotification, "UIWindowDidBecomeHiddenNotification", nil);
}

// NSString *const UIWindowDidBecomeKeyNotification;
static VALUE
osx_UIWindowDidBecomeKeyNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIWindowDidBecomeKeyNotification, "UIWindowDidBecomeKeyNotification", nil);
}

// NSString *const UIWindowDidResignKeyNotification;
static VALUE
osx_UIWindowDidResignKeyNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIWindowDidResignKeyNotification, "UIWindowDidResignKeyNotification", nil);
}

// NSString *const UIKeyboardWillShowNotification;
static VALUE
osx_UIKeyboardWillShowNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIKeyboardWillShowNotification, "UIKeyboardWillShowNotification", nil);
}

// NSString *const UIKeyboardDidShowNotification;
static VALUE
osx_UIKeyboardDidShowNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIKeyboardDidShowNotification, "UIKeyboardDidShowNotification", nil);
}

// NSString *const UIKeyboardWillHideNotification;
static VALUE
osx_UIKeyboardWillHideNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIKeyboardWillHideNotification, "UIKeyboardWillHideNotification", nil);
}

// NSString *const UIKeyboardDidHideNotification;
static VALUE
osx_UIKeyboardDidHideNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIKeyboardDidHideNotification, "UIKeyboardDidHideNotification", nil);
}

// NSString *const UIKeyboardCenterBeginUserInfoKey;
static VALUE
osx_UIKeyboardCenterBeginUserInfoKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIKeyboardCenterBeginUserInfoKey, "UIKeyboardCenterBeginUserInfoKey", nil);
}

// NSString *const UIKeyboardCenterEndUserInfoKey;
static VALUE
osx_UIKeyboardCenterEndUserInfoKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIKeyboardCenterEndUserInfoKey, "UIKeyboardCenterEndUserInfoKey", nil);
}

// NSString *const UIKeyboardBoundsUserInfoKey;
static VALUE
osx_UIKeyboardBoundsUserInfoKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &UIKeyboardBoundsUserInfoKey, "UIKeyboardBoundsUserInfoKey", nil);
}

void init_UIWindow(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "UIWindowLevelNormal", osx_UIWindowLevelNormal, 0);
  rb_define_module_function(mOSX, "UIWindowLevelAlert", osx_UIWindowLevelAlert, 0);
  rb_define_module_function(mOSX, "UIWindowLevelStatusBar", osx_UIWindowLevelStatusBar, 0);
  rb_define_module_function(mOSX, "UIWindowDidBecomeVisibleNotification", osx_UIWindowDidBecomeVisibleNotification, 0);
  rb_define_module_function(mOSX, "UIWindowDidBecomeHiddenNotification", osx_UIWindowDidBecomeHiddenNotification, 0);
  rb_define_module_function(mOSX, "UIWindowDidBecomeKeyNotification", osx_UIWindowDidBecomeKeyNotification, 0);
  rb_define_module_function(mOSX, "UIWindowDidResignKeyNotification", osx_UIWindowDidResignKeyNotification, 0);
  rb_define_module_function(mOSX, "UIKeyboardWillShowNotification", osx_UIKeyboardWillShowNotification, 0);
  rb_define_module_function(mOSX, "UIKeyboardDidShowNotification", osx_UIKeyboardDidShowNotification, 0);
  rb_define_module_function(mOSX, "UIKeyboardWillHideNotification", osx_UIKeyboardWillHideNotification, 0);
  rb_define_module_function(mOSX, "UIKeyboardDidHideNotification", osx_UIKeyboardDidHideNotification, 0);
  rb_define_module_function(mOSX, "UIKeyboardCenterBeginUserInfoKey", osx_UIKeyboardCenterBeginUserInfoKey, 0);
  rb_define_module_function(mOSX, "UIKeyboardCenterEndUserInfoKey", osx_UIKeyboardCenterEndUserInfoKey, 0);
  rb_define_module_function(mOSX, "UIKeyboardBoundsUserInfoKey", osx_UIKeyboardBoundsUserInfoKey, 0);
}
void init_UIKit(VALUE mOSX)
{
  init_UIActivityIndicatorView(mOSX);
  init_UIAlert(mOSX);
  init_UIApplication(mOSX);
  init_UIBarButtonItem(mOSX);
  init_UIButton(mOSX);
  init_UIControl(mOSX);
  init_UIDatePicker(mOSX);
  init_UIDevice(mOSX);
  init_UIGeometry(mOSX);
  init_UIGraphics(mOSX);
  init_UIImage(mOSX);
  init_UIImagePickerController(mOSX);
  init_UIInterface(mOSX);
  init_UINavigationController(mOSX);
  init_UINibLoading(mOSX);
  init_UIProgressView(mOSX);
  init_UIScrollView(mOSX);
  init_UISegmentedControl(mOSX);
  init_UIStringDrawing(mOSX);
  init_UITabBarItem(mOSX);
  init_UITableView(mOSX);
  init_UITableViewCell(mOSX);
  init_UITextField(mOSX);
  init_UITextInputTraits(mOSX);
  init_UITextView(mOSX);
  init_UITouch(mOSX);
  init_UIView(mOSX);
  init_UIWebView(mOSX);
  init_UIWindow(mOSX);
}
