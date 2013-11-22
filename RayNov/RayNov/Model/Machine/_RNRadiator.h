// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNRadiator.h instead.

#import <CoreData/CoreData.h>
#import "RNSurface.h"

extern const struct RNRadiatorAttributes {
} RNRadiatorAttributes;

extern const struct RNRadiatorRelationships {
	__unsafe_unretained NSString *wall;
} RNRadiatorRelationships;

extern const struct RNRadiatorFetchedProperties {
} RNRadiatorFetchedProperties;

@class RNWall;


@interface RNRadiatorID : NSManagedObjectID {}
@end

@interface _RNRadiator : RNSurface {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RNRadiatorID*)objectID;





@property (nonatomic, strong) RNWall *wall;

//- (BOOL)validateWall:(id*)value_ error:(NSError**)error_;





@end

@interface _RNRadiator (CoreDataGeneratedAccessors)

@end

@interface _RNRadiator (CoreDataGeneratedPrimitiveAccessors)



- (RNWall*)primitiveWall;
- (void)setPrimitiveWall:(RNWall*)value;


@end
