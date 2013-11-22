// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNCeiling.h instead.

#import <CoreData/CoreData.h>
#import "RNSurface.h"

extern const struct RNCeilingAttributes {
} RNCeilingAttributes;

extern const struct RNCeilingRelationships {
	__unsafe_unretained NSString *room;
} RNCeilingRelationships;

extern const struct RNCeilingFetchedProperties {
} RNCeilingFetchedProperties;

@class RNRoom;


@interface RNCeilingID : NSManagedObjectID {}
@end

@interface _RNCeiling : RNSurface {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RNCeilingID*)objectID;





@property (nonatomic, strong) RNRoom *room;

//- (BOOL)validateRoom:(id*)value_ error:(NSError**)error_;





@end

@interface _RNCeiling (CoreDataGeneratedAccessors)

@end

@interface _RNCeiling (CoreDataGeneratedPrimitiveAccessors)



- (RNRoom*)primitiveRoom;
- (void)setPrimitiveRoom:(RNRoom*)value;


@end
