#import "osx_ruby.h"
#import "ocdata_conv.h"
#import <Foundation/Foundation.h>

extern VALUE oc_err_new (const char* fname, NSException* nsexcp);
extern void rbarg_to_nsarg(VALUE rbarg, int octype, void* nsarg, const char* fname, id pool, int index);
extern VALUE nsresult_to_rbresult(int octype, const void* nsresult, const char* fname, id pool);
static const int VA_MAX = 4;


  /**** constants ****/
// double NSFoundationVersionNumber;
static VALUE
osx_NSFoundationVersionNumber(VALUE mdl)
{
  return nsresult_to_rbresult(_C_DBL, &NSFoundationVersionNumber, "NSFoundationVersionNumber", nil);
}

  /**** functions ****/
// NSString *NSStringFromSelector(SEL aSelector);
static VALUE
osx_NSStringFromSelector(VALUE mdl, VALUE a0)
{
  NSString * ns_result;

  SEL ns_a0;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _C_SEL, &ns_a0, "NSStringFromSelector", pool, 0);

NS_DURING
  ns_result = NSStringFromSelector(ns_a0);
NS_HANDLER
  excp = oc_err_new ("NSStringFromSelector", localException);
NS_ENDHANDLER
  if (excp != Qnil) {
    [pool release];
    rb_exc_raise (excp);
    return Qnil;
  }

  rb_result = nsresult_to_rbresult(_C_ID, &ns_result, "NSStringFromSelector", pool);
  [pool release];
  return rb_result;
}

// SEL NSSelectorFromString(NSString *aSelectorName);
static VALUE
osx_NSSelectorFromString(VALUE mdl, VALUE a0)
{
  SEL ns_result;

  NSString * ns_a0;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _C_ID, &ns_a0, "NSSelectorFromString", pool, 0);

NS_DURING
  ns_result = NSSelectorFromString(ns_a0);
NS_HANDLER
  excp = oc_err_new ("NSSelectorFromString", localException);
NS_ENDHANDLER
  if (excp != Qnil) {
    [pool release];
    rb_exc_raise (excp);
    return Qnil;
  }

  rb_result = nsresult_to_rbresult(_C_SEL, &ns_result, "NSSelectorFromString", pool);
  [pool release];
  return rb_result;
}

// NSString *NSStringFromClass(Class aClass);
static VALUE
osx_NSStringFromClass(VALUE mdl, VALUE a0)
{
  NSString * ns_result;

  Class ns_a0;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _C_ID, &ns_a0, "NSStringFromClass", pool, 0);

NS_DURING
  ns_result = NSStringFromClass(ns_a0);
NS_HANDLER
  excp = oc_err_new ("NSStringFromClass", localException);
NS_ENDHANDLER
  if (excp != Qnil) {
    [pool release];
    rb_exc_raise (excp);
    return Qnil;
  }

  rb_result = nsresult_to_rbresult(_C_ID, &ns_result, "NSStringFromClass", pool);
  [pool release];
  return rb_result;
}

// Class NSClassFromString(NSString *aClassName);
static VALUE
osx_NSClassFromString(VALUE mdl, VALUE a0)
{
  Class ns_result;

  NSString * ns_a0;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _C_ID, &ns_a0, "NSClassFromString", pool, 0);

NS_DURING
  ns_result = NSClassFromString(ns_a0);
NS_HANDLER
  excp = oc_err_new ("NSClassFromString", localException);
NS_ENDHANDLER
  if (excp != Qnil) {
    [pool release];
    rb_exc_raise (excp);
    return Qnil;
  }

  rb_result = nsresult_to_rbresult(_C_ID, &ns_result, "NSClassFromString", pool);
  [pool release];
  return rb_result;
}

// NSString *NSStringFromProtocol(Protocol *proto);
static VALUE
osx_NSStringFromProtocol(VALUE mdl, VALUE a0)
{
  NSString * ns_result;

  Protocol * ns_a0;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _PRIV_C_PTR, &ns_a0, "NSStringFromProtocol", pool, 0);

NS_DURING
  ns_result = NSStringFromProtocol(ns_a0);
NS_HANDLER
  excp = oc_err_new ("NSStringFromProtocol", localException);
NS_ENDHANDLER
  if (excp != Qnil) {
    [pool release];
    rb_exc_raise (excp);
    return Qnil;
  }

  rb_result = nsresult_to_rbresult(_C_ID, &ns_result, "NSStringFromProtocol", pool);
  [pool release];
  return rb_result;
}

// Protocol *NSProtocolFromString(NSString *namestr);
static VALUE
osx_NSProtocolFromString(VALUE mdl, VALUE a0)
{
  Protocol * ns_result;

  NSString * ns_a0;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _C_ID, &ns_a0, "NSProtocolFromString", pool, 0);

NS_DURING
  ns_result = NSProtocolFromString(ns_a0);
NS_HANDLER
  excp = oc_err_new ("NSProtocolFromString", localException);
NS_ENDHANDLER
  if (excp != Qnil) {
    [pool release];
    rb_exc_raise (excp);
    return Qnil;
  }

  rb_result = nsresult_to_rbresult(_PRIV_C_PTR, &ns_result, "NSProtocolFromString", pool);
  [pool release];
  return rb_result;
}

// const char *NSGetSizeAndAlignment(const char *typePtr, NSUInteger *sizep, NSUInteger *alignp);
static VALUE
osx_NSGetSizeAndAlignment(VALUE mdl, VALUE a0, VALUE a1, VALUE a2)
{
  const char * ns_result;

  const char * ns_a0;
  NSUInteger * ns_a1;
  NSUInteger * ns_a2;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _C_CHARPTR, &ns_a0, "NSGetSizeAndAlignment", pool, 0);
  /* a1 */
  rbarg_to_nsarg(a1, _PRIV_C_PTR, &ns_a1, "NSGetSizeAndAlignment", pool, 1);
  /* a2 */
  rbarg_to_nsarg(a2, _PRIV_C_PTR, &ns_a2, "NSGetSizeAndAlignment", pool, 2);

NS_DURING
  ns_result = NSGetSizeAndAlignment(ns_a0, ns_a1, ns_a2);
NS_HANDLER
  excp = oc_err_new ("NSGetSizeAndAlignment", localException);
NS_ENDHANDLER
  if (excp != Qnil) {
    [pool release];
    rb_exc_raise (excp);
    return Qnil;
  }

  rb_result = nsresult_to_rbresult(_C_CHARPTR, &ns_result, "NSGetSizeAndAlignment", pool);
  [pool release];
  return rb_result;
}

// void NSLogv(NSString *format, va_list args);
static VALUE
osx_NSLogv(VALUE mdl, VALUE a0, VALUE a1)
{
  rb_notimplement();
}

void init_NSObjCRuntime(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSOrderedAscending", INT2NUM(NSOrderedAscending));
  rb_define_const(mOSX, "NSOrderedSame", INT2NUM(NSOrderedSame));
  rb_define_const(mOSX, "NSOrderedDescending", INT2NUM(NSOrderedDescending));
  rb_define_const(mOSX, "NSNotFound", INT2NUM(NSNotFound));

  /**** constants ****/
  rb_define_module_function(mOSX, "NSFoundationVersionNumber", osx_NSFoundationVersionNumber, 0);
  /**** functions ****/
  rb_define_module_function(mOSX, "NSStringFromSelector", osx_NSStringFromSelector, 1);
  rb_define_module_function(mOSX, "NSSelectorFromString", osx_NSSelectorFromString, 1);
  rb_define_module_function(mOSX, "NSStringFromClass", osx_NSStringFromClass, 1);
  rb_define_module_function(mOSX, "NSClassFromString", osx_NSClassFromString, 1);
  rb_define_module_function(mOSX, "NSStringFromProtocol", osx_NSStringFromProtocol, 1);
  rb_define_module_function(mOSX, "NSProtocolFromString", osx_NSProtocolFromString, 1);
  rb_define_module_function(mOSX, "NSGetSizeAndAlignment", osx_NSGetSizeAndAlignment, 3);
  rb_define_module_function(mOSX, "NSLogv", osx_NSLogv, 2);
}
  /**** constants ****/
// NSString * const NSBundleDidLoadNotification;
static VALUE
osx_NSBundleDidLoadNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSBundleDidLoadNotification, "NSBundleDidLoadNotification", nil);
}

// NSString * const NSLoadedClasses;
static VALUE
osx_NSLoadedClasses(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSLoadedClasses, "NSLoadedClasses", nil);
}

void init_NSBundle(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSBundleExecutableArchitectureI386", INT2NUM(NSBundleExecutableArchitectureI386));
  rb_define_const(mOSX, "NSBundleExecutableArchitecturePPC", INT2NUM(NSBundleExecutableArchitecturePPC));
  rb_define_const(mOSX, "NSBundleExecutableArchitectureX86_64", INT2NUM(NSBundleExecutableArchitectureX86_64));
  rb_define_const(mOSX, "NSBundleExecutableArchitecturePPC64", INT2NUM(NSBundleExecutableArchitecturePPC64));

  /**** constants ****/
  rb_define_module_function(mOSX, "NSBundleDidLoadNotification", osx_NSBundleDidLoadNotification, 0);
  rb_define_module_function(mOSX, "NSLoadedClasses", osx_NSLoadedClasses, 0);
}
void init_NSByteOrder(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NS_UnknownByteOrder", INT2NUM(NS_UnknownByteOrder));
  rb_define_const(mOSX, "NS_LittleEndian", INT2NUM(NS_LittleEndian));
  rb_define_const(mOSX, "NS_BigEndian", INT2NUM(NS_BigEndian));

}
void init_NSCalendar(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSEraCalendarUnit", INT2NUM(NSEraCalendarUnit));
  rb_define_const(mOSX, "NSYearCalendarUnit", INT2NUM(NSYearCalendarUnit));
  rb_define_const(mOSX, "NSMonthCalendarUnit", INT2NUM(NSMonthCalendarUnit));
  rb_define_const(mOSX, "NSDayCalendarUnit", INT2NUM(NSDayCalendarUnit));
  rb_define_const(mOSX, "NSHourCalendarUnit", INT2NUM(NSHourCalendarUnit));
  rb_define_const(mOSX, "NSMinuteCalendarUnit", INT2NUM(NSMinuteCalendarUnit));
  rb_define_const(mOSX, "NSSecondCalendarUnit", INT2NUM(NSSecondCalendarUnit));
  rb_define_const(mOSX, "NSWeekCalendarUnit", INT2NUM(NSWeekCalendarUnit));
  rb_define_const(mOSX, "NSWeekdayCalendarUnit", INT2NUM(NSWeekdayCalendarUnit));
  rb_define_const(mOSX, "NSWeekdayOrdinalCalendarUnit", INT2NUM(NSWeekdayOrdinalCalendarUnit));
  rb_define_const(mOSX, "NSWrapCalendarComponents", INT2NUM(NSWrapCalendarComponents));
  rb_define_const(mOSX, "NSUndefinedDateComponent", INT2NUM(NSUndefinedDateComponent));

}
void init_NSCharacterSet(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSOpenStepUnicodeReservedBase", INT2NUM(NSOpenStepUnicodeReservedBase));

}
void init_NSData(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSMappedRead", INT2NUM(NSMappedRead));
  rb_define_const(mOSX, "NSUncachedRead", INT2NUM(NSUncachedRead));
  rb_define_const(mOSX, "NSAtomicWrite", INT2NUM(NSAtomicWrite));

}
void init_NSDateFormatter(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSDateFormatterNoStyle", INT2NUM(NSDateFormatterNoStyle));
  rb_define_const(mOSX, "NSDateFormatterShortStyle", INT2NUM(NSDateFormatterShortStyle));
  rb_define_const(mOSX, "NSDateFormatterMediumStyle", INT2NUM(NSDateFormatterMediumStyle));
  rb_define_const(mOSX, "NSDateFormatterLongStyle", INT2NUM(NSDateFormatterLongStyle));
  rb_define_const(mOSX, "NSDateFormatterFullStyle", INT2NUM(NSDateFormatterFullStyle));
  rb_define_const(mOSX, "NSDateFormatterBehaviorDefault", INT2NUM(NSDateFormatterBehaviorDefault));
  rb_define_const(mOSX, "NSDateFormatterBehavior10_0", INT2NUM(NSDateFormatterBehavior10_0));
  rb_define_const(mOSX, "NSDateFormatterBehavior10_4", INT2NUM(NSDateFormatterBehavior10_4));

}
  /**** functions ****/
// void NSDecimalCopy(NSDecimal *destination, const NSDecimal *source);
static VALUE
osx_NSDecimalCopy(VALUE mdl, VALUE a0, VALUE a1)
{

  NSDecimal * ns_a0;
  const NSDecimal * ns_a1;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _PRIV_C_PTR, &ns_a0, "NSDecimalCopy", pool, 0);
  /* a1 */
  rbarg_to_nsarg(a1, _PRIV_C_PTR, &ns_a1, "NSDecimalCopy", pool, 1);

NS_DURING
  NSDecimalCopy(ns_a0, ns_a1);
NS_HANDLER
  excp = oc_err_new ("NSDecimalCopy", localException);
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

// void NSDecimalCompact(NSDecimal *number);
static VALUE
osx_NSDecimalCompact(VALUE mdl, VALUE a0)
{

  NSDecimal * ns_a0;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _PRIV_C_PTR, &ns_a0, "NSDecimalCompact", pool, 0);

NS_DURING
  NSDecimalCompact(ns_a0);
NS_HANDLER
  excp = oc_err_new ("NSDecimalCompact", localException);
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

// NSComparisonResult NSDecimalCompare(const NSDecimal *leftOperand, const NSDecimal *rightOperand);
static VALUE
osx_NSDecimalCompare(VALUE mdl, VALUE a0, VALUE a1)
{
  NSComparisonResult ns_result;

  const NSDecimal * ns_a0;
  const NSDecimal * ns_a1;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _PRIV_C_PTR, &ns_a0, "NSDecimalCompare", pool, 0);
  /* a1 */
  rbarg_to_nsarg(a1, _PRIV_C_PTR, &ns_a1, "NSDecimalCompare", pool, 1);

NS_DURING
  ns_result = NSDecimalCompare(ns_a0, ns_a1);
NS_HANDLER
  excp = oc_err_new ("NSDecimalCompare", localException);
NS_ENDHANDLER
  if (excp != Qnil) {
    [pool release];
    rb_exc_raise (excp);
    return Qnil;
  }

  rb_result = nsresult_to_rbresult(_C_INT, &ns_result, "NSDecimalCompare", pool);
  [pool release];
  return rb_result;
}

// void NSDecimalRound(NSDecimal *result, const NSDecimal *number, NSInteger scale, NSRoundingMode roundingMode);
static VALUE
osx_NSDecimalRound(VALUE mdl, VALUE a0, VALUE a1, VALUE a2, VALUE a3)
{
  rb_notimplement();
}

// NSCalculationError NSDecimalNormalize(NSDecimal *number1, NSDecimal *number2, NSRoundingMode roundingMode);
static VALUE
osx_NSDecimalNormalize(VALUE mdl, VALUE a0, VALUE a1, VALUE a2)
{
  rb_notimplement();
}

// NSCalculationError NSDecimalAdd(NSDecimal *result, const NSDecimal *leftOperand, const NSDecimal *rightOperand, NSRoundingMode roundingMode);
static VALUE
osx_NSDecimalAdd(VALUE mdl, VALUE a0, VALUE a1, VALUE a2, VALUE a3)
{
  rb_notimplement();
}

// NSCalculationError NSDecimalSubtract(NSDecimal *result, const NSDecimal *leftOperand, const NSDecimal *rightOperand, NSRoundingMode roundingMode);
static VALUE
osx_NSDecimalSubtract(VALUE mdl, VALUE a0, VALUE a1, VALUE a2, VALUE a3)
{
  rb_notimplement();
}

// NSCalculationError NSDecimalMultiply(NSDecimal *result, const NSDecimal *leftOperand, const NSDecimal *rightOperand, NSRoundingMode roundingMode);
static VALUE
osx_NSDecimalMultiply(VALUE mdl, VALUE a0, VALUE a1, VALUE a2, VALUE a3)
{
  rb_notimplement();
}

// NSCalculationError NSDecimalDivide(NSDecimal *result, const NSDecimal *leftOperand, const NSDecimal *rightOperand, NSRoundingMode roundingMode);
static VALUE
osx_NSDecimalDivide(VALUE mdl, VALUE a0, VALUE a1, VALUE a2, VALUE a3)
{
  rb_notimplement();
}

// NSCalculationError NSDecimalPower(NSDecimal *result, const NSDecimal *number, NSUInteger power, NSRoundingMode roundingMode);
static VALUE
osx_NSDecimalPower(VALUE mdl, VALUE a0, VALUE a1, VALUE a2, VALUE a3)
{
  rb_notimplement();
}

// NSCalculationError NSDecimalMultiplyByPowerOf10(NSDecimal *result, const NSDecimal *number, short power, NSRoundingMode roundingMode);
static VALUE
osx_NSDecimalMultiplyByPowerOf10(VALUE mdl, VALUE a0, VALUE a1, VALUE a2, VALUE a3)
{
  rb_notimplement();
}

// NSString *NSDecimalString(const NSDecimal *dcm, id locale);
static VALUE
osx_NSDecimalString(VALUE mdl, VALUE a0, VALUE a1)
{
  NSString * ns_result;

  const NSDecimal * ns_a0;
  id ns_a1;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _PRIV_C_PTR, &ns_a0, "NSDecimalString", pool, 0);
  /* a1 */
  rbarg_to_nsarg(a1, _C_ID, &ns_a1, "NSDecimalString", pool, 1);

NS_DURING
  ns_result = NSDecimalString(ns_a0, ns_a1);
NS_HANDLER
  excp = oc_err_new ("NSDecimalString", localException);
NS_ENDHANDLER
  if (excp != Qnil) {
    [pool release];
    rb_exc_raise (excp);
    return Qnil;
  }

  rb_result = nsresult_to_rbresult(_C_ID, &ns_result, "NSDecimalString", pool);
  [pool release];
  return rb_result;
}

void init_NSDecimal(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSRoundPlain", INT2NUM(NSRoundPlain));
  rb_define_const(mOSX, "NSRoundDown", INT2NUM(NSRoundDown));
  rb_define_const(mOSX, "NSRoundUp", INT2NUM(NSRoundUp));
  rb_define_const(mOSX, "NSRoundBankers", INT2NUM(NSRoundBankers));
  rb_define_const(mOSX, "NSCalculationNoError", INT2NUM(NSCalculationNoError));
  rb_define_const(mOSX, "NSCalculationLossOfPrecision", INT2NUM(NSCalculationLossOfPrecision));
  rb_define_const(mOSX, "NSCalculationUnderflow", INT2NUM(NSCalculationUnderflow));
  rb_define_const(mOSX, "NSCalculationOverflow", INT2NUM(NSCalculationOverflow));
  rb_define_const(mOSX, "NSCalculationDivideByZero", INT2NUM(NSCalculationDivideByZero));

  /**** functions ****/
  rb_define_module_function(mOSX, "NSDecimalCopy", osx_NSDecimalCopy, 2);
  rb_define_module_function(mOSX, "NSDecimalCompact", osx_NSDecimalCompact, 1);
  rb_define_module_function(mOSX, "NSDecimalCompare", osx_NSDecimalCompare, 2);
  rb_define_module_function(mOSX, "NSDecimalRound", osx_NSDecimalRound, 4);
  rb_define_module_function(mOSX, "NSDecimalNormalize", osx_NSDecimalNormalize, 3);
  rb_define_module_function(mOSX, "NSDecimalAdd", osx_NSDecimalAdd, 4);
  rb_define_module_function(mOSX, "NSDecimalSubtract", osx_NSDecimalSubtract, 4);
  rb_define_module_function(mOSX, "NSDecimalMultiply", osx_NSDecimalMultiply, 4);
  rb_define_module_function(mOSX, "NSDecimalDivide", osx_NSDecimalDivide, 4);
  rb_define_module_function(mOSX, "NSDecimalPower", osx_NSDecimalPower, 4);
  rb_define_module_function(mOSX, "NSDecimalMultiplyByPowerOf10", osx_NSDecimalMultiplyByPowerOf10, 4);
  rb_define_module_function(mOSX, "NSDecimalString", osx_NSDecimalString, 2);
}
  /**** constants ****/
// NSString * const NSDecimalNumberExactnessException;
static VALUE
osx_NSDecimalNumberExactnessException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSDecimalNumberExactnessException, "NSDecimalNumberExactnessException", nil);
}

// NSString * const NSDecimalNumberOverflowException;
static VALUE
osx_NSDecimalNumberOverflowException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSDecimalNumberOverflowException, "NSDecimalNumberOverflowException", nil);
}

// NSString * const NSDecimalNumberUnderflowException;
static VALUE
osx_NSDecimalNumberUnderflowException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSDecimalNumberUnderflowException, "NSDecimalNumberUnderflowException", nil);
}

// NSString * const NSDecimalNumberDivideByZeroException;
static VALUE
osx_NSDecimalNumberDivideByZeroException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSDecimalNumberDivideByZeroException, "NSDecimalNumberDivideByZeroException", nil);
}

void init_NSDecimalNumber(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "NSDecimalNumberExactnessException", osx_NSDecimalNumberExactnessException, 0);
  rb_define_module_function(mOSX, "NSDecimalNumberOverflowException", osx_NSDecimalNumberOverflowException, 0);
  rb_define_module_function(mOSX, "NSDecimalNumberUnderflowException", osx_NSDecimalNumberUnderflowException, 0);
  rb_define_module_function(mOSX, "NSDecimalNumberDivideByZeroException", osx_NSDecimalNumberDivideByZeroException, 0);
}
  /**** constants ****/
// NSString *const NSCocoaErrorDomain;
static VALUE
osx_NSCocoaErrorDomain(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSCocoaErrorDomain, "NSCocoaErrorDomain", nil);
}

// NSString *const NSPOSIXErrorDomain;
static VALUE
osx_NSPOSIXErrorDomain(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSPOSIXErrorDomain, "NSPOSIXErrorDomain", nil);
}

// NSString *const NSOSStatusErrorDomain;
static VALUE
osx_NSOSStatusErrorDomain(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSOSStatusErrorDomain, "NSOSStatusErrorDomain", nil);
}

// NSString *const NSMachErrorDomain;
static VALUE
osx_NSMachErrorDomain(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSMachErrorDomain, "NSMachErrorDomain", nil);
}

// NSString *const NSUnderlyingErrorKey;
static VALUE
osx_NSUnderlyingErrorKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSUnderlyingErrorKey, "NSUnderlyingErrorKey", nil);
}

// NSString *const NSLocalizedDescriptionKey;
static VALUE
osx_NSLocalizedDescriptionKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSLocalizedDescriptionKey, "NSLocalizedDescriptionKey", nil);
}

// NSString *const NSLocalizedFailureReasonErrorKey;
static VALUE
osx_NSLocalizedFailureReasonErrorKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSLocalizedFailureReasonErrorKey, "NSLocalizedFailureReasonErrorKey", nil);
}

// NSString *const NSLocalizedRecoverySuggestionErrorKey;
static VALUE
osx_NSLocalizedRecoverySuggestionErrorKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSLocalizedRecoverySuggestionErrorKey, "NSLocalizedRecoverySuggestionErrorKey", nil);
}

// NSString *const NSLocalizedRecoveryOptionsErrorKey;
static VALUE
osx_NSLocalizedRecoveryOptionsErrorKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSLocalizedRecoveryOptionsErrorKey, "NSLocalizedRecoveryOptionsErrorKey", nil);
}

// NSString *const NSRecoveryAttempterErrorKey;
static VALUE
osx_NSRecoveryAttempterErrorKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSRecoveryAttempterErrorKey, "NSRecoveryAttempterErrorKey", nil);
}

// NSString *const NSStringEncodingErrorKey;
static VALUE
osx_NSStringEncodingErrorKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSStringEncodingErrorKey, "NSStringEncodingErrorKey", nil);
}

// NSString *const NSURLErrorKey;
static VALUE
osx_NSURLErrorKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSURLErrorKey, "NSURLErrorKey", nil);
}

// NSString *const NSFilePathErrorKey;
static VALUE
osx_NSFilePathErrorKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFilePathErrorKey, "NSFilePathErrorKey", nil);
}

void init_NSError(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "NSCocoaErrorDomain", osx_NSCocoaErrorDomain, 0);
  rb_define_module_function(mOSX, "NSPOSIXErrorDomain", osx_NSPOSIXErrorDomain, 0);
  rb_define_module_function(mOSX, "NSOSStatusErrorDomain", osx_NSOSStatusErrorDomain, 0);
  rb_define_module_function(mOSX, "NSMachErrorDomain", osx_NSMachErrorDomain, 0);
  rb_define_module_function(mOSX, "NSUnderlyingErrorKey", osx_NSUnderlyingErrorKey, 0);
  rb_define_module_function(mOSX, "NSLocalizedDescriptionKey", osx_NSLocalizedDescriptionKey, 0);
  rb_define_module_function(mOSX, "NSLocalizedFailureReasonErrorKey", osx_NSLocalizedFailureReasonErrorKey, 0);
  rb_define_module_function(mOSX, "NSLocalizedRecoverySuggestionErrorKey", osx_NSLocalizedRecoverySuggestionErrorKey, 0);
  rb_define_module_function(mOSX, "NSLocalizedRecoveryOptionsErrorKey", osx_NSLocalizedRecoveryOptionsErrorKey, 0);
  rb_define_module_function(mOSX, "NSRecoveryAttempterErrorKey", osx_NSRecoveryAttempterErrorKey, 0);
  rb_define_module_function(mOSX, "NSStringEncodingErrorKey", osx_NSStringEncodingErrorKey, 0);
  rb_define_module_function(mOSX, "NSURLErrorKey", osx_NSURLErrorKey, 0);
  rb_define_module_function(mOSX, "NSFilePathErrorKey", osx_NSFilePathErrorKey, 0);
}
  /**** constants ****/
// NSString * const NSGenericException;
static VALUE
osx_NSGenericException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSGenericException, "NSGenericException", nil);
}

// NSString * const NSRangeException;
static VALUE
osx_NSRangeException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSRangeException, "NSRangeException", nil);
}

// NSString * const NSInvalidArgumentException;
static VALUE
osx_NSInvalidArgumentException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSInvalidArgumentException, "NSInvalidArgumentException", nil);
}

// NSString * const NSInternalInconsistencyException;
static VALUE
osx_NSInternalInconsistencyException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSInternalInconsistencyException, "NSInternalInconsistencyException", nil);
}

// NSString * const NSMallocException;
static VALUE
osx_NSMallocException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSMallocException, "NSMallocException", nil);
}

// NSString * const NSObjectInaccessibleException;
static VALUE
osx_NSObjectInaccessibleException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSObjectInaccessibleException, "NSObjectInaccessibleException", nil);
}

// NSString * const NSObjectNotAvailableException;
static VALUE
osx_NSObjectNotAvailableException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSObjectNotAvailableException, "NSObjectNotAvailableException", nil);
}

// NSString * const NSDestinationInvalidException;
static VALUE
osx_NSDestinationInvalidException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSDestinationInvalidException, "NSDestinationInvalidException", nil);
}

// NSString * const NSPortTimeoutException;
static VALUE
osx_NSPortTimeoutException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSPortTimeoutException, "NSPortTimeoutException", nil);
}

// NSString * const NSInvalidSendPortException;
static VALUE
osx_NSInvalidSendPortException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSInvalidSendPortException, "NSInvalidSendPortException", nil);
}

// NSString * const NSInvalidReceivePortException;
static VALUE
osx_NSInvalidReceivePortException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSInvalidReceivePortException, "NSInvalidReceivePortException", nil);
}

// NSString * const NSPortSendException;
static VALUE
osx_NSPortSendException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSPortSendException, "NSPortSendException", nil);
}

// NSString * const NSPortReceiveException;
static VALUE
osx_NSPortReceiveException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSPortReceiveException, "NSPortReceiveException", nil);
}

// NSString * const NSOldStyleException;
static VALUE
osx_NSOldStyleException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSOldStyleException, "NSOldStyleException", nil);
}

  /**** functions ****/
// NSUncaughtExceptionHandler *NSGetUncaughtExceptionHandler(void);
static VALUE
osx_NSGetUncaughtExceptionHandler(VALUE mdl)
{
  NSUncaughtExceptionHandler * ns_result = NSGetUncaughtExceptionHandler();
  return nsresult_to_rbresult(_PRIV_C_PTR, &ns_result, "NSGetUncaughtExceptionHandler", nil);
}

// void NSSetUncaughtExceptionHandler(NSUncaughtExceptionHandler *);
static VALUE
osx_NSSetUncaughtExceptionHandler(VALUE mdl, VALUE a0)
{

  NSUncaughtExceptionHandler * ns_a0;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _PRIV_C_PTR, &ns_a0, "NSSetUncaughtExceptionHandler", pool, 0);

NS_DURING
  NSSetUncaughtExceptionHandler(ns_a0);
NS_HANDLER
  excp = oc_err_new ("NSSetUncaughtExceptionHandler", localException);
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

void init_NSException(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "NSGenericException", osx_NSGenericException, 0);
  rb_define_module_function(mOSX, "NSRangeException", osx_NSRangeException, 0);
  rb_define_module_function(mOSX, "NSInvalidArgumentException", osx_NSInvalidArgumentException, 0);
  rb_define_module_function(mOSX, "NSInternalInconsistencyException", osx_NSInternalInconsistencyException, 0);
  rb_define_module_function(mOSX, "NSMallocException", osx_NSMallocException, 0);
  rb_define_module_function(mOSX, "NSObjectInaccessibleException", osx_NSObjectInaccessibleException, 0);
  rb_define_module_function(mOSX, "NSObjectNotAvailableException", osx_NSObjectNotAvailableException, 0);
  rb_define_module_function(mOSX, "NSDestinationInvalidException", osx_NSDestinationInvalidException, 0);
  rb_define_module_function(mOSX, "NSPortTimeoutException", osx_NSPortTimeoutException, 0);
  rb_define_module_function(mOSX, "NSInvalidSendPortException", osx_NSInvalidSendPortException, 0);
  rb_define_module_function(mOSX, "NSInvalidReceivePortException", osx_NSInvalidReceivePortException, 0);
  rb_define_module_function(mOSX, "NSPortSendException", osx_NSPortSendException, 0);
  rb_define_module_function(mOSX, "NSPortReceiveException", osx_NSPortReceiveException, 0);
  rb_define_module_function(mOSX, "NSOldStyleException", osx_NSOldStyleException, 0);
  /**** functions ****/
  rb_define_module_function(mOSX, "NSGetUncaughtExceptionHandler", osx_NSGetUncaughtExceptionHandler, 0);
  rb_define_module_function(mOSX, "NSSetUncaughtExceptionHandler", osx_NSSetUncaughtExceptionHandler, 1);
}
  /**** constants ****/
// NSString * const NSFileHandleOperationException;
static VALUE
osx_NSFileHandleOperationException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileHandleOperationException, "NSFileHandleOperationException", nil);
}

// NSString * const NSFileHandleReadCompletionNotification;
static VALUE
osx_NSFileHandleReadCompletionNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileHandleReadCompletionNotification, "NSFileHandleReadCompletionNotification", nil);
}

// NSString * const NSFileHandleReadToEndOfFileCompletionNotification;
static VALUE
osx_NSFileHandleReadToEndOfFileCompletionNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileHandleReadToEndOfFileCompletionNotification, "NSFileHandleReadToEndOfFileCompletionNotification", nil);
}

// NSString * const NSFileHandleConnectionAcceptedNotification;
static VALUE
osx_NSFileHandleConnectionAcceptedNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileHandleConnectionAcceptedNotification, "NSFileHandleConnectionAcceptedNotification", nil);
}

// NSString * const NSFileHandleDataAvailableNotification;
static VALUE
osx_NSFileHandleDataAvailableNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileHandleDataAvailableNotification, "NSFileHandleDataAvailableNotification", nil);
}

// NSString * const NSFileHandleNotificationDataItem;
static VALUE
osx_NSFileHandleNotificationDataItem(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileHandleNotificationDataItem, "NSFileHandleNotificationDataItem", nil);
}

// NSString * const NSFileHandleNotificationFileHandleItem;
static VALUE
osx_NSFileHandleNotificationFileHandleItem(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileHandleNotificationFileHandleItem, "NSFileHandleNotificationFileHandleItem", nil);
}

// NSString * const NSFileHandleNotificationMonitorModes;
static VALUE
osx_NSFileHandleNotificationMonitorModes(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileHandleNotificationMonitorModes, "NSFileHandleNotificationMonitorModes", nil);
}

void init_NSFileHandle(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "NSFileHandleOperationException", osx_NSFileHandleOperationException, 0);
  rb_define_module_function(mOSX, "NSFileHandleReadCompletionNotification", osx_NSFileHandleReadCompletionNotification, 0);
  rb_define_module_function(mOSX, "NSFileHandleReadToEndOfFileCompletionNotification", osx_NSFileHandleReadToEndOfFileCompletionNotification, 0);
  rb_define_module_function(mOSX, "NSFileHandleConnectionAcceptedNotification", osx_NSFileHandleConnectionAcceptedNotification, 0);
  rb_define_module_function(mOSX, "NSFileHandleDataAvailableNotification", osx_NSFileHandleDataAvailableNotification, 0);
  rb_define_module_function(mOSX, "NSFileHandleNotificationDataItem", osx_NSFileHandleNotificationDataItem, 0);
  rb_define_module_function(mOSX, "NSFileHandleNotificationFileHandleItem", osx_NSFileHandleNotificationFileHandleItem, 0);
  rb_define_module_function(mOSX, "NSFileHandleNotificationMonitorModes", osx_NSFileHandleNotificationMonitorModes, 0);
}
  /**** constants ****/
// NSString * const NSFileType;
static VALUE
osx_NSFileType(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileType, "NSFileType", nil);
}

// NSString * const NSFileTypeDirectory;
static VALUE
osx_NSFileTypeDirectory(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileTypeDirectory, "NSFileTypeDirectory", nil);
}

// NSString * const NSFileTypeRegular;
static VALUE
osx_NSFileTypeRegular(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileTypeRegular, "NSFileTypeRegular", nil);
}

// NSString * const NSFileTypeSymbolicLink;
static VALUE
osx_NSFileTypeSymbolicLink(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileTypeSymbolicLink, "NSFileTypeSymbolicLink", nil);
}

// NSString * const NSFileTypeSocket;
static VALUE
osx_NSFileTypeSocket(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileTypeSocket, "NSFileTypeSocket", nil);
}

// NSString * const NSFileTypeCharacterSpecial;
static VALUE
osx_NSFileTypeCharacterSpecial(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileTypeCharacterSpecial, "NSFileTypeCharacterSpecial", nil);
}

// NSString * const NSFileTypeBlockSpecial;
static VALUE
osx_NSFileTypeBlockSpecial(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileTypeBlockSpecial, "NSFileTypeBlockSpecial", nil);
}

// NSString * const NSFileTypeUnknown;
static VALUE
osx_NSFileTypeUnknown(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileTypeUnknown, "NSFileTypeUnknown", nil);
}

// NSString * const NSFileSize;
static VALUE
osx_NSFileSize(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileSize, "NSFileSize", nil);
}

// NSString * const NSFileModificationDate;
static VALUE
osx_NSFileModificationDate(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileModificationDate, "NSFileModificationDate", nil);
}

// NSString * const NSFileReferenceCount;
static VALUE
osx_NSFileReferenceCount(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileReferenceCount, "NSFileReferenceCount", nil);
}

// NSString * const NSFileDeviceIdentifier;
static VALUE
osx_NSFileDeviceIdentifier(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileDeviceIdentifier, "NSFileDeviceIdentifier", nil);
}

// NSString * const NSFileOwnerAccountName;
static VALUE
osx_NSFileOwnerAccountName(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileOwnerAccountName, "NSFileOwnerAccountName", nil);
}

// NSString * const NSFileGroupOwnerAccountName;
static VALUE
osx_NSFileGroupOwnerAccountName(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileGroupOwnerAccountName, "NSFileGroupOwnerAccountName", nil);
}

// NSString * const NSFilePosixPermissions;
static VALUE
osx_NSFilePosixPermissions(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFilePosixPermissions, "NSFilePosixPermissions", nil);
}

// NSString * const NSFileSystemNumber;
static VALUE
osx_NSFileSystemNumber(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileSystemNumber, "NSFileSystemNumber", nil);
}

// NSString * const NSFileSystemFileNumber;
static VALUE
osx_NSFileSystemFileNumber(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileSystemFileNumber, "NSFileSystemFileNumber", nil);
}

// NSString * const NSFileExtensionHidden;
static VALUE
osx_NSFileExtensionHidden(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileExtensionHidden, "NSFileExtensionHidden", nil);
}

// NSString * const NSFileHFSCreatorCode;
static VALUE
osx_NSFileHFSCreatorCode(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileHFSCreatorCode, "NSFileHFSCreatorCode", nil);
}

// NSString * const NSFileHFSTypeCode;
static VALUE
osx_NSFileHFSTypeCode(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileHFSTypeCode, "NSFileHFSTypeCode", nil);
}

// NSString * const NSFileImmutable;
static VALUE
osx_NSFileImmutable(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileImmutable, "NSFileImmutable", nil);
}

// NSString * const NSFileAppendOnly;
static VALUE
osx_NSFileAppendOnly(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileAppendOnly, "NSFileAppendOnly", nil);
}

// NSString * const NSFileCreationDate;
static VALUE
osx_NSFileCreationDate(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileCreationDate, "NSFileCreationDate", nil);
}

// NSString * const NSFileOwnerAccountID;
static VALUE
osx_NSFileOwnerAccountID(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileOwnerAccountID, "NSFileOwnerAccountID", nil);
}

// NSString * const NSFileGroupOwnerAccountID;
static VALUE
osx_NSFileGroupOwnerAccountID(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileGroupOwnerAccountID, "NSFileGroupOwnerAccountID", nil);
}

// NSString * const NSFileBusy;
static VALUE
osx_NSFileBusy(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileBusy, "NSFileBusy", nil);
}

// NSString * const NSFileSystemSize;
static VALUE
osx_NSFileSystemSize(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileSystemSize, "NSFileSystemSize", nil);
}

// NSString * const NSFileSystemFreeSize;
static VALUE
osx_NSFileSystemFreeSize(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileSystemFreeSize, "NSFileSystemFreeSize", nil);
}

// NSString * const NSFileSystemNodes;
static VALUE
osx_NSFileSystemNodes(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileSystemNodes, "NSFileSystemNodes", nil);
}

// NSString * const NSFileSystemFreeNodes;
static VALUE
osx_NSFileSystemFreeNodes(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSFileSystemFreeNodes, "NSFileSystemFreeNodes", nil);
}

void init_NSFileManager(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "NSFileType", osx_NSFileType, 0);
  rb_define_module_function(mOSX, "NSFileTypeDirectory", osx_NSFileTypeDirectory, 0);
  rb_define_module_function(mOSX, "NSFileTypeRegular", osx_NSFileTypeRegular, 0);
  rb_define_module_function(mOSX, "NSFileTypeSymbolicLink", osx_NSFileTypeSymbolicLink, 0);
  rb_define_module_function(mOSX, "NSFileTypeSocket", osx_NSFileTypeSocket, 0);
  rb_define_module_function(mOSX, "NSFileTypeCharacterSpecial", osx_NSFileTypeCharacterSpecial, 0);
  rb_define_module_function(mOSX, "NSFileTypeBlockSpecial", osx_NSFileTypeBlockSpecial, 0);
  rb_define_module_function(mOSX, "NSFileTypeUnknown", osx_NSFileTypeUnknown, 0);
  rb_define_module_function(mOSX, "NSFileSize", osx_NSFileSize, 0);
  rb_define_module_function(mOSX, "NSFileModificationDate", osx_NSFileModificationDate, 0);
  rb_define_module_function(mOSX, "NSFileReferenceCount", osx_NSFileReferenceCount, 0);
  rb_define_module_function(mOSX, "NSFileDeviceIdentifier", osx_NSFileDeviceIdentifier, 0);
  rb_define_module_function(mOSX, "NSFileOwnerAccountName", osx_NSFileOwnerAccountName, 0);
  rb_define_module_function(mOSX, "NSFileGroupOwnerAccountName", osx_NSFileGroupOwnerAccountName, 0);
  rb_define_module_function(mOSX, "NSFilePosixPermissions", osx_NSFilePosixPermissions, 0);
  rb_define_module_function(mOSX, "NSFileSystemNumber", osx_NSFileSystemNumber, 0);
  rb_define_module_function(mOSX, "NSFileSystemFileNumber", osx_NSFileSystemFileNumber, 0);
  rb_define_module_function(mOSX, "NSFileExtensionHidden", osx_NSFileExtensionHidden, 0);
  rb_define_module_function(mOSX, "NSFileHFSCreatorCode", osx_NSFileHFSCreatorCode, 0);
  rb_define_module_function(mOSX, "NSFileHFSTypeCode", osx_NSFileHFSTypeCode, 0);
  rb_define_module_function(mOSX, "NSFileImmutable", osx_NSFileImmutable, 0);
  rb_define_module_function(mOSX, "NSFileAppendOnly", osx_NSFileAppendOnly, 0);
  rb_define_module_function(mOSX, "NSFileCreationDate", osx_NSFileCreationDate, 0);
  rb_define_module_function(mOSX, "NSFileOwnerAccountID", osx_NSFileOwnerAccountID, 0);
  rb_define_module_function(mOSX, "NSFileGroupOwnerAccountID", osx_NSFileGroupOwnerAccountID, 0);
  rb_define_module_function(mOSX, "NSFileBusy", osx_NSFileBusy, 0);
  rb_define_module_function(mOSX, "NSFileSystemSize", osx_NSFileSystemSize, 0);
  rb_define_module_function(mOSX, "NSFileSystemFreeSize", osx_NSFileSystemFreeSize, 0);
  rb_define_module_function(mOSX, "NSFileSystemNodes", osx_NSFileSystemNodes, 0);
  rb_define_module_function(mOSX, "NSFileSystemFreeNodes", osx_NSFileSystemFreeNodes, 0);
}
  /**** constants ****/
// NSString *const NSUndefinedKeyException;
static VALUE
osx_NSUndefinedKeyException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSUndefinedKeyException, "NSUndefinedKeyException", nil);
}

// NSString *const NSAverageKeyValueOperator;
static VALUE
osx_NSAverageKeyValueOperator(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSAverageKeyValueOperator, "NSAverageKeyValueOperator", nil);
}

// NSString *const NSCountKeyValueOperator;
static VALUE
osx_NSCountKeyValueOperator(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSCountKeyValueOperator, "NSCountKeyValueOperator", nil);
}

// NSString *const NSDistinctUnionOfArraysKeyValueOperator;
static VALUE
osx_NSDistinctUnionOfArraysKeyValueOperator(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSDistinctUnionOfArraysKeyValueOperator, "NSDistinctUnionOfArraysKeyValueOperator", nil);
}

// NSString *const NSDistinctUnionOfObjectsKeyValueOperator;
static VALUE
osx_NSDistinctUnionOfObjectsKeyValueOperator(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSDistinctUnionOfObjectsKeyValueOperator, "NSDistinctUnionOfObjectsKeyValueOperator", nil);
}

// NSString *const NSDistinctUnionOfSetsKeyValueOperator;
static VALUE
osx_NSDistinctUnionOfSetsKeyValueOperator(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSDistinctUnionOfSetsKeyValueOperator, "NSDistinctUnionOfSetsKeyValueOperator", nil);
}

// NSString *const NSMaximumKeyValueOperator;
static VALUE
osx_NSMaximumKeyValueOperator(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSMaximumKeyValueOperator, "NSMaximumKeyValueOperator", nil);
}

// NSString *const NSMinimumKeyValueOperator;
static VALUE
osx_NSMinimumKeyValueOperator(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSMinimumKeyValueOperator, "NSMinimumKeyValueOperator", nil);
}

// NSString *const NSSumKeyValueOperator;
static VALUE
osx_NSSumKeyValueOperator(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSSumKeyValueOperator, "NSSumKeyValueOperator", nil);
}

// NSString *const NSUnionOfArraysKeyValueOperator;
static VALUE
osx_NSUnionOfArraysKeyValueOperator(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSUnionOfArraysKeyValueOperator, "NSUnionOfArraysKeyValueOperator", nil);
}

// NSString *const NSUnionOfObjectsKeyValueOperator;
static VALUE
osx_NSUnionOfObjectsKeyValueOperator(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSUnionOfObjectsKeyValueOperator, "NSUnionOfObjectsKeyValueOperator", nil);
}

// NSString *const NSUnionOfSetsKeyValueOperator;
static VALUE
osx_NSUnionOfSetsKeyValueOperator(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSUnionOfSetsKeyValueOperator, "NSUnionOfSetsKeyValueOperator", nil);
}

void init_NSKeyValueCoding(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "NSUndefinedKeyException", osx_NSUndefinedKeyException, 0);
  rb_define_module_function(mOSX, "NSAverageKeyValueOperator", osx_NSAverageKeyValueOperator, 0);
  rb_define_module_function(mOSX, "NSCountKeyValueOperator", osx_NSCountKeyValueOperator, 0);
  rb_define_module_function(mOSX, "NSDistinctUnionOfArraysKeyValueOperator", osx_NSDistinctUnionOfArraysKeyValueOperator, 0);
  rb_define_module_function(mOSX, "NSDistinctUnionOfObjectsKeyValueOperator", osx_NSDistinctUnionOfObjectsKeyValueOperator, 0);
  rb_define_module_function(mOSX, "NSDistinctUnionOfSetsKeyValueOperator", osx_NSDistinctUnionOfSetsKeyValueOperator, 0);
  rb_define_module_function(mOSX, "NSMaximumKeyValueOperator", osx_NSMaximumKeyValueOperator, 0);
  rb_define_module_function(mOSX, "NSMinimumKeyValueOperator", osx_NSMinimumKeyValueOperator, 0);
  rb_define_module_function(mOSX, "NSSumKeyValueOperator", osx_NSSumKeyValueOperator, 0);
  rb_define_module_function(mOSX, "NSUnionOfArraysKeyValueOperator", osx_NSUnionOfArraysKeyValueOperator, 0);
  rb_define_module_function(mOSX, "NSUnionOfObjectsKeyValueOperator", osx_NSUnionOfObjectsKeyValueOperator, 0);
  rb_define_module_function(mOSX, "NSUnionOfSetsKeyValueOperator", osx_NSUnionOfSetsKeyValueOperator, 0);
}
  /**** constants ****/
// NSString *const NSKeyValueChangeKindKey;
static VALUE
osx_NSKeyValueChangeKindKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSKeyValueChangeKindKey, "NSKeyValueChangeKindKey", nil);
}

// NSString *const NSKeyValueChangeNewKey;
static VALUE
osx_NSKeyValueChangeNewKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSKeyValueChangeNewKey, "NSKeyValueChangeNewKey", nil);
}

// NSString *const NSKeyValueChangeOldKey;
static VALUE
osx_NSKeyValueChangeOldKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSKeyValueChangeOldKey, "NSKeyValueChangeOldKey", nil);
}

// NSString *const NSKeyValueChangeIndexesKey;
static VALUE
osx_NSKeyValueChangeIndexesKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSKeyValueChangeIndexesKey, "NSKeyValueChangeIndexesKey", nil);
}

// NSString *const NSKeyValueChangeNotificationIsPriorKey;
static VALUE
osx_NSKeyValueChangeNotificationIsPriorKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSKeyValueChangeNotificationIsPriorKey, "NSKeyValueChangeNotificationIsPriorKey", nil);
}

void init_NSKeyValueObserving(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSKeyValueObservingOptionNew", INT2NUM(NSKeyValueObservingOptionNew));
  rb_define_const(mOSX, "NSKeyValueObservingOptionOld", INT2NUM(NSKeyValueObservingOptionOld));
  rb_define_const(mOSX, "NSKeyValueObservingOptionInitial", INT2NUM(NSKeyValueObservingOptionInitial));
  rb_define_const(mOSX, "NSKeyValueObservingOptionPrior", INT2NUM(NSKeyValueObservingOptionPrior));
  rb_define_const(mOSX, "NSKeyValueChangeSetting", INT2NUM(NSKeyValueChangeSetting));
  rb_define_const(mOSX, "NSKeyValueChangeInsertion", INT2NUM(NSKeyValueChangeInsertion));
  rb_define_const(mOSX, "NSKeyValueChangeRemoval", INT2NUM(NSKeyValueChangeRemoval));
  rb_define_const(mOSX, "NSKeyValueChangeReplacement", INT2NUM(NSKeyValueChangeReplacement));
  rb_define_const(mOSX, "NSKeyValueUnionSetMutation", INT2NUM(NSKeyValueUnionSetMutation));
  rb_define_const(mOSX, "NSKeyValueMinusSetMutation", INT2NUM(NSKeyValueMinusSetMutation));
  rb_define_const(mOSX, "NSKeyValueIntersectSetMutation", INT2NUM(NSKeyValueIntersectSetMutation));
  rb_define_const(mOSX, "NSKeyValueSetSetMutation", INT2NUM(NSKeyValueSetSetMutation));

  /**** constants ****/
  rb_define_module_function(mOSX, "NSKeyValueChangeKindKey", osx_NSKeyValueChangeKindKey, 0);
  rb_define_module_function(mOSX, "NSKeyValueChangeNewKey", osx_NSKeyValueChangeNewKey, 0);
  rb_define_module_function(mOSX, "NSKeyValueChangeOldKey", osx_NSKeyValueChangeOldKey, 0);
  rb_define_module_function(mOSX, "NSKeyValueChangeIndexesKey", osx_NSKeyValueChangeIndexesKey, 0);
  rb_define_module_function(mOSX, "NSKeyValueChangeNotificationIsPriorKey", osx_NSKeyValueChangeNotificationIsPriorKey, 0);
}
  /**** constants ****/
// NSString * const NSInvalidArchiveOperationException;
static VALUE
osx_NSInvalidArchiveOperationException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSInvalidArchiveOperationException, "NSInvalidArchiveOperationException", nil);
}

// NSString * const NSInvalidUnarchiveOperationException;
static VALUE
osx_NSInvalidUnarchiveOperationException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSInvalidUnarchiveOperationException, "NSInvalidUnarchiveOperationException", nil);
}

void init_NSKeyedArchiver(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "NSInvalidArchiveOperationException", osx_NSInvalidArchiveOperationException, 0);
  rb_define_module_function(mOSX, "NSInvalidUnarchiveOperationException", osx_NSInvalidUnarchiveOperationException, 0);
}
  /**** constants ****/
// NSString * const NSCurrentLocaleDidChangeNotification;
static VALUE
osx_NSCurrentLocaleDidChangeNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSCurrentLocaleDidChangeNotification, "NSCurrentLocaleDidChangeNotification", nil);
}

// NSString * const NSLocaleIdentifier;
static VALUE
osx_NSLocaleIdentifier(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSLocaleIdentifier, "NSLocaleIdentifier", nil);
}

// NSString * const NSLocaleLanguageCode;
static VALUE
osx_NSLocaleLanguageCode(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSLocaleLanguageCode, "NSLocaleLanguageCode", nil);
}

// NSString * const NSLocaleCountryCode;
static VALUE
osx_NSLocaleCountryCode(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSLocaleCountryCode, "NSLocaleCountryCode", nil);
}

// NSString * const NSLocaleScriptCode;
static VALUE
osx_NSLocaleScriptCode(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSLocaleScriptCode, "NSLocaleScriptCode", nil);
}

// NSString * const NSLocaleVariantCode;
static VALUE
osx_NSLocaleVariantCode(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSLocaleVariantCode, "NSLocaleVariantCode", nil);
}

// NSString * const NSLocaleExemplarCharacterSet;
static VALUE
osx_NSLocaleExemplarCharacterSet(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSLocaleExemplarCharacterSet, "NSLocaleExemplarCharacterSet", nil);
}

// NSString * const NSLocaleCalendar;
static VALUE
osx_NSLocaleCalendar(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSLocaleCalendar, "NSLocaleCalendar", nil);
}

// NSString * const NSLocaleCollationIdentifier;
static VALUE
osx_NSLocaleCollationIdentifier(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSLocaleCollationIdentifier, "NSLocaleCollationIdentifier", nil);
}

// NSString * const NSLocaleUsesMetricSystem;
static VALUE
osx_NSLocaleUsesMetricSystem(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSLocaleUsesMetricSystem, "NSLocaleUsesMetricSystem", nil);
}

// NSString * const NSLocaleMeasurementSystem;
static VALUE
osx_NSLocaleMeasurementSystem(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSLocaleMeasurementSystem, "NSLocaleMeasurementSystem", nil);
}

// NSString * const NSLocaleDecimalSeparator;
static VALUE
osx_NSLocaleDecimalSeparator(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSLocaleDecimalSeparator, "NSLocaleDecimalSeparator", nil);
}

// NSString * const NSLocaleGroupingSeparator;
static VALUE
osx_NSLocaleGroupingSeparator(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSLocaleGroupingSeparator, "NSLocaleGroupingSeparator", nil);
}

// NSString * const NSLocaleCurrencySymbol;
static VALUE
osx_NSLocaleCurrencySymbol(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSLocaleCurrencySymbol, "NSLocaleCurrencySymbol", nil);
}

// NSString * const NSLocaleCurrencyCode;
static VALUE
osx_NSLocaleCurrencyCode(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSLocaleCurrencyCode, "NSLocaleCurrencyCode", nil);
}

// NSString * const NSGregorianCalendar;
static VALUE
osx_NSGregorianCalendar(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSGregorianCalendar, "NSGregorianCalendar", nil);
}

// NSString * const NSBuddhistCalendar;
static VALUE
osx_NSBuddhistCalendar(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSBuddhistCalendar, "NSBuddhistCalendar", nil);
}

// NSString * const NSChineseCalendar;
static VALUE
osx_NSChineseCalendar(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSChineseCalendar, "NSChineseCalendar", nil);
}

// NSString * const NSHebrewCalendar;
static VALUE
osx_NSHebrewCalendar(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSHebrewCalendar, "NSHebrewCalendar", nil);
}

// NSString * const NSIslamicCalendar;
static VALUE
osx_NSIslamicCalendar(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSIslamicCalendar, "NSIslamicCalendar", nil);
}

// NSString * const NSIslamicCivilCalendar;
static VALUE
osx_NSIslamicCivilCalendar(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSIslamicCivilCalendar, "NSIslamicCivilCalendar", nil);
}

// NSString * const NSJapaneseCalendar;
static VALUE
osx_NSJapaneseCalendar(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSJapaneseCalendar, "NSJapaneseCalendar", nil);
}

void init_NSLocale(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "NSCurrentLocaleDidChangeNotification", osx_NSCurrentLocaleDidChangeNotification, 0);
  rb_define_module_function(mOSX, "NSLocaleIdentifier", osx_NSLocaleIdentifier, 0);
  rb_define_module_function(mOSX, "NSLocaleLanguageCode", osx_NSLocaleLanguageCode, 0);
  rb_define_module_function(mOSX, "NSLocaleCountryCode", osx_NSLocaleCountryCode, 0);
  rb_define_module_function(mOSX, "NSLocaleScriptCode", osx_NSLocaleScriptCode, 0);
  rb_define_module_function(mOSX, "NSLocaleVariantCode", osx_NSLocaleVariantCode, 0);
  rb_define_module_function(mOSX, "NSLocaleExemplarCharacterSet", osx_NSLocaleExemplarCharacterSet, 0);
  rb_define_module_function(mOSX, "NSLocaleCalendar", osx_NSLocaleCalendar, 0);
  rb_define_module_function(mOSX, "NSLocaleCollationIdentifier", osx_NSLocaleCollationIdentifier, 0);
  rb_define_module_function(mOSX, "NSLocaleUsesMetricSystem", osx_NSLocaleUsesMetricSystem, 0);
  rb_define_module_function(mOSX, "NSLocaleMeasurementSystem", osx_NSLocaleMeasurementSystem, 0);
  rb_define_module_function(mOSX, "NSLocaleDecimalSeparator", osx_NSLocaleDecimalSeparator, 0);
  rb_define_module_function(mOSX, "NSLocaleGroupingSeparator", osx_NSLocaleGroupingSeparator, 0);
  rb_define_module_function(mOSX, "NSLocaleCurrencySymbol", osx_NSLocaleCurrencySymbol, 0);
  rb_define_module_function(mOSX, "NSLocaleCurrencyCode", osx_NSLocaleCurrencyCode, 0);
  rb_define_module_function(mOSX, "NSGregorianCalendar", osx_NSGregorianCalendar, 0);
  rb_define_module_function(mOSX, "NSBuddhistCalendar", osx_NSBuddhistCalendar, 0);
  rb_define_module_function(mOSX, "NSChineseCalendar", osx_NSChineseCalendar, 0);
  rb_define_module_function(mOSX, "NSHebrewCalendar", osx_NSHebrewCalendar, 0);
  rb_define_module_function(mOSX, "NSIslamicCalendar", osx_NSIslamicCalendar, 0);
  rb_define_module_function(mOSX, "NSIslamicCivilCalendar", osx_NSIslamicCivilCalendar, 0);
  rb_define_module_function(mOSX, "NSJapaneseCalendar", osx_NSJapaneseCalendar, 0);
}
void init_NSNotificationQueue(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSPostWhenIdle", INT2NUM(NSPostWhenIdle));
  rb_define_const(mOSX, "NSPostASAP", INT2NUM(NSPostASAP));
  rb_define_const(mOSX, "NSPostNow", INT2NUM(NSPostNow));
  rb_define_const(mOSX, "NSNotificationNoCoalescing", INT2NUM(NSNotificationNoCoalescing));
  rb_define_const(mOSX, "NSNotificationCoalescingOnName", INT2NUM(NSNotificationCoalescingOnName));
  rb_define_const(mOSX, "NSNotificationCoalescingOnSender", INT2NUM(NSNotificationCoalescingOnSender));

}
void init_NSNumberFormatter(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSNumberFormatterNoStyle", INT2NUM(NSNumberFormatterNoStyle));
  rb_define_const(mOSX, "NSNumberFormatterDecimalStyle", INT2NUM(NSNumberFormatterDecimalStyle));
  rb_define_const(mOSX, "NSNumberFormatterCurrencyStyle", INT2NUM(NSNumberFormatterCurrencyStyle));
  rb_define_const(mOSX, "NSNumberFormatterPercentStyle", INT2NUM(NSNumberFormatterPercentStyle));
  rb_define_const(mOSX, "NSNumberFormatterScientificStyle", INT2NUM(NSNumberFormatterScientificStyle));
  rb_define_const(mOSX, "NSNumberFormatterSpellOutStyle", INT2NUM(NSNumberFormatterSpellOutStyle));
  rb_define_const(mOSX, "NSNumberFormatterBehaviorDefault", INT2NUM(NSNumberFormatterBehaviorDefault));
  rb_define_const(mOSX, "NSNumberFormatterBehavior10_0", INT2NUM(NSNumberFormatterBehavior10_0));
  rb_define_const(mOSX, "NSNumberFormatterBehavior10_4", INT2NUM(NSNumberFormatterBehavior10_4));
  rb_define_const(mOSX, "NSNumberFormatterPadBeforePrefix", INT2NUM(NSNumberFormatterPadBeforePrefix));
  rb_define_const(mOSX, "NSNumberFormatterPadAfterPrefix", INT2NUM(NSNumberFormatterPadAfterPrefix));
  rb_define_const(mOSX, "NSNumberFormatterPadBeforeSuffix", INT2NUM(NSNumberFormatterPadBeforeSuffix));
  rb_define_const(mOSX, "NSNumberFormatterPadAfterSuffix", INT2NUM(NSNumberFormatterPadAfterSuffix));
  rb_define_const(mOSX, "NSNumberFormatterRoundCeiling", INT2NUM(NSNumberFormatterRoundCeiling));
  rb_define_const(mOSX, "NSNumberFormatterRoundFloor", INT2NUM(NSNumberFormatterRoundFloor));
  rb_define_const(mOSX, "NSNumberFormatterRoundDown", INT2NUM(NSNumberFormatterRoundDown));
  rb_define_const(mOSX, "NSNumberFormatterRoundUp", INT2NUM(NSNumberFormatterRoundUp));
  rb_define_const(mOSX, "NSNumberFormatterRoundHalfEven", INT2NUM(NSNumberFormatterRoundHalfEven));
  rb_define_const(mOSX, "NSNumberFormatterRoundHalfDown", INT2NUM(NSNumberFormatterRoundHalfDown));
  rb_define_const(mOSX, "NSNumberFormatterRoundHalfUp", INT2NUM(NSNumberFormatterRoundHalfUp));

}
  /**** functions ****/
// id NSAllocateObject(Class aClass, NSUInteger extraBytes, NSZone *zone);
static VALUE
osx_NSAllocateObject(VALUE mdl, VALUE a0, VALUE a1, VALUE a2)
{
  rb_notimplement();
}

// void NSDeallocateObject(id object);
static VALUE
osx_NSDeallocateObject(VALUE mdl, VALUE a0)
{

  id ns_a0;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _C_ID, &ns_a0, "NSDeallocateObject", pool, 0);

NS_DURING
  NSDeallocateObject(ns_a0);
NS_HANDLER
  excp = oc_err_new ("NSDeallocateObject", localException);
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

// id NSCopyObject(id object, NSUInteger extraBytes, NSZone *zone);
static VALUE
osx_NSCopyObject(VALUE mdl, VALUE a0, VALUE a1, VALUE a2)
{
  rb_notimplement();
}

// BOOL NSShouldRetainWithZone(id anObject, NSZone *requestedZone);
static VALUE
osx_NSShouldRetainWithZone(VALUE mdl, VALUE a0, VALUE a1)
{
  BOOL ns_result;

  id ns_a0;
  NSZone * ns_a1;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _C_ID, &ns_a0, "NSShouldRetainWithZone", pool, 0);
  /* a1 */
  rbarg_to_nsarg(a1, _PRIV_C_PTR, &ns_a1, "NSShouldRetainWithZone", pool, 1);

NS_DURING
  ns_result = NSShouldRetainWithZone(ns_a0, ns_a1);
NS_HANDLER
  excp = oc_err_new ("NSShouldRetainWithZone", localException);
NS_ENDHANDLER
  if (excp != Qnil) {
    [pool release];
    rb_exc_raise (excp);
    return Qnil;
  }

  rb_result = nsresult_to_rbresult(_PRIV_C_BOOL, &ns_result, "NSShouldRetainWithZone", pool);
  [pool release];
  return rb_result;
}

// void NSIncrementExtraRefCount(id object);
static VALUE
osx_NSIncrementExtraRefCount(VALUE mdl, VALUE a0)
{

  id ns_a0;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _C_ID, &ns_a0, "NSIncrementExtraRefCount", pool, 0);

NS_DURING
  NSIncrementExtraRefCount(ns_a0);
NS_HANDLER
  excp = oc_err_new ("NSIncrementExtraRefCount", localException);
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

// BOOL NSDecrementExtraRefCountWasZero(id object);
static VALUE
osx_NSDecrementExtraRefCountWasZero(VALUE mdl, VALUE a0)
{
  BOOL ns_result;

  id ns_a0;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _C_ID, &ns_a0, "NSDecrementExtraRefCountWasZero", pool, 0);

NS_DURING
  ns_result = NSDecrementExtraRefCountWasZero(ns_a0);
NS_HANDLER
  excp = oc_err_new ("NSDecrementExtraRefCountWasZero", localException);
NS_ENDHANDLER
  if (excp != Qnil) {
    [pool release];
    rb_exc_raise (excp);
    return Qnil;
  }

  rb_result = nsresult_to_rbresult(_PRIV_C_BOOL, &ns_result, "NSDecrementExtraRefCountWasZero", pool);
  [pool release];
  return rb_result;
}

// NSUInteger NSExtraRefCount(id object);
static VALUE
osx_NSExtraRefCount(VALUE mdl, VALUE a0)
{
  rb_notimplement();
}

void init_NSObject(VALUE mOSX)
{
  /**** functions ****/
  rb_define_module_function(mOSX, "NSAllocateObject", osx_NSAllocateObject, 3);
  rb_define_module_function(mOSX, "NSDeallocateObject", osx_NSDeallocateObject, 1);
  rb_define_module_function(mOSX, "NSCopyObject", osx_NSCopyObject, 3);
  rb_define_module_function(mOSX, "NSShouldRetainWithZone", osx_NSShouldRetainWithZone, 2);
  rb_define_module_function(mOSX, "NSIncrementExtraRefCount", osx_NSIncrementExtraRefCount, 1);
  rb_define_module_function(mOSX, "NSDecrementExtraRefCountWasZero", osx_NSDecrementExtraRefCountWasZero, 1);
  rb_define_module_function(mOSX, "NSExtraRefCount", osx_NSExtraRefCount, 1);
}
  /**** constants ****/
// NSString * const NSInvocationOperationVoidResultException;
static VALUE
osx_NSInvocationOperationVoidResultException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSInvocationOperationVoidResultException, "NSInvocationOperationVoidResultException", nil);
}

// NSString * const NSInvocationOperationCancelledException;
static VALUE
osx_NSInvocationOperationCancelledException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSInvocationOperationCancelledException, "NSInvocationOperationCancelledException", nil);
}

void init_NSOperation(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSOperationQueuePriorityVeryLow", INT2NUM(NSOperationQueuePriorityVeryLow));
  rb_define_const(mOSX, "NSOperationQueuePriorityLow", INT2NUM(NSOperationQueuePriorityLow));
  rb_define_const(mOSX, "NSOperationQueuePriorityNormal", INT2NUM(NSOperationQueuePriorityNormal));
  rb_define_const(mOSX, "NSOperationQueuePriorityHigh", INT2NUM(NSOperationQueuePriorityHigh));
  rb_define_const(mOSX, "NSOperationQueuePriorityVeryHigh", INT2NUM(NSOperationQueuePriorityVeryHigh));
  rb_define_const(mOSX, "NSOperationQueueDefaultMaxConcurrentOperationCount", INT2NUM(NSOperationQueueDefaultMaxConcurrentOperationCount));

  /**** constants ****/
  rb_define_module_function(mOSX, "NSInvocationOperationVoidResultException", osx_NSInvocationOperationVoidResultException, 0);
  rb_define_module_function(mOSX, "NSInvocationOperationCancelledException", osx_NSInvocationOperationCancelledException, 0);
}
  /**** functions ****/
// NSString *NSUserName(void);
static VALUE
osx_NSUserName(VALUE mdl)
{
  NSString * ns_result = NSUserName();
  return nsresult_to_rbresult(_C_ID, &ns_result, "NSUserName", nil);
}

// NSString *NSFullUserName(void);
static VALUE
osx_NSFullUserName(VALUE mdl)
{
  NSString * ns_result = NSFullUserName();
  return nsresult_to_rbresult(_C_ID, &ns_result, "NSFullUserName", nil);
}

// NSString *NSHomeDirectory(void);
static VALUE
osx_NSHomeDirectory(VALUE mdl)
{
  NSString * ns_result = NSHomeDirectory();
  return nsresult_to_rbresult(_C_ID, &ns_result, "NSHomeDirectory", nil);
}

// NSString *NSHomeDirectoryForUser(NSString *userName);
static VALUE
osx_NSHomeDirectoryForUser(VALUE mdl, VALUE a0)
{
  NSString * ns_result;

  NSString * ns_a0;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _C_ID, &ns_a0, "NSHomeDirectoryForUser", pool, 0);

NS_DURING
  ns_result = NSHomeDirectoryForUser(ns_a0);
NS_HANDLER
  excp = oc_err_new ("NSHomeDirectoryForUser", localException);
NS_ENDHANDLER
  if (excp != Qnil) {
    [pool release];
    rb_exc_raise (excp);
    return Qnil;
  }

  rb_result = nsresult_to_rbresult(_C_ID, &ns_result, "NSHomeDirectoryForUser", pool);
  [pool release];
  return rb_result;
}

// NSString *NSTemporaryDirectory(void);
static VALUE
osx_NSTemporaryDirectory(VALUE mdl)
{
  NSString * ns_result = NSTemporaryDirectory();
  return nsresult_to_rbresult(_C_ID, &ns_result, "NSTemporaryDirectory", nil);
}

// NSString *NSOpenStepRootDirectory(void);
static VALUE
osx_NSOpenStepRootDirectory(VALUE mdl)
{
  NSString * ns_result = NSOpenStepRootDirectory();
  return nsresult_to_rbresult(_C_ID, &ns_result, "NSOpenStepRootDirectory", nil);
}

// NSArray *NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory directory, NSSearchPathDomainMask domainMask, BOOL expandTilde);
static VALUE
osx_NSSearchPathForDirectoriesInDomains(VALUE mdl, VALUE a0, VALUE a1, VALUE a2)
{
  rb_notimplement();
}

void init_NSPathUtilities(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSApplicationDirectory", INT2NUM(NSApplicationDirectory));
  rb_define_const(mOSX, "NSDemoApplicationDirectory", INT2NUM(NSDemoApplicationDirectory));
  rb_define_const(mOSX, "NSDeveloperApplicationDirectory", INT2NUM(NSDeveloperApplicationDirectory));
  rb_define_const(mOSX, "NSAdminApplicationDirectory", INT2NUM(NSAdminApplicationDirectory));
  rb_define_const(mOSX, "NSLibraryDirectory", INT2NUM(NSLibraryDirectory));
  rb_define_const(mOSX, "NSDeveloperDirectory", INT2NUM(NSDeveloperDirectory));
  rb_define_const(mOSX, "NSUserDirectory", INT2NUM(NSUserDirectory));
  rb_define_const(mOSX, "NSDocumentationDirectory", INT2NUM(NSDocumentationDirectory));
  rb_define_const(mOSX, "NSDocumentDirectory", INT2NUM(NSDocumentDirectory));
  rb_define_const(mOSX, "NSCoreServiceDirectory", INT2NUM(NSCoreServiceDirectory));
  rb_define_const(mOSX, "NSDesktopDirectory", INT2NUM(NSDesktopDirectory));
  rb_define_const(mOSX, "NSCachesDirectory", INT2NUM(NSCachesDirectory));
  rb_define_const(mOSX, "NSApplicationSupportDirectory", INT2NUM(NSApplicationSupportDirectory));
  rb_define_const(mOSX, "NSDownloadsDirectory", INT2NUM(NSDownloadsDirectory));
  rb_define_const(mOSX, "NSAllApplicationsDirectory", INT2NUM(NSAllApplicationsDirectory));
  rb_define_const(mOSX, "NSAllLibrariesDirectory", INT2NUM(NSAllLibrariesDirectory));
  rb_define_const(mOSX, "NSUserDomainMask", INT2NUM(NSUserDomainMask));
  rb_define_const(mOSX, "NSLocalDomainMask", INT2NUM(NSLocalDomainMask));
  rb_define_const(mOSX, "NSNetworkDomainMask", INT2NUM(NSNetworkDomainMask));
  rb_define_const(mOSX, "NSSystemDomainMask", INT2NUM(NSSystemDomainMask));
  rb_define_const(mOSX, "NSAllDomainsMask", INT2NUM(NSAllDomainsMask));

  /**** functions ****/
  rb_define_module_function(mOSX, "NSUserName", osx_NSUserName, 0);
  rb_define_module_function(mOSX, "NSFullUserName", osx_NSFullUserName, 0);
  rb_define_module_function(mOSX, "NSHomeDirectory", osx_NSHomeDirectory, 0);
  rb_define_module_function(mOSX, "NSHomeDirectoryForUser", osx_NSHomeDirectoryForUser, 1);
  rb_define_module_function(mOSX, "NSTemporaryDirectory", osx_NSTemporaryDirectory, 0);
  rb_define_module_function(mOSX, "NSOpenStepRootDirectory", osx_NSOpenStepRootDirectory, 0);
  rb_define_module_function(mOSX, "NSSearchPathForDirectoriesInDomains", osx_NSSearchPathForDirectoriesInDomains, 3);
}
  /**** constants ****/
// NSString * const NSPortDidBecomeInvalidNotification;
static VALUE
osx_NSPortDidBecomeInvalidNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSPortDidBecomeInvalidNotification, "NSPortDidBecomeInvalidNotification", nil);
}

void init_NSPort(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSMachPortDeallocateNone", INT2NUM(NSMachPortDeallocateNone));
  rb_define_const(mOSX, "NSMachPortDeallocateSendRight", INT2NUM(NSMachPortDeallocateSendRight));
  rb_define_const(mOSX, "NSMachPortDeallocateReceiveRight", INT2NUM(NSMachPortDeallocateReceiveRight));

  /**** constants ****/
  rb_define_module_function(mOSX, "NSPortDidBecomeInvalidNotification", osx_NSPortDidBecomeInvalidNotification, 0);
}
void init_NSProcessInfo(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSWindowsNTOperatingSystem", INT2NUM(NSWindowsNTOperatingSystem));
  rb_define_const(mOSX, "NSWindows95OperatingSystem", INT2NUM(NSWindows95OperatingSystem));
  rb_define_const(mOSX, "NSSolarisOperatingSystem", INT2NUM(NSSolarisOperatingSystem));
  rb_define_const(mOSX, "NSHPUXOperatingSystem", INT2NUM(NSHPUXOperatingSystem));
  rb_define_const(mOSX, "NSMACHOperatingSystem", INT2NUM(NSMACHOperatingSystem));
  rb_define_const(mOSX, "NSSunOSOperatingSystem", INT2NUM(NSSunOSOperatingSystem));
  rb_define_const(mOSX, "NSOSF1OperatingSystem", INT2NUM(NSOSF1OperatingSystem));

}
void init_NSPropertyList(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSPropertyListImmutable", INT2NUM(NSPropertyListImmutable));
  rb_define_const(mOSX, "NSPropertyListMutableContainers", INT2NUM(NSPropertyListMutableContainers));
  rb_define_const(mOSX, "NSPropertyListMutableContainersAndLeaves", INT2NUM(NSPropertyListMutableContainersAndLeaves));
  rb_define_const(mOSX, "NSPropertyListOpenStepFormat", INT2NUM(NSPropertyListOpenStepFormat));
  rb_define_const(mOSX, "NSPropertyListXMLFormat_v1_0", INT2NUM(NSPropertyListXMLFormat_v1_0));
  rb_define_const(mOSX, "NSPropertyListBinaryFormat_v1_0", INT2NUM(NSPropertyListBinaryFormat_v1_0));

}
  /**** functions ****/
// NSRange NSUnionRange(NSRange range1, NSRange range2);
static VALUE
osx_NSUnionRange(VALUE mdl, VALUE a0, VALUE a1)
{
  NSRange ns_result;

  NSRange ns_a0;
  NSRange ns_a1;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _PRIV_C_NSRANGE, &ns_a0, "NSUnionRange", pool, 0);
  /* a1 */
  rbarg_to_nsarg(a1, _PRIV_C_NSRANGE, &ns_a1, "NSUnionRange", pool, 1);

NS_DURING
  ns_result = NSUnionRange(ns_a0, ns_a1);
NS_HANDLER
  excp = oc_err_new ("NSUnionRange", localException);
NS_ENDHANDLER
  if (excp != Qnil) {
    [pool release];
    rb_exc_raise (excp);
    return Qnil;
  }

  rb_result = nsresult_to_rbresult(_PRIV_C_NSRANGE, &ns_result, "NSUnionRange", pool);
  [pool release];
  return rb_result;
}

// NSRange NSIntersectionRange(NSRange range1, NSRange range2);
static VALUE
osx_NSIntersectionRange(VALUE mdl, VALUE a0, VALUE a1)
{
  NSRange ns_result;

  NSRange ns_a0;
  NSRange ns_a1;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _PRIV_C_NSRANGE, &ns_a0, "NSIntersectionRange", pool, 0);
  /* a1 */
  rbarg_to_nsarg(a1, _PRIV_C_NSRANGE, &ns_a1, "NSIntersectionRange", pool, 1);

NS_DURING
  ns_result = NSIntersectionRange(ns_a0, ns_a1);
NS_HANDLER
  excp = oc_err_new ("NSIntersectionRange", localException);
NS_ENDHANDLER
  if (excp != Qnil) {
    [pool release];
    rb_exc_raise (excp);
    return Qnil;
  }

  rb_result = nsresult_to_rbresult(_PRIV_C_NSRANGE, &ns_result, "NSIntersectionRange", pool);
  [pool release];
  return rb_result;
}

// NSString *NSStringFromRange(NSRange range);
static VALUE
osx_NSStringFromRange(VALUE mdl, VALUE a0)
{
  NSString * ns_result;

  NSRange ns_a0;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _PRIV_C_NSRANGE, &ns_a0, "NSStringFromRange", pool, 0);

NS_DURING
  ns_result = NSStringFromRange(ns_a0);
NS_HANDLER
  excp = oc_err_new ("NSStringFromRange", localException);
NS_ENDHANDLER
  if (excp != Qnil) {
    [pool release];
    rb_exc_raise (excp);
    return Qnil;
  }

  rb_result = nsresult_to_rbresult(_C_ID, &ns_result, "NSStringFromRange", pool);
  [pool release];
  return rb_result;
}

// NSRange NSRangeFromString(NSString *aString);
static VALUE
osx_NSRangeFromString(VALUE mdl, VALUE a0)
{
  NSRange ns_result;

  NSString * ns_a0;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _C_ID, &ns_a0, "NSRangeFromString", pool, 0);

NS_DURING
  ns_result = NSRangeFromString(ns_a0);
NS_HANDLER
  excp = oc_err_new ("NSRangeFromString", localException);
NS_ENDHANDLER
  if (excp != Qnil) {
    [pool release];
    rb_exc_raise (excp);
    return Qnil;
  }

  rb_result = nsresult_to_rbresult(_PRIV_C_NSRANGE, &ns_result, "NSRangeFromString", pool);
  [pool release];
  return rb_result;
}

void init_NSRange(VALUE mOSX)
{
  /**** functions ****/
  rb_define_module_function(mOSX, "NSUnionRange", osx_NSUnionRange, 2);
  rb_define_module_function(mOSX, "NSIntersectionRange", osx_NSIntersectionRange, 2);
  rb_define_module_function(mOSX, "NSStringFromRange", osx_NSStringFromRange, 1);
  rb_define_module_function(mOSX, "NSRangeFromString", osx_NSRangeFromString, 1);
}
  /**** constants ****/
// NSString * const NSDefaultRunLoopMode;
static VALUE
osx_NSDefaultRunLoopMode(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSDefaultRunLoopMode, "NSDefaultRunLoopMode", nil);
}

// NSString * const NSRunLoopCommonModes;
static VALUE
osx_NSRunLoopCommonModes(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSRunLoopCommonModes, "NSRunLoopCommonModes", nil);
}

void init_NSRunLoop(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "NSDefaultRunLoopMode", osx_NSDefaultRunLoopMode, 0);
  rb_define_module_function(mOSX, "NSRunLoopCommonModes", osx_NSRunLoopCommonModes, 0);
}
  /**** constants ****/
// NSString * const NSStreamSocketSecurityLevelKey;
static VALUE
osx_NSStreamSocketSecurityLevelKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSStreamSocketSecurityLevelKey, "NSStreamSocketSecurityLevelKey", nil);
}

// NSString * const NSStreamSocketSecurityLevelNone;
static VALUE
osx_NSStreamSocketSecurityLevelNone(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSStreamSocketSecurityLevelNone, "NSStreamSocketSecurityLevelNone", nil);
}

// NSString * const NSStreamSocketSecurityLevelSSLv2;
static VALUE
osx_NSStreamSocketSecurityLevelSSLv2(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSStreamSocketSecurityLevelSSLv2, "NSStreamSocketSecurityLevelSSLv2", nil);
}

// NSString * const NSStreamSocketSecurityLevelSSLv3;
static VALUE
osx_NSStreamSocketSecurityLevelSSLv3(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSStreamSocketSecurityLevelSSLv3, "NSStreamSocketSecurityLevelSSLv3", nil);
}

// NSString * const NSStreamSocketSecurityLevelTLSv1;
static VALUE
osx_NSStreamSocketSecurityLevelTLSv1(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSStreamSocketSecurityLevelTLSv1, "NSStreamSocketSecurityLevelTLSv1", nil);
}

// NSString * const NSStreamSocketSecurityLevelNegotiatedSSL;
static VALUE
osx_NSStreamSocketSecurityLevelNegotiatedSSL(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSStreamSocketSecurityLevelNegotiatedSSL, "NSStreamSocketSecurityLevelNegotiatedSSL", nil);
}

// NSString * const NSStreamSOCKSProxyConfigurationKey;
static VALUE
osx_NSStreamSOCKSProxyConfigurationKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSStreamSOCKSProxyConfigurationKey, "NSStreamSOCKSProxyConfigurationKey", nil);
}

// NSString * const NSStreamSOCKSProxyHostKey;
static VALUE
osx_NSStreamSOCKSProxyHostKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSStreamSOCKSProxyHostKey, "NSStreamSOCKSProxyHostKey", nil);
}

// NSString * const NSStreamSOCKSProxyPortKey;
static VALUE
osx_NSStreamSOCKSProxyPortKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSStreamSOCKSProxyPortKey, "NSStreamSOCKSProxyPortKey", nil);
}

// NSString * const NSStreamSOCKSProxyVersionKey;
static VALUE
osx_NSStreamSOCKSProxyVersionKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSStreamSOCKSProxyVersionKey, "NSStreamSOCKSProxyVersionKey", nil);
}

// NSString * const NSStreamSOCKSProxyUserKey;
static VALUE
osx_NSStreamSOCKSProxyUserKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSStreamSOCKSProxyUserKey, "NSStreamSOCKSProxyUserKey", nil);
}

// NSString * const NSStreamSOCKSProxyPasswordKey;
static VALUE
osx_NSStreamSOCKSProxyPasswordKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSStreamSOCKSProxyPasswordKey, "NSStreamSOCKSProxyPasswordKey", nil);
}

// NSString * const NSStreamSOCKSProxyVersion4;
static VALUE
osx_NSStreamSOCKSProxyVersion4(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSStreamSOCKSProxyVersion4, "NSStreamSOCKSProxyVersion4", nil);
}

// NSString * const NSStreamSOCKSProxyVersion5;
static VALUE
osx_NSStreamSOCKSProxyVersion5(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSStreamSOCKSProxyVersion5, "NSStreamSOCKSProxyVersion5", nil);
}

// NSString * const NSStreamDataWrittenToMemoryStreamKey;
static VALUE
osx_NSStreamDataWrittenToMemoryStreamKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSStreamDataWrittenToMemoryStreamKey, "NSStreamDataWrittenToMemoryStreamKey", nil);
}

// NSString * const NSStreamFileCurrentOffsetKey;
static VALUE
osx_NSStreamFileCurrentOffsetKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSStreamFileCurrentOffsetKey, "NSStreamFileCurrentOffsetKey", nil);
}

// NSString * const NSStreamSocketSSLErrorDomain;
static VALUE
osx_NSStreamSocketSSLErrorDomain(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSStreamSocketSSLErrorDomain, "NSStreamSocketSSLErrorDomain", nil);
}

// NSString * const NSStreamSOCKSErrorDomain;
static VALUE
osx_NSStreamSOCKSErrorDomain(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSStreamSOCKSErrorDomain, "NSStreamSOCKSErrorDomain", nil);
}

void init_NSStream(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSStreamStatusNotOpen", INT2NUM(NSStreamStatusNotOpen));
  rb_define_const(mOSX, "NSStreamStatusOpening", INT2NUM(NSStreamStatusOpening));
  rb_define_const(mOSX, "NSStreamStatusOpen", INT2NUM(NSStreamStatusOpen));
  rb_define_const(mOSX, "NSStreamStatusReading", INT2NUM(NSStreamStatusReading));
  rb_define_const(mOSX, "NSStreamStatusWriting", INT2NUM(NSStreamStatusWriting));
  rb_define_const(mOSX, "NSStreamStatusAtEnd", INT2NUM(NSStreamStatusAtEnd));
  rb_define_const(mOSX, "NSStreamStatusClosed", INT2NUM(NSStreamStatusClosed));
  rb_define_const(mOSX, "NSStreamStatusError", INT2NUM(NSStreamStatusError));
  rb_define_const(mOSX, "NSStreamEventNone", INT2NUM(NSStreamEventNone));
  rb_define_const(mOSX, "NSStreamEventOpenCompleted", INT2NUM(NSStreamEventOpenCompleted));
  rb_define_const(mOSX, "NSStreamEventHasBytesAvailable", INT2NUM(NSStreamEventHasBytesAvailable));
  rb_define_const(mOSX, "NSStreamEventHasSpaceAvailable", INT2NUM(NSStreamEventHasSpaceAvailable));
  rb_define_const(mOSX, "NSStreamEventErrorOccurred", INT2NUM(NSStreamEventErrorOccurred));
  rb_define_const(mOSX, "NSStreamEventEndEncountered", INT2NUM(NSStreamEventEndEncountered));

  /**** constants ****/
  rb_define_module_function(mOSX, "NSStreamSocketSecurityLevelKey", osx_NSStreamSocketSecurityLevelKey, 0);
  rb_define_module_function(mOSX, "NSStreamSocketSecurityLevelNone", osx_NSStreamSocketSecurityLevelNone, 0);
  rb_define_module_function(mOSX, "NSStreamSocketSecurityLevelSSLv2", osx_NSStreamSocketSecurityLevelSSLv2, 0);
  rb_define_module_function(mOSX, "NSStreamSocketSecurityLevelSSLv3", osx_NSStreamSocketSecurityLevelSSLv3, 0);
  rb_define_module_function(mOSX, "NSStreamSocketSecurityLevelTLSv1", osx_NSStreamSocketSecurityLevelTLSv1, 0);
  rb_define_module_function(mOSX, "NSStreamSocketSecurityLevelNegotiatedSSL", osx_NSStreamSocketSecurityLevelNegotiatedSSL, 0);
  rb_define_module_function(mOSX, "NSStreamSOCKSProxyConfigurationKey", osx_NSStreamSOCKSProxyConfigurationKey, 0);
  rb_define_module_function(mOSX, "NSStreamSOCKSProxyHostKey", osx_NSStreamSOCKSProxyHostKey, 0);
  rb_define_module_function(mOSX, "NSStreamSOCKSProxyPortKey", osx_NSStreamSOCKSProxyPortKey, 0);
  rb_define_module_function(mOSX, "NSStreamSOCKSProxyVersionKey", osx_NSStreamSOCKSProxyVersionKey, 0);
  rb_define_module_function(mOSX, "NSStreamSOCKSProxyUserKey", osx_NSStreamSOCKSProxyUserKey, 0);
  rb_define_module_function(mOSX, "NSStreamSOCKSProxyPasswordKey", osx_NSStreamSOCKSProxyPasswordKey, 0);
  rb_define_module_function(mOSX, "NSStreamSOCKSProxyVersion4", osx_NSStreamSOCKSProxyVersion4, 0);
  rb_define_module_function(mOSX, "NSStreamSOCKSProxyVersion5", osx_NSStreamSOCKSProxyVersion5, 0);
  rb_define_module_function(mOSX, "NSStreamDataWrittenToMemoryStreamKey", osx_NSStreamDataWrittenToMemoryStreamKey, 0);
  rb_define_module_function(mOSX, "NSStreamFileCurrentOffsetKey", osx_NSStreamFileCurrentOffsetKey, 0);
  rb_define_module_function(mOSX, "NSStreamSocketSSLErrorDomain", osx_NSStreamSocketSSLErrorDomain, 0);
  rb_define_module_function(mOSX, "NSStreamSOCKSErrorDomain", osx_NSStreamSOCKSErrorDomain, 0);
}
  /**** constants ****/
// NSString * const NSParseErrorException;
static VALUE
osx_NSParseErrorException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSParseErrorException, "NSParseErrorException", nil);
}

// NSString * const NSCharacterConversionException;
static VALUE
osx_NSCharacterConversionException(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSCharacterConversionException, "NSCharacterConversionException", nil);
}

// void *_NSConstantStringClassReference;
static VALUE
osx__NSConstantStringClassReference(VALUE mdl)
{
  return nsresult_to_rbresult(_PRIV_C_PTR, &_NSConstantStringClassReference, "_NSConstantStringClassReference", nil);
}

void init_NSString(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSCaseInsensitiveSearch", INT2NUM(NSCaseInsensitiveSearch));
  rb_define_const(mOSX, "NSLiteralSearch", INT2NUM(NSLiteralSearch));
  rb_define_const(mOSX, "NSBackwardsSearch", INT2NUM(NSBackwardsSearch));
  rb_define_const(mOSX, "NSAnchoredSearch", INT2NUM(NSAnchoredSearch));
  rb_define_const(mOSX, "NSNumericSearch", INT2NUM(NSNumericSearch));
  rb_define_const(mOSX, "NSDiacriticInsensitiveSearch", INT2NUM(NSDiacriticInsensitiveSearch));
  rb_define_const(mOSX, "NSWidthInsensitiveSearch", INT2NUM(NSWidthInsensitiveSearch));
  rb_define_const(mOSX, "NSForcedOrderingSearch", INT2NUM(NSForcedOrderingSearch));
  rb_define_const(mOSX, "NSASCIIStringEncoding", INT2NUM(NSASCIIStringEncoding));
  rb_define_const(mOSX, "NSNEXTSTEPStringEncoding", INT2NUM(NSNEXTSTEPStringEncoding));
  rb_define_const(mOSX, "NSJapaneseEUCStringEncoding", INT2NUM(NSJapaneseEUCStringEncoding));
  rb_define_const(mOSX, "NSUTF8StringEncoding", INT2NUM(NSUTF8StringEncoding));
  rb_define_const(mOSX, "NSISOLatin1StringEncoding", INT2NUM(NSISOLatin1StringEncoding));
  rb_define_const(mOSX, "NSSymbolStringEncoding", INT2NUM(NSSymbolStringEncoding));
  rb_define_const(mOSX, "NSNonLossyASCIIStringEncoding", INT2NUM(NSNonLossyASCIIStringEncoding));
  rb_define_const(mOSX, "NSShiftJISStringEncoding", INT2NUM(NSShiftJISStringEncoding));
  rb_define_const(mOSX, "NSISOLatin2StringEncoding", INT2NUM(NSISOLatin2StringEncoding));
  rb_define_const(mOSX, "NSUnicodeStringEncoding", INT2NUM(NSUnicodeStringEncoding));
  rb_define_const(mOSX, "NSWindowsCP1251StringEncoding", INT2NUM(NSWindowsCP1251StringEncoding));
  rb_define_const(mOSX, "NSWindowsCP1252StringEncoding", INT2NUM(NSWindowsCP1252StringEncoding));
  rb_define_const(mOSX, "NSWindowsCP1253StringEncoding", INT2NUM(NSWindowsCP1253StringEncoding));
  rb_define_const(mOSX, "NSWindowsCP1254StringEncoding", INT2NUM(NSWindowsCP1254StringEncoding));
  rb_define_const(mOSX, "NSWindowsCP1250StringEncoding", INT2NUM(NSWindowsCP1250StringEncoding));
  rb_define_const(mOSX, "NSISO2022JPStringEncoding", INT2NUM(NSISO2022JPStringEncoding));
  rb_define_const(mOSX, "NSMacOSRomanStringEncoding", INT2NUM(NSMacOSRomanStringEncoding));
  rb_define_const(mOSX, "NSUTF16StringEncoding", INT2NUM(NSUTF16StringEncoding));
  rb_define_const(mOSX, "NSUTF16BigEndianStringEncoding", INT2NUM(NSUTF16BigEndianStringEncoding));
  rb_define_const(mOSX, "NSUTF16LittleEndianStringEncoding", INT2NUM(NSUTF16LittleEndianStringEncoding));
  rb_define_const(mOSX, "NSUTF32StringEncoding", INT2NUM(NSUTF32StringEncoding));
  rb_define_const(mOSX, "NSUTF32BigEndianStringEncoding", INT2NUM(NSUTF32BigEndianStringEncoding));
  rb_define_const(mOSX, "NSUTF32LittleEndianStringEncoding", INT2NUM(NSUTF32LittleEndianStringEncoding));
  rb_define_const(mOSX, "NSStringEncodingConversionAllowLossy", INT2NUM(NSStringEncodingConversionAllowLossy));
  rb_define_const(mOSX, "NSStringEncodingConversionExternalRepresentation", INT2NUM(NSStringEncodingConversionExternalRepresentation));

  /**** constants ****/
  rb_define_module_function(mOSX, "NSParseErrorException", osx_NSParseErrorException, 0);
  rb_define_module_function(mOSX, "NSCharacterConversionException", osx_NSCharacterConversionException, 0);
  rb_define_module_function(mOSX, "_NSConstantStringClassReference", osx__NSConstantStringClassReference, 0);
}
  /**** constants ****/
// NSString * const NSWillBecomeMultiThreadedNotification;
static VALUE
osx_NSWillBecomeMultiThreadedNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSWillBecomeMultiThreadedNotification, "NSWillBecomeMultiThreadedNotification", nil);
}

// NSString * const NSDidBecomeSingleThreadedNotification;
static VALUE
osx_NSDidBecomeSingleThreadedNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSDidBecomeSingleThreadedNotification, "NSDidBecomeSingleThreadedNotification", nil);
}

// NSString * const NSThreadWillExitNotification;
static VALUE
osx_NSThreadWillExitNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSThreadWillExitNotification, "NSThreadWillExitNotification", nil);
}

void init_NSThread(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "NSWillBecomeMultiThreadedNotification", osx_NSWillBecomeMultiThreadedNotification, 0);
  rb_define_module_function(mOSX, "NSDidBecomeSingleThreadedNotification", osx_NSDidBecomeSingleThreadedNotification, 0);
  rb_define_module_function(mOSX, "NSThreadWillExitNotification", osx_NSThreadWillExitNotification, 0);
}
  /**** constants ****/
// NSString * const NSSystemTimeZoneDidChangeNotification;
static VALUE
osx_NSSystemTimeZoneDidChangeNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSSystemTimeZoneDidChangeNotification, "NSSystemTimeZoneDidChangeNotification", nil);
}

void init_NSTimeZone(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSTimeZoneNameStyleStandard", INT2NUM(NSTimeZoneNameStyleStandard));
  rb_define_const(mOSX, "NSTimeZoneNameStyleShortStandard", INT2NUM(NSTimeZoneNameStyleShortStandard));
  rb_define_const(mOSX, "NSTimeZoneNameStyleDaylightSaving", INT2NUM(NSTimeZoneNameStyleDaylightSaving));
  rb_define_const(mOSX, "NSTimeZoneNameStyleShortDaylightSaving", INT2NUM(NSTimeZoneNameStyleShortDaylightSaving));

  /**** constants ****/
  rb_define_module_function(mOSX, "NSSystemTimeZoneDidChangeNotification", osx_NSSystemTimeZoneDidChangeNotification, 0);
}
  /**** constants ****/
// NSString *NSURLFileScheme;
static VALUE
osx_NSURLFileScheme(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSURLFileScheme, "NSURLFileScheme", nil);
}

void init_NSURL(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "NSURLFileScheme", osx_NSURLFileScheme, 0);
}
  /**** constants ****/
// NSString * const NSGlobalDomain;
static VALUE
osx_NSGlobalDomain(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSGlobalDomain, "NSGlobalDomain", nil);
}

// NSString * const NSArgumentDomain;
static VALUE
osx_NSArgumentDomain(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSArgumentDomain, "NSArgumentDomain", nil);
}

// NSString * const NSRegistrationDomain;
static VALUE
osx_NSRegistrationDomain(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSRegistrationDomain, "NSRegistrationDomain", nil);
}

// NSString * const NSUserDefaultsDidChangeNotification;
static VALUE
osx_NSUserDefaultsDidChangeNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSUserDefaultsDidChangeNotification, "NSUserDefaultsDidChangeNotification", nil);
}

void init_NSUserDefaults(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "NSGlobalDomain", osx_NSGlobalDomain, 0);
  rb_define_module_function(mOSX, "NSArgumentDomain", osx_NSArgumentDomain, 0);
  rb_define_module_function(mOSX, "NSRegistrationDomain", osx_NSRegistrationDomain, 0);
  rb_define_module_function(mOSX, "NSUserDefaultsDidChangeNotification", osx_NSUserDefaultsDidChangeNotification, 0);
}
  /**** functions ****/
// NSZone *NSDefaultMallocZone(void);
static VALUE
osx_NSDefaultMallocZone(VALUE mdl)
{
  NSZone * ns_result = NSDefaultMallocZone();
  return nsresult_to_rbresult(_PRIV_C_PTR, &ns_result, "NSDefaultMallocZone", nil);
}

// NSZone *NSCreateZone(NSUInteger startSize, NSUInteger granularity, BOOL canFree);
static VALUE
osx_NSCreateZone(VALUE mdl, VALUE a0, VALUE a1, VALUE a2)
{
  rb_notimplement();
}

// void NSRecycleZone(NSZone *zone);
static VALUE
osx_NSRecycleZone(VALUE mdl, VALUE a0)
{

  NSZone * ns_a0;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _PRIV_C_PTR, &ns_a0, "NSRecycleZone", pool, 0);

NS_DURING
  NSRecycleZone(ns_a0);
NS_HANDLER
  excp = oc_err_new ("NSRecycleZone", localException);
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

// void NSSetZoneName(NSZone *zone, NSString *name);
static VALUE
osx_NSSetZoneName(VALUE mdl, VALUE a0, VALUE a1)
{

  NSZone * ns_a0;
  NSString * ns_a1;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _PRIV_C_PTR, &ns_a0, "NSSetZoneName", pool, 0);
  /* a1 */
  rbarg_to_nsarg(a1, _C_ID, &ns_a1, "NSSetZoneName", pool, 1);

NS_DURING
  NSSetZoneName(ns_a0, ns_a1);
NS_HANDLER
  excp = oc_err_new ("NSSetZoneName", localException);
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

// NSString *NSZoneName(NSZone *zone);
static VALUE
osx_NSZoneName(VALUE mdl, VALUE a0)
{
  NSString * ns_result;

  NSZone * ns_a0;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _PRIV_C_PTR, &ns_a0, "NSZoneName", pool, 0);

NS_DURING
  ns_result = NSZoneName(ns_a0);
NS_HANDLER
  excp = oc_err_new ("NSZoneName", localException);
NS_ENDHANDLER
  if (excp != Qnil) {
    [pool release];
    rb_exc_raise (excp);
    return Qnil;
  }

  rb_result = nsresult_to_rbresult(_C_ID, &ns_result, "NSZoneName", pool);
  [pool release];
  return rb_result;
}

// NSZone *NSZoneFromPointer(void *ptr);
static VALUE
osx_NSZoneFromPointer(VALUE mdl, VALUE a0)
{
  NSZone * ns_result;

  void * ns_a0;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _PRIV_C_PTR, &ns_a0, "NSZoneFromPointer", pool, 0);

NS_DURING
  ns_result = NSZoneFromPointer(ns_a0);
NS_HANDLER
  excp = oc_err_new ("NSZoneFromPointer", localException);
NS_ENDHANDLER
  if (excp != Qnil) {
    [pool release];
    rb_exc_raise (excp);
    return Qnil;
  }

  rb_result = nsresult_to_rbresult(_PRIV_C_PTR, &ns_result, "NSZoneFromPointer", pool);
  [pool release];
  return rb_result;
}

// void *NSZoneMalloc(NSZone *zone, NSUInteger size);
static VALUE
osx_NSZoneMalloc(VALUE mdl, VALUE a0, VALUE a1)
{
  rb_notimplement();
}

// void *NSZoneCalloc(NSZone *zone, NSUInteger numElems, NSUInteger byteSize);
static VALUE
osx_NSZoneCalloc(VALUE mdl, VALUE a0, VALUE a1, VALUE a2)
{
  rb_notimplement();
}

// void *NSZoneRealloc(NSZone *zone, void *ptr, NSUInteger size);
static VALUE
osx_NSZoneRealloc(VALUE mdl, VALUE a0, VALUE a1, VALUE a2)
{
  rb_notimplement();
}

// void NSZoneFree(NSZone *zone, void *ptr);
static VALUE
osx_NSZoneFree(VALUE mdl, VALUE a0, VALUE a1)
{

  NSZone * ns_a0;
  void * ns_a1;

  VALUE excp = Qnil;
  VALUE rb_result;
  id pool = [[NSAutoreleasePool alloc] init];
  /* a0 */
  rbarg_to_nsarg(a0, _PRIV_C_PTR, &ns_a0, "NSZoneFree", pool, 0);
  /* a1 */
  rbarg_to_nsarg(a1, _PRIV_C_PTR, &ns_a1, "NSZoneFree", pool, 1);

NS_DURING
  NSZoneFree(ns_a0, ns_a1);
NS_HANDLER
  excp = oc_err_new ("NSZoneFree", localException);
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

// NSUInteger NSPageSize(void);
static VALUE
osx_NSPageSize(VALUE mdl)
{
  rb_notimplement();
}

// NSUInteger NSLogPageSize(void);
static VALUE
osx_NSLogPageSize(VALUE mdl)
{
  rb_notimplement();
}

// NSUInteger NSRoundUpToMultipleOfPageSize(NSUInteger bytes);
static VALUE
osx_NSRoundUpToMultipleOfPageSize(VALUE mdl, VALUE a0)
{
  rb_notimplement();
}

// NSUInteger NSRoundDownToMultipleOfPageSize(NSUInteger bytes);
static VALUE
osx_NSRoundDownToMultipleOfPageSize(VALUE mdl, VALUE a0)
{
  rb_notimplement();
}

// void *NSAllocateMemoryPages(NSUInteger bytes);
static VALUE
osx_NSAllocateMemoryPages(VALUE mdl, VALUE a0)
{
  rb_notimplement();
}

// void NSDeallocateMemoryPages(void *ptr, NSUInteger bytes);
static VALUE
osx_NSDeallocateMemoryPages(VALUE mdl, VALUE a0, VALUE a1)
{
  rb_notimplement();
}

// void NSCopyMemoryPages(const void *source, void *dest, NSUInteger bytes);
static VALUE
osx_NSCopyMemoryPages(VALUE mdl, VALUE a0, VALUE a1, VALUE a2)
{
  rb_notimplement();
}

// NSUInteger NSRealMemoryAvailable(void);
static VALUE
osx_NSRealMemoryAvailable(VALUE mdl)
{
  rb_notimplement();
}

void init_NSZone(VALUE mOSX)
{
  /**** functions ****/
  rb_define_module_function(mOSX, "NSDefaultMallocZone", osx_NSDefaultMallocZone, 0);
  rb_define_module_function(mOSX, "NSCreateZone", osx_NSCreateZone, 3);
  rb_define_module_function(mOSX, "NSRecycleZone", osx_NSRecycleZone, 1);
  rb_define_module_function(mOSX, "NSSetZoneName", osx_NSSetZoneName, 2);
  rb_define_module_function(mOSX, "NSZoneName", osx_NSZoneName, 1);
  rb_define_module_function(mOSX, "NSZoneFromPointer", osx_NSZoneFromPointer, 1);
  rb_define_module_function(mOSX, "NSZoneMalloc", osx_NSZoneMalloc, 2);
  rb_define_module_function(mOSX, "NSZoneCalloc", osx_NSZoneCalloc, 3);
  rb_define_module_function(mOSX, "NSZoneRealloc", osx_NSZoneRealloc, 3);
  rb_define_module_function(mOSX, "NSZoneFree", osx_NSZoneFree, 2);
  rb_define_module_function(mOSX, "NSPageSize", osx_NSPageSize, 0);
  rb_define_module_function(mOSX, "NSLogPageSize", osx_NSLogPageSize, 0);
  rb_define_module_function(mOSX, "NSRoundUpToMultipleOfPageSize", osx_NSRoundUpToMultipleOfPageSize, 1);
  rb_define_module_function(mOSX, "NSRoundDownToMultipleOfPageSize", osx_NSRoundDownToMultipleOfPageSize, 1);
  rb_define_module_function(mOSX, "NSAllocateMemoryPages", osx_NSAllocateMemoryPages, 1);
  rb_define_module_function(mOSX, "NSDeallocateMemoryPages", osx_NSDeallocateMemoryPages, 2);
  rb_define_module_function(mOSX, "NSCopyMemoryPages", osx_NSCopyMemoryPages, 3);
  rb_define_module_function(mOSX, "NSRealMemoryAvailable", osx_NSRealMemoryAvailable, 0);
}
void init_FoundationErrors(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSFileNoSuchFileError", INT2NUM(NSFileNoSuchFileError));
  rb_define_const(mOSX, "NSFileLockingError", INT2NUM(NSFileLockingError));
  rb_define_const(mOSX, "NSFileReadUnknownError", INT2NUM(NSFileReadUnknownError));
  rb_define_const(mOSX, "NSFileReadNoPermissionError", INT2NUM(NSFileReadNoPermissionError));
  rb_define_const(mOSX, "NSFileReadInvalidFileNameError", INT2NUM(NSFileReadInvalidFileNameError));
  rb_define_const(mOSX, "NSFileReadCorruptFileError", INT2NUM(NSFileReadCorruptFileError));
  rb_define_const(mOSX, "NSFileReadNoSuchFileError", INT2NUM(NSFileReadNoSuchFileError));
  rb_define_const(mOSX, "NSFileReadInapplicableStringEncodingError", INT2NUM(NSFileReadInapplicableStringEncodingError));
  rb_define_const(mOSX, "NSFileReadUnsupportedSchemeError", INT2NUM(NSFileReadUnsupportedSchemeError));
  rb_define_const(mOSX, "NSFileReadTooLargeError", INT2NUM(NSFileReadTooLargeError));
  rb_define_const(mOSX, "NSFileReadUnknownStringEncodingError", INT2NUM(NSFileReadUnknownStringEncodingError));
  rb_define_const(mOSX, "NSFileWriteUnknownError", INT2NUM(NSFileWriteUnknownError));
  rb_define_const(mOSX, "NSFileWriteNoPermissionError", INT2NUM(NSFileWriteNoPermissionError));
  rb_define_const(mOSX, "NSFileWriteInvalidFileNameError", INT2NUM(NSFileWriteInvalidFileNameError));
  rb_define_const(mOSX, "NSFileWriteInapplicableStringEncodingError", INT2NUM(NSFileWriteInapplicableStringEncodingError));
  rb_define_const(mOSX, "NSFileWriteUnsupportedSchemeError", INT2NUM(NSFileWriteUnsupportedSchemeError));
  rb_define_const(mOSX, "NSFileWriteOutOfSpaceError", INT2NUM(NSFileWriteOutOfSpaceError));
  rb_define_const(mOSX, "NSKeyValueValidationError", INT2NUM(NSKeyValueValidationError));
  rb_define_const(mOSX, "NSFormattingError", INT2NUM(NSFormattingError));
  rb_define_const(mOSX, "NSUserCancelledError", INT2NUM(NSUserCancelledError));
  rb_define_const(mOSX, "NSExecutableNotLoadableError", INT2NUM(NSExecutableNotLoadableError));
  rb_define_const(mOSX, "NSExecutableArchitectureMismatchError", INT2NUM(NSExecutableArchitectureMismatchError));
  rb_define_const(mOSX, "NSExecutableRuntimeMismatchError", INT2NUM(NSExecutableRuntimeMismatchError));
  rb_define_const(mOSX, "NSExecutableLoadError", INT2NUM(NSExecutableLoadError));
  rb_define_const(mOSX, "NSExecutableLinkError", INT2NUM(NSExecutableLinkError));
  rb_define_const(mOSX, "NSFileErrorMinimum", INT2NUM(NSFileErrorMinimum));
  rb_define_const(mOSX, "NSFileErrorMaximum", INT2NUM(NSFileErrorMaximum));
  rb_define_const(mOSX, "NSValidationErrorMinimum", INT2NUM(NSValidationErrorMinimum));
  rb_define_const(mOSX, "NSValidationErrorMaximum", INT2NUM(NSValidationErrorMaximum));
  rb_define_const(mOSX, "NSExecutableErrorMinimum", INT2NUM(NSExecutableErrorMinimum));
  rb_define_const(mOSX, "NSExecutableErrorMaximum", INT2NUM(NSExecutableErrorMaximum));
  rb_define_const(mOSX, "NSFormattingErrorMinimum", INT2NUM(NSFormattingErrorMinimum));
  rb_define_const(mOSX, "NSFormattingErrorMaximum", INT2NUM(NSFormattingErrorMaximum));

}
  /**** constants ****/
// NSString * const NSHTTPCookieName;
static VALUE
osx_NSHTTPCookieName(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSHTTPCookieName, "NSHTTPCookieName", nil);
}

// NSString * const NSHTTPCookieValue;
static VALUE
osx_NSHTTPCookieValue(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSHTTPCookieValue, "NSHTTPCookieValue", nil);
}

// NSString * const NSHTTPCookieOriginURL;
static VALUE
osx_NSHTTPCookieOriginURL(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSHTTPCookieOriginURL, "NSHTTPCookieOriginURL", nil);
}

// NSString * const NSHTTPCookieVersion;
static VALUE
osx_NSHTTPCookieVersion(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSHTTPCookieVersion, "NSHTTPCookieVersion", nil);
}

// NSString * const NSHTTPCookieDomain;
static VALUE
osx_NSHTTPCookieDomain(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSHTTPCookieDomain, "NSHTTPCookieDomain", nil);
}

// NSString * const NSHTTPCookiePath;
static VALUE
osx_NSHTTPCookiePath(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSHTTPCookiePath, "NSHTTPCookiePath", nil);
}

// NSString * const NSHTTPCookieSecure;
static VALUE
osx_NSHTTPCookieSecure(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSHTTPCookieSecure, "NSHTTPCookieSecure", nil);
}

// NSString * const NSHTTPCookieExpires;
static VALUE
osx_NSHTTPCookieExpires(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSHTTPCookieExpires, "NSHTTPCookieExpires", nil);
}

// NSString * const NSHTTPCookieComment;
static VALUE
osx_NSHTTPCookieComment(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSHTTPCookieComment, "NSHTTPCookieComment", nil);
}

// NSString * const NSHTTPCookieCommentURL;
static VALUE
osx_NSHTTPCookieCommentURL(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSHTTPCookieCommentURL, "NSHTTPCookieCommentURL", nil);
}

// NSString * const NSHTTPCookieDiscard;
static VALUE
osx_NSHTTPCookieDiscard(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSHTTPCookieDiscard, "NSHTTPCookieDiscard", nil);
}

// NSString * const NSHTTPCookieMaximumAge;
static VALUE
osx_NSHTTPCookieMaximumAge(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSHTTPCookieMaximumAge, "NSHTTPCookieMaximumAge", nil);
}

// NSString * const NSHTTPCookiePort;
static VALUE
osx_NSHTTPCookiePort(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSHTTPCookiePort, "NSHTTPCookiePort", nil);
}

void init_NSHTTPCookie(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "NSHTTPCookieName", osx_NSHTTPCookieName, 0);
  rb_define_module_function(mOSX, "NSHTTPCookieValue", osx_NSHTTPCookieValue, 0);
  rb_define_module_function(mOSX, "NSHTTPCookieOriginURL", osx_NSHTTPCookieOriginURL, 0);
  rb_define_module_function(mOSX, "NSHTTPCookieVersion", osx_NSHTTPCookieVersion, 0);
  rb_define_module_function(mOSX, "NSHTTPCookieDomain", osx_NSHTTPCookieDomain, 0);
  rb_define_module_function(mOSX, "NSHTTPCookiePath", osx_NSHTTPCookiePath, 0);
  rb_define_module_function(mOSX, "NSHTTPCookieSecure", osx_NSHTTPCookieSecure, 0);
  rb_define_module_function(mOSX, "NSHTTPCookieExpires", osx_NSHTTPCookieExpires, 0);
  rb_define_module_function(mOSX, "NSHTTPCookieComment", osx_NSHTTPCookieComment, 0);
  rb_define_module_function(mOSX, "NSHTTPCookieCommentURL", osx_NSHTTPCookieCommentURL, 0);
  rb_define_module_function(mOSX, "NSHTTPCookieDiscard", osx_NSHTTPCookieDiscard, 0);
  rb_define_module_function(mOSX, "NSHTTPCookieMaximumAge", osx_NSHTTPCookieMaximumAge, 0);
  rb_define_module_function(mOSX, "NSHTTPCookiePort", osx_NSHTTPCookiePort, 0);
}
  /**** constants ****/
// NSString * const NSHTTPCookieManagerAcceptPolicyChangedNotification;
static VALUE
osx_NSHTTPCookieManagerAcceptPolicyChangedNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSHTTPCookieManagerAcceptPolicyChangedNotification, "NSHTTPCookieManagerAcceptPolicyChangedNotification", nil);
}

// NSString * const NSHTTPCookieManagerCookiesChangedNotification;
static VALUE
osx_NSHTTPCookieManagerCookiesChangedNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSHTTPCookieManagerCookiesChangedNotification, "NSHTTPCookieManagerCookiesChangedNotification", nil);
}

void init_NSHTTPCookieStorage(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSHTTPCookieAcceptPolicyAlways", INT2NUM(NSHTTPCookieAcceptPolicyAlways));
  rb_define_const(mOSX, "NSHTTPCookieAcceptPolicyNever", INT2NUM(NSHTTPCookieAcceptPolicyNever));
  rb_define_const(mOSX, "NSHTTPCookieAcceptPolicyOnlyFromMainDocumentDomain", INT2NUM(NSHTTPCookieAcceptPolicyOnlyFromMainDocumentDomain));

  /**** constants ****/
  rb_define_module_function(mOSX, "NSHTTPCookieManagerAcceptPolicyChangedNotification", osx_NSHTTPCookieManagerAcceptPolicyChangedNotification, 0);
  rb_define_module_function(mOSX, "NSHTTPCookieManagerCookiesChangedNotification", osx_NSHTTPCookieManagerCookiesChangedNotification, 0);
}
  /**** constants ****/
// NSString * const NSNetServicesErrorCode;
static VALUE
osx_NSNetServicesErrorCode(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSNetServicesErrorCode, "NSNetServicesErrorCode", nil);
}

// NSString * const NSNetServicesErrorDomain;
static VALUE
osx_NSNetServicesErrorDomain(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSNetServicesErrorDomain, "NSNetServicesErrorDomain", nil);
}

void init_NSNetServices(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSNetServicesUnknownError", INT2NUM(NSNetServicesUnknownError));
  rb_define_const(mOSX, "NSNetServicesCollisionError", INT2NUM(NSNetServicesCollisionError));
  rb_define_const(mOSX, "NSNetServicesNotFoundError", INT2NUM(NSNetServicesNotFoundError));
  rb_define_const(mOSX, "NSNetServicesActivityInProgress", INT2NUM(NSNetServicesActivityInProgress));
  rb_define_const(mOSX, "NSNetServicesBadArgumentError", INT2NUM(NSNetServicesBadArgumentError));
  rb_define_const(mOSX, "NSNetServicesCancelledError", INT2NUM(NSNetServicesCancelledError));
  rb_define_const(mOSX, "NSNetServicesInvalidError", INT2NUM(NSNetServicesInvalidError));
  rb_define_const(mOSX, "NSNetServicesTimeoutError", INT2NUM(NSNetServicesTimeoutError));
  rb_define_const(mOSX, "NSNetServiceNoAutoRename", INT2NUM(NSNetServiceNoAutoRename));

  /**** constants ****/
  rb_define_module_function(mOSX, "NSNetServicesErrorCode", osx_NSNetServicesErrorCode, 0);
  rb_define_module_function(mOSX, "NSNetServicesErrorDomain", osx_NSNetServicesErrorDomain, 0);
}
void init_NSURLCredential(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSURLCredentialPersistenceNone", INT2NUM(NSURLCredentialPersistenceNone));
  rb_define_const(mOSX, "NSURLCredentialPersistenceForSession", INT2NUM(NSURLCredentialPersistenceForSession));
  rb_define_const(mOSX, "NSURLCredentialPersistencePermanent", INT2NUM(NSURLCredentialPersistencePermanent));

}
  /**** constants ****/
// NSString *const NSURLCredentialStorageChangedNotification;
static VALUE
osx_NSURLCredentialStorageChangedNotification(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSURLCredentialStorageChangedNotification, "NSURLCredentialStorageChangedNotification", nil);
}

void init_NSURLCredentialStorage(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "NSURLCredentialStorageChangedNotification", osx_NSURLCredentialStorageChangedNotification, 0);
}
  /**** constants ****/
// NSString * const NSURLErrorDomain;
static VALUE
osx_NSURLErrorDomain(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSURLErrorDomain, "NSURLErrorDomain", nil);
}

// NSString * const NSErrorFailingURLStringKey;
static VALUE
osx_NSErrorFailingURLStringKey(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSErrorFailingURLStringKey, "NSErrorFailingURLStringKey", nil);
}

void init_NSURLError(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "NSURLErrorDomain", osx_NSURLErrorDomain, 0);
  rb_define_module_function(mOSX, "NSErrorFailingURLStringKey", osx_NSErrorFailingURLStringKey, 0);
}
  /**** constants ****/
// NSString * const NSURLProtectionSpaceHTTPProxy;
static VALUE
osx_NSURLProtectionSpaceHTTPProxy(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSURLProtectionSpaceHTTPProxy, "NSURLProtectionSpaceHTTPProxy", nil);
}

// NSString * const NSURLProtectionSpaceHTTPSProxy;
static VALUE
osx_NSURLProtectionSpaceHTTPSProxy(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSURLProtectionSpaceHTTPSProxy, "NSURLProtectionSpaceHTTPSProxy", nil);
}

// NSString * const NSURLProtectionSpaceFTPProxy;
static VALUE
osx_NSURLProtectionSpaceFTPProxy(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSURLProtectionSpaceFTPProxy, "NSURLProtectionSpaceFTPProxy", nil);
}

// NSString * const NSURLProtectionSpaceSOCKSProxy;
static VALUE
osx_NSURLProtectionSpaceSOCKSProxy(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSURLProtectionSpaceSOCKSProxy, "NSURLProtectionSpaceSOCKSProxy", nil);
}

// NSString * const NSURLAuthenticationMethodDefault;
static VALUE
osx_NSURLAuthenticationMethodDefault(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSURLAuthenticationMethodDefault, "NSURLAuthenticationMethodDefault", nil);
}

// NSString * const NSURLAuthenticationMethodHTTPBasic;
static VALUE
osx_NSURLAuthenticationMethodHTTPBasic(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSURLAuthenticationMethodHTTPBasic, "NSURLAuthenticationMethodHTTPBasic", nil);
}

// NSString * const NSURLAuthenticationMethodHTTPDigest;
static VALUE
osx_NSURLAuthenticationMethodHTTPDigest(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSURLAuthenticationMethodHTTPDigest, "NSURLAuthenticationMethodHTTPDigest", nil);
}

// NSString * const NSURLAuthenticationMethodHTMLForm;
static VALUE
osx_NSURLAuthenticationMethodHTMLForm(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSURLAuthenticationMethodHTMLForm, "NSURLAuthenticationMethodHTMLForm", nil);
}

void init_NSURLProtectionSpace(VALUE mOSX)
{
  /**** constants ****/
  rb_define_module_function(mOSX, "NSURLProtectionSpaceHTTPProxy", osx_NSURLProtectionSpaceHTTPProxy, 0);
  rb_define_module_function(mOSX, "NSURLProtectionSpaceHTTPSProxy", osx_NSURLProtectionSpaceHTTPSProxy, 0);
  rb_define_module_function(mOSX, "NSURLProtectionSpaceFTPProxy", osx_NSURLProtectionSpaceFTPProxy, 0);
  rb_define_module_function(mOSX, "NSURLProtectionSpaceSOCKSProxy", osx_NSURLProtectionSpaceSOCKSProxy, 0);
  rb_define_module_function(mOSX, "NSURLAuthenticationMethodDefault", osx_NSURLAuthenticationMethodDefault, 0);
  rb_define_module_function(mOSX, "NSURLAuthenticationMethodHTTPBasic", osx_NSURLAuthenticationMethodHTTPBasic, 0);
  rb_define_module_function(mOSX, "NSURLAuthenticationMethodHTTPDigest", osx_NSURLAuthenticationMethodHTTPDigest, 0);
  rb_define_module_function(mOSX, "NSURLAuthenticationMethodHTMLForm", osx_NSURLAuthenticationMethodHTMLForm, 0);
}
  /**** constants ****/
// NSString * const NSXMLParserErrorDomain;
static VALUE
osx_NSXMLParserErrorDomain(VALUE mdl)
{
  return nsresult_to_rbresult(_C_ID, &NSXMLParserErrorDomain, "NSXMLParserErrorDomain", nil);
}

void init_NSXMLParser(VALUE mOSX)
{
  /**** enums ****/
  rb_define_const(mOSX, "NSXMLParserInternalError", INT2NUM(NSXMLParserInternalError));
  rb_define_const(mOSX, "NSXMLParserOutOfMemoryError", INT2NUM(NSXMLParserOutOfMemoryError));
  rb_define_const(mOSX, "NSXMLParserDocumentStartError", INT2NUM(NSXMLParserDocumentStartError));
  rb_define_const(mOSX, "NSXMLParserEmptyDocumentError", INT2NUM(NSXMLParserEmptyDocumentError));
  rb_define_const(mOSX, "NSXMLParserPrematureDocumentEndError", INT2NUM(NSXMLParserPrematureDocumentEndError));
  rb_define_const(mOSX, "NSXMLParserInvalidHexCharacterRefError", INT2NUM(NSXMLParserInvalidHexCharacterRefError));
  rb_define_const(mOSX, "NSXMLParserInvalidDecimalCharacterRefError", INT2NUM(NSXMLParserInvalidDecimalCharacterRefError));
  rb_define_const(mOSX, "NSXMLParserInvalidCharacterRefError", INT2NUM(NSXMLParserInvalidCharacterRefError));
  rb_define_const(mOSX, "NSXMLParserInvalidCharacterError", INT2NUM(NSXMLParserInvalidCharacterError));
  rb_define_const(mOSX, "NSXMLParserCharacterRefAtEOFError", INT2NUM(NSXMLParserCharacterRefAtEOFError));
  rb_define_const(mOSX, "NSXMLParserCharacterRefInPrologError", INT2NUM(NSXMLParserCharacterRefInPrologError));
  rb_define_const(mOSX, "NSXMLParserCharacterRefInEpilogError", INT2NUM(NSXMLParserCharacterRefInEpilogError));
  rb_define_const(mOSX, "NSXMLParserCharacterRefInDTDError", INT2NUM(NSXMLParserCharacterRefInDTDError));
  rb_define_const(mOSX, "NSXMLParserEntityRefAtEOFError", INT2NUM(NSXMLParserEntityRefAtEOFError));
  rb_define_const(mOSX, "NSXMLParserEntityRefInPrologError", INT2NUM(NSXMLParserEntityRefInPrologError));
  rb_define_const(mOSX, "NSXMLParserEntityRefInEpilogError", INT2NUM(NSXMLParserEntityRefInEpilogError));
  rb_define_const(mOSX, "NSXMLParserEntityRefInDTDError", INT2NUM(NSXMLParserEntityRefInDTDError));
  rb_define_const(mOSX, "NSXMLParserParsedEntityRefAtEOFError", INT2NUM(NSXMLParserParsedEntityRefAtEOFError));
  rb_define_const(mOSX, "NSXMLParserParsedEntityRefInPrologError", INT2NUM(NSXMLParserParsedEntityRefInPrologError));
  rb_define_const(mOSX, "NSXMLParserParsedEntityRefInEpilogError", INT2NUM(NSXMLParserParsedEntityRefInEpilogError));
  rb_define_const(mOSX, "NSXMLParserParsedEntityRefInInternalSubsetError", INT2NUM(NSXMLParserParsedEntityRefInInternalSubsetError));
  rb_define_const(mOSX, "NSXMLParserEntityReferenceWithoutNameError", INT2NUM(NSXMLParserEntityReferenceWithoutNameError));
  rb_define_const(mOSX, "NSXMLParserEntityReferenceMissingSemiError", INT2NUM(NSXMLParserEntityReferenceMissingSemiError));
  rb_define_const(mOSX, "NSXMLParserParsedEntityRefNoNameError", INT2NUM(NSXMLParserParsedEntityRefNoNameError));
  rb_define_const(mOSX, "NSXMLParserParsedEntityRefMissingSemiError", INT2NUM(NSXMLParserParsedEntityRefMissingSemiError));
  rb_define_const(mOSX, "NSXMLParserUndeclaredEntityError", INT2NUM(NSXMLParserUndeclaredEntityError));
  rb_define_const(mOSX, "NSXMLParserUnparsedEntityError", INT2NUM(NSXMLParserUnparsedEntityError));
  rb_define_const(mOSX, "NSXMLParserEntityIsExternalError", INT2NUM(NSXMLParserEntityIsExternalError));
  rb_define_const(mOSX, "NSXMLParserEntityIsParameterError", INT2NUM(NSXMLParserEntityIsParameterError));
  rb_define_const(mOSX, "NSXMLParserUnknownEncodingError", INT2NUM(NSXMLParserUnknownEncodingError));
  rb_define_const(mOSX, "NSXMLParserEncodingNotSupportedError", INT2NUM(NSXMLParserEncodingNotSupportedError));
  rb_define_const(mOSX, "NSXMLParserStringNotStartedError", INT2NUM(NSXMLParserStringNotStartedError));
  rb_define_const(mOSX, "NSXMLParserStringNotClosedError", INT2NUM(NSXMLParserStringNotClosedError));
  rb_define_const(mOSX, "NSXMLParserNamespaceDeclarationError", INT2NUM(NSXMLParserNamespaceDeclarationError));
  rb_define_const(mOSX, "NSXMLParserEntityNotStartedError", INT2NUM(NSXMLParserEntityNotStartedError));
  rb_define_const(mOSX, "NSXMLParserEntityNotFinishedError", INT2NUM(NSXMLParserEntityNotFinishedError));
  rb_define_const(mOSX, "NSXMLParserLessThanSymbolInAttributeError", INT2NUM(NSXMLParserLessThanSymbolInAttributeError));
  rb_define_const(mOSX, "NSXMLParserAttributeNotStartedError", INT2NUM(NSXMLParserAttributeNotStartedError));
  rb_define_const(mOSX, "NSXMLParserAttributeNotFinishedError", INT2NUM(NSXMLParserAttributeNotFinishedError));
  rb_define_const(mOSX, "NSXMLParserAttributeHasNoValueError", INT2NUM(NSXMLParserAttributeHasNoValueError));
  rb_define_const(mOSX, "NSXMLParserAttributeRedefinedError", INT2NUM(NSXMLParserAttributeRedefinedError));
  rb_define_const(mOSX, "NSXMLParserLiteralNotStartedError", INT2NUM(NSXMLParserLiteralNotStartedError));
  rb_define_const(mOSX, "NSXMLParserLiteralNotFinishedError", INT2NUM(NSXMLParserLiteralNotFinishedError));
  rb_define_const(mOSX, "NSXMLParserCommentNotFinishedError", INT2NUM(NSXMLParserCommentNotFinishedError));
  rb_define_const(mOSX, "NSXMLParserProcessingInstructionNotStartedError", INT2NUM(NSXMLParserProcessingInstructionNotStartedError));
  rb_define_const(mOSX, "NSXMLParserProcessingInstructionNotFinishedError", INT2NUM(NSXMLParserProcessingInstructionNotFinishedError));
  rb_define_const(mOSX, "NSXMLParserNotationNotStartedError", INT2NUM(NSXMLParserNotationNotStartedError));
  rb_define_const(mOSX, "NSXMLParserNotationNotFinishedError", INT2NUM(NSXMLParserNotationNotFinishedError));
  rb_define_const(mOSX, "NSXMLParserAttributeListNotStartedError", INT2NUM(NSXMLParserAttributeListNotStartedError));
  rb_define_const(mOSX, "NSXMLParserAttributeListNotFinishedError", INT2NUM(NSXMLParserAttributeListNotFinishedError));
  rb_define_const(mOSX, "NSXMLParserMixedContentDeclNotStartedError", INT2NUM(NSXMLParserMixedContentDeclNotStartedError));
  rb_define_const(mOSX, "NSXMLParserMixedContentDeclNotFinishedError", INT2NUM(NSXMLParserMixedContentDeclNotFinishedError));
  rb_define_const(mOSX, "NSXMLParserElementContentDeclNotStartedError", INT2NUM(NSXMLParserElementContentDeclNotStartedError));
  rb_define_const(mOSX, "NSXMLParserElementContentDeclNotFinishedError", INT2NUM(NSXMLParserElementContentDeclNotFinishedError));
  rb_define_const(mOSX, "NSXMLParserXMLDeclNotStartedError", INT2NUM(NSXMLParserXMLDeclNotStartedError));
  rb_define_const(mOSX, "NSXMLParserXMLDeclNotFinishedError", INT2NUM(NSXMLParserXMLDeclNotFinishedError));
  rb_define_const(mOSX, "NSXMLParserConditionalSectionNotStartedError", INT2NUM(NSXMLParserConditionalSectionNotStartedError));
  rb_define_const(mOSX, "NSXMLParserConditionalSectionNotFinishedError", INT2NUM(NSXMLParserConditionalSectionNotFinishedError));
  rb_define_const(mOSX, "NSXMLParserExternalSubsetNotFinishedError", INT2NUM(NSXMLParserExternalSubsetNotFinishedError));
  rb_define_const(mOSX, "NSXMLParserDOCTYPEDeclNotFinishedError", INT2NUM(NSXMLParserDOCTYPEDeclNotFinishedError));
  rb_define_const(mOSX, "NSXMLParserMisplacedCDATAEndStringError", INT2NUM(NSXMLParserMisplacedCDATAEndStringError));
  rb_define_const(mOSX, "NSXMLParserCDATANotFinishedError", INT2NUM(NSXMLParserCDATANotFinishedError));
  rb_define_const(mOSX, "NSXMLParserMisplacedXMLDeclarationError", INT2NUM(NSXMLParserMisplacedXMLDeclarationError));
  rb_define_const(mOSX, "NSXMLParserSpaceRequiredError", INT2NUM(NSXMLParserSpaceRequiredError));
  rb_define_const(mOSX, "NSXMLParserSeparatorRequiredError", INT2NUM(NSXMLParserSeparatorRequiredError));
  rb_define_const(mOSX, "NSXMLParserNMTOKENRequiredError", INT2NUM(NSXMLParserNMTOKENRequiredError));
  rb_define_const(mOSX, "NSXMLParserNAMERequiredError", INT2NUM(NSXMLParserNAMERequiredError));
  rb_define_const(mOSX, "NSXMLParserPCDATARequiredError", INT2NUM(NSXMLParserPCDATARequiredError));
  rb_define_const(mOSX, "NSXMLParserURIRequiredError", INT2NUM(NSXMLParserURIRequiredError));
  rb_define_const(mOSX, "NSXMLParserPublicIdentifierRequiredError", INT2NUM(NSXMLParserPublicIdentifierRequiredError));
  rb_define_const(mOSX, "NSXMLParserLTRequiredError", INT2NUM(NSXMLParserLTRequiredError));
  rb_define_const(mOSX, "NSXMLParserGTRequiredError", INT2NUM(NSXMLParserGTRequiredError));
  rb_define_const(mOSX, "NSXMLParserLTSlashRequiredError", INT2NUM(NSXMLParserLTSlashRequiredError));
  rb_define_const(mOSX, "NSXMLParserEqualExpectedError", INT2NUM(NSXMLParserEqualExpectedError));
  rb_define_const(mOSX, "NSXMLParserTagNameMismatchError", INT2NUM(NSXMLParserTagNameMismatchError));
  rb_define_const(mOSX, "NSXMLParserUnfinishedTagError", INT2NUM(NSXMLParserUnfinishedTagError));
  rb_define_const(mOSX, "NSXMLParserStandaloneValueError", INT2NUM(NSXMLParserStandaloneValueError));
  rb_define_const(mOSX, "NSXMLParserInvalidEncodingNameError", INT2NUM(NSXMLParserInvalidEncodingNameError));
  rb_define_const(mOSX, "NSXMLParserCommentContainsDoubleHyphenError", INT2NUM(NSXMLParserCommentContainsDoubleHyphenError));
  rb_define_const(mOSX, "NSXMLParserInvalidEncodingError", INT2NUM(NSXMLParserInvalidEncodingError));
  rb_define_const(mOSX, "NSXMLParserExternalStandaloneEntityError", INT2NUM(NSXMLParserExternalStandaloneEntityError));
  rb_define_const(mOSX, "NSXMLParserInvalidConditionalSectionError", INT2NUM(NSXMLParserInvalidConditionalSectionError));
  rb_define_const(mOSX, "NSXMLParserEntityValueRequiredError", INT2NUM(NSXMLParserEntityValueRequiredError));
  rb_define_const(mOSX, "NSXMLParserNotWellBalancedError", INT2NUM(NSXMLParserNotWellBalancedError));
  rb_define_const(mOSX, "NSXMLParserExtraContentError", INT2NUM(NSXMLParserExtraContentError));
  rb_define_const(mOSX, "NSXMLParserInvalidCharacterInEntityError", INT2NUM(NSXMLParserInvalidCharacterInEntityError));
  rb_define_const(mOSX, "NSXMLParserParsedEntityRefInInternalError", INT2NUM(NSXMLParserParsedEntityRefInInternalError));
  rb_define_const(mOSX, "NSXMLParserEntityRefLoopError", INT2NUM(NSXMLParserEntityRefLoopError));
  rb_define_const(mOSX, "NSXMLParserEntityBoundaryError", INT2NUM(NSXMLParserEntityBoundaryError));
  rb_define_const(mOSX, "NSXMLParserInvalidURIError", INT2NUM(NSXMLParserInvalidURIError));
  rb_define_const(mOSX, "NSXMLParserURIFragmentError", INT2NUM(NSXMLParserURIFragmentError));
  rb_define_const(mOSX, "NSXMLParserNoDTDError", INT2NUM(NSXMLParserNoDTDError));
  rb_define_const(mOSX, "NSXMLParserDelegateAbortedParseError", INT2NUM(NSXMLParserDelegateAbortedParseError));

  /**** constants ****/
  rb_define_module_function(mOSX, "NSXMLParserErrorDomain", osx_NSXMLParserErrorDomain, 0);
}
void init_Foundation(VALUE mOSX)
{
  init_NSObjCRuntime(mOSX);
  init_NSBundle(mOSX);
  init_NSByteOrder(mOSX);
  init_NSCalendar(mOSX);
  init_NSCharacterSet(mOSX);
  init_NSData(mOSX);
  init_NSDateFormatter(mOSX);
  init_NSDecimal(mOSX);
  init_NSDecimalNumber(mOSX);
  init_NSError(mOSX);
  init_NSException(mOSX);
  init_NSFileHandle(mOSX);
  init_NSFileManager(mOSX);
  init_NSKeyValueCoding(mOSX);
  init_NSKeyValueObserving(mOSX);
  init_NSKeyedArchiver(mOSX);
  init_NSLocale(mOSX);
  init_NSNotificationQueue(mOSX);
  init_NSNumberFormatter(mOSX);
  init_NSObject(mOSX);
  init_NSOperation(mOSX);
  init_NSPathUtilities(mOSX);
  init_NSPort(mOSX);
  init_NSProcessInfo(mOSX);
  init_NSPropertyList(mOSX);
  init_NSRange(mOSX);
  init_NSRunLoop(mOSX);
  init_NSStream(mOSX);
  init_NSString(mOSX);
  init_NSThread(mOSX);
  init_NSTimeZone(mOSX);
  init_NSURL(mOSX);
  init_NSUserDefaults(mOSX);
  init_NSZone(mOSX);
  init_FoundationErrors(mOSX);
  init_NSHTTPCookie(mOSX);
  init_NSHTTPCookieStorage(mOSX);
  init_NSNetServices(mOSX);
  init_NSURLCredential(mOSX);
  init_NSURLCredentialStorage(mOSX);
  init_NSURLError(mOSX);
  init_NSURLProtectionSpace(mOSX);
  init_NSXMLParser(mOSX);
}
