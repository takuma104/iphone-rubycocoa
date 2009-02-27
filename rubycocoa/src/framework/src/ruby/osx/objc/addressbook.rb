#
#  $Id: addressbook.rb 979 2006-05-29 01:18:25Z hisa $
#
#  Copyright (c) 2001 FUJIMOTO Hisakuni
#
require 'osx/cocoa'

module OSX

  # load AddressBook.framework
  NSBundle.bundleWithPath("/System/Library/Frameworks/AddressBook.framework").load

  # import classes
  ns_import :ABAddressBook
  ns_import :ABGroup
  ns_import :ABPerson
  ns_import :ABMultiValue
  ns_import :ABRecord
  ns_import :ABSearchElement

  #define kABMultiValueMask        0x100
  KABMultiValueMask = 0x100

  # enums
  # typedef enum _ABPropertyType {...} ABPropertyType;
  KABErrorInProperty           = 0x0
  KABStringProperty            = 0x1
  KABIntegerProperty           = 0x2
  KABRealProperty              = 0x3
  KABDateProperty              = 0x4
  KABArrayProperty             = 0x5
  KABDictionaryProperty        = 0x6
  KABDataProperty              = 0x7
  KABMultiStringProperty       = KABMultiValueMask | KABStringProperty
  KABMultiIntegerProperty      = KABMultiValueMask | KABIntegerProperty
  KABMultiRealProperty         = KABMultiValueMask | KABRealProperty
  KABMultiDateProperty         = KABMultiValueMask | KABDateProperty
  KABMultiArrayProperty        = KABMultiValueMask | KABArrayProperty
  KABMultiDictionaryProperty   = KABMultiValueMask | KABDictionaryProperty
  KABMultiDataProperty         = KABMultiValueMask | KABDataProperty

  # typedef enum _ABSearchComparison {...} ABSearchComparison;
  %w(
    KABEqual
    KABNotEqual
    KABLessThan
    KABLessThanOrEqual
    KABGreaterThan
    KABGreaterThanOrEqual
    KABEqualCaseInsensitive
    KABContainsSubString
    KABContainsSubStringCaseInsensitive
    KABPrefixMatch
    KABPrefixMatchCaseInsensitive
  ).
    each_with_index {|name, value| module_eval "#{name} = #{value}",__FILE__,__LINE__+1 }

  # typedef enum _ABSearchConjunction {...} ABSearchConjunction;
  %w(KABSearchAnd KABSearchOr).
    each_with_index {|name, value| module_eval "#{name} = #{value}",__FILE__,__LINE__+1 }

  # constants
  [
    :kABUIDProperty,		# The UID property
    :kABCreationDateProperty, # Creation Date (when first saved) (date)
    :kABModificationDateProperty, # Last saved date (date)
    :kABFirstNameProperty,	# First name (string)
    :kABLastNameProperty,	# Last name  (string)
    :kABFirstNamePhoneticProperty, # First name Phonetic (string)
    :kABLastNamePhoneticProperty, # Last name Phonetic (string)
    :kABBirthdayProperty,	# Birth date  (date)
    :kABOrganizationProperty,	# Company name  (string)
    :kABJobTitleProperty,	# Job Title  (string)
    :kABHomePageProperty,	# Home Web page  (string)
    :kABEmailProperty,		# Email(s) (multi-string)
    :kABEmailWorkLabel,		# Home email
    :kABEmailHomeLabel,		# Work email
    :kABAddressProperty,	# Street Addresses (multi-dictionary)
    :kABAddressStreetKey,	# Street
    :kABAddressCityKey,		# City
    :kABAddressStateKey,	# State
    :kABAddressZIPKey,		# Zip
    :kABAddressCountryKey,	# Country
    :kABAddressCountryCodeKey,	# Country Code
    :kABAddressHomeLabel,	# Home Address
    :kABAddressWorkLabel,	# Work Address
    :kABPhoneProperty,		# Generic phone number (multi-string)
    :kABPhoneWorkLabel,		# Work phone
    :kABPhoneHomeLabel,		# Home phone
    :kABPhoneMobileLabel,	# Cell phone
    :kABPhoneMainLabel,		# Main phone
    :kABPhoneHomeFAXLabel,	# FAX number
    :kABPhoneWorkFAXLabel,	# FAX number
    :kABPhonePagerLabel,	# Pager number
    :kABAIMInstantProperty,	# AIM Instant Messaging (multi-string)
    :kABAIMWorkLabel,
    :kABAIMHomeLabel,
    :kABJabberInstantProperty, # Jabber Instant Messaging (multi-string)
    :kABJabberWorkLabel,
    :kABJabberHomeLabel,
    :kABMSNInstantProperty,    # MSN Instant Messaging  (multi-string)
    :kABMSNWorkLabel,
    :kABMSNHomeLabel,
    :kABYahooInstantProperty, # Yahoo Instant Messaging  (multi-string)
    :kABYahooWorkLabel,
    :kABYahooHomeLabel,
    :kABICQInstantProperty,    # ICQ Instant Messaging  (multi-string)
    :kABICQWorkLabel,
    :kABICQHomeLabel,
    :kABNoteProperty,		# Note (string)
    :kABMiddleNameProperty,	# string
    :kABMiddleNamePhoneticProperty, # string
    :kABTitleProperty,		# string "Sir" "Duke" "General" "Lord"
    :kABSuffixProperty,		# string "Sr." "Jr." "III"
    :kABNicknameProperty,	# string
    :kABMaidenNameProperty,	# string
    :kABGroupNameProperty,	# Name of the group
    :kABWorkLabel,
    :kABHomeLabel,
    :kABOtherLabel,
    :kABDatabaseChangedNotification,
    :kABDatabaseChangedExternallyNotification

  ].each do |name|
    module_eval <<-EOE,__FILE__,__LINE__+1
      def #{name}
	objc_symbol_to_obj('#{name}', '@')
      end
      module_function :#{name}
    EOE
  end

end
