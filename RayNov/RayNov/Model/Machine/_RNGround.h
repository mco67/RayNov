// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNGround.h instead.

#import <CoreData/CoreData.h>
#import "RNSurface.h"

extern const struct RNGroundAttributes {
} RNGroundAttributes;

extern const struct RNGroundRelationships {
	__unsafe_unretained NSString *room;
} RNGroundRelationships;

extern const struct RNGroundFetchedProperties {
} RNGroundFetchedProperties;

@class RNRoom;


@interface RNGroundID : NSManagedObjectID {}
@end

@interface _RNGround : RNSurface {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RNGroundID*)objectID;





@property (nonatomic, strong) RNRoom *room;

//- (BOOL)validateRoom:(id*)value_ error:(NSError**)error_;





@end

@interface _RNGround (CoreDataGeneratedAccessors)

@end

@interface _RNGround (CoreDataGeneratedPrimitiveAccessors)



- (RNRoom*)primitiveRoom;
- (void)setPrimitiveRoom:(RNRoom*)value;


@end
