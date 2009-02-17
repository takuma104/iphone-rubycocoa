#
#  $Id: coredata.rb 875 2005-11-06 01:55:24Z kimuraw $
#
#  Copyright (c) 2005 FUJIMOTO Hisakuni <hisa@imasy.or.jp>
#
#  This program is free software.
#  You can distribute/modify this program under the terms of
#  the GNU Lesser General Public License version 2.
#
require 'osx/cocoa'

module OSX

  # load CoreData.framework
  NSBundle.bundleWithPath("/System/Library/Frameworks/CoreData.framework").load

  # import classes
  ns_import :NSAttributeDescription
  ns_import :NSEntityDescription
  ns_import :NSFetchRequest
  ns_import :NSFetchedPropertyDescription
  ns_import :NSManagedObject
  ns_import :NSManagedObjectContext
  ns_import :NSManagedObjectID
  ns_import :NSManagedObjectModel
  ns_import :NSPersistentStoreCoordinator
  ns_import :NSPropertyDescription
  ns_import :NSRelationshipDescription

  # enums
  # typedef enum {...} CoreDataErrors;
  NSManagedObjectValidationError                   = 1550
  NSValidationMultipleErrorsError                  = 1560
  NSValidationMissingMandatoryPropertyError        = 1570
  NSValidationRelationshipLacksMinimumCountError   = 1580
  NSValidationRelationshipExceedsMaximumCountError = 1590
  NSValidationRelationshipDeniedDeleteError        = 1600
  NSValidationNumberTooLargeError                  = 1610
  NSValidationNumberTooSmallError                  = 1620
  NSValidationDateTooLateError                     = 1630
  NSValidationDateTooSoonError                     = 1640
  NSValidationInvalidDateError                     = 1650
  NSValidationStringTooLongError                   = 1660
  NSValidationStringTooShortError                  = 1670
  NSValidationStringPatternMatchingError           = 1680
  NSManagedObjectContextLockingError               = 132000
  NSPersistentStoreCoordinatorLockingError         = 132010
  NSManagedObjectReferentialIntegrityError         = 133000
  NSManagedObjectExternalRelationshipError         = 133010
  NSManagedObjectMergeError                        = 133020
  NSPersistentStoreInvalidTypeError                = 134000
  NSPersistentStoreTypeMismatchError               = 134010
  NSPersistentStoreIncompatibleSchemaError         = 134020
  NSPersistentStoreSaveError                       = 134030
  NSPersistentStoreIncompleteSaveError             = 134040             

  # enums
  # typedef enum {...} NSAttributeType;
  NSUndefinedAttributeType  = 0
  NSInteger16AttributeType  = 100
  NSInteger32AttributeType  = 200
  NSInteger64AttributeType  = 300
  NSDecimalAttributeType    = 400
  NSDoubleAttributeType     = 500
  NSFloatAttributeType      = 600
  NSStringAttributeType     = 700
  NSBooleanAttributeType    = 800
  NSDateAttributeType       = 900
  NSBinaryDataAttributeType = 1000

  # typedef enum {...} NSDeleteRule;
  %w(
    NSNoActionDeleteRule,
    NSNullifyDeleteRule,
    NSCascadeDeleteRule,
    NSDenyDeleteRule
  ).
    each_with_index {|name, value| module_eval "#{name} = #{value}",__FILE__,__LINE__+1 }

  # constants
  [
    # CoreData/CoreDataDefines.h
    :NSCoreDataVersionNumber,
    # CoreData/CoreDataErrors.h
    :NSDetailedErrorsKey,
    :NSValidationObjectErrorKey,
    :NSValidationKeyErrorKey,
    :NSValidationPredicateErrorKey,
    :NSValidationValueErrorKey,
    :NSAffectedStoresErrorKey,
    :NSAffectedObjectsErrorKey,
    # CoreData/NSManagedObjectContext.h
    :NSManagedObjectContextDidSaveNotification,
    :NSManagedObjectContextObjectsDidChangeNotification,
    :NSInsertedObjectsKey,
    :NSUpdatedObjectsKey,
    :NSDeletedObjectsKey,
    :NSErrorMergePolicy,
    :NSMergeByPropertyStoreTrumpMergePolicy,
    :NSMergeByPropertyObjectTrumpMergePolicy,
    :NSOverwriteMergePolicy,
    :NSRollbackMergePolicy,
    # CoreData/NSPersistentStoreCoordinator.h
    :NSSQLiteStoreType,
    :NSXMLStoreType,
    :NSBinaryStoreType,
    :NSInMemoryStoreType,
    :NSStoreTypeKey,
    :NSStoreUUIDKey,
    :NSPersistentStoreCoordinatorStoresDidChangeNotification,
    :NSAddedPersistentStoresKey,
    :NSRemovedPersistentStoresKey,
    :NSUUIDChangedPersistentStoresKey,
    :NSReadOnlyPersistentStoreOption,
    :NSValidateXMLStoreOption,
  ].each do |name|
    module_eval <<-EOE,__FILE__,__LINE__+1
      def #{name}
	objc_symbol_to_obj('#{name}', '@')
      end
      module_function :#{name}
    EOE
  end

end

module OSX

  module CoreData

    # define wrappers from NSManagedObjectModel
    def define_wrapper(model)
      unless model.isKindOfClass? OSX::NSManagedObjectModel
        raise RuntimeError, "invalid class: #{model.class}"
      end

      model.entities.to_a.each do |ent|
	klassname = ent.managedObjectClassName.to_s
        next if klassname == 'NSManagedObject'
	next unless Object.const_defined?(klassname)

	attrs = ent.attributesByName.allKeys.to_a.collect {|key| key.to_s}
	rels = ent.relationshipsByName.allKeys.to_a.collect {|key| key.to_s}
	klass = Object.const_get(klassname)
	klass.instance_eval <<-EOE_AUTOWRAP,__FILE__,__LINE__+1
	  kvc_wrapper attrs
	  kvc_wrapper_reader rels
	EOE_AUTOWRAP
      end
    end
    module_function :define_wrapper

  end

end
