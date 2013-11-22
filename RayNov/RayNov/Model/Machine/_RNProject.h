// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNProject.h instead.

#import <CoreData/CoreData.h>


extern const struct RNProjectAttributes {
} RNProjectAttributes;

extern const struct RNProjectRelationships {
	__unsafe_unretained NSString *rooms;
} RNProjectRelationships;

extern const struct RNProjectFetchedProperties {
} RNProjectFetchedProperties;

@class RNRoom;


@interface RNProjectID : NSManagedObjectID {}
@end

@interface _RNProject : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RNProjectID*)objectID;





@property (nonatomic, strong) NSSet *rooms;

- (NSMutableSet*)roomsSet;





@end

@interface _RNProject (CoreDataGeneratedAccessors)

- (void)addRooms:(NSSet*)value_;
- (void)removeRooms:(NSSet*)value_;
- (void)addRoomsObject:(RNRoom*)value_;
- (void)removeRoomsObject:(RNRoom*)value_;

@end

@interface _RNProject (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveRooms;
- (void)setPrimitiveRooms:(NSMutableSet*)value;


@end
