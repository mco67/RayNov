// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNDoor.h instead.

#import <CoreData/CoreData.h>
#import "RNSurface.h"

extern const struct RNDoorAttributes {
} RNDoorAttributes;

extern const struct RNDoorRelationships {
	__unsafe_unretained NSString *wall;
} RNDoorRelationships;

extern const struct RNDoorFetchedProperties {
} RNDoorFetchedProperties;

@class RNWall;


@interface RNDoorID : NSManagedObjectID {}
@end

@interface _RNDoor : RNSurface {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RNDoorID*)objectID;





@property (nonatomic, strong) RNWall *wall;

//- (BOOL)validateWall:(id*)value_ error:(NSError**)error_;





@end

@interface _RNDoor (CoreDataGeneratedAccessors)

@end

@interface _RNDoor (CoreDataGeneratedPrimitiveAccessors)



- (RNWall*)primitiveWall;
- (void)setPrimitiveWall:(RNWall*)value;


@end
