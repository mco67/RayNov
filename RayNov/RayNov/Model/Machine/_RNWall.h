// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNWall.h instead.

#import <CoreData/CoreData.h>
#import "RNSurface.h"

extern const struct RNWallAttributes {
} RNWallAttributes;

extern const struct RNWallRelationships {
	__unsafe_unretained NSString *doors;
	__unsafe_unretained NSString *radiators;
	__unsafe_unretained NSString *room;
	__unsafe_unretained NSString *windows;
} RNWallRelationships;

extern const struct RNWallFetchedProperties {
} RNWallFetchedProperties;

@class RNDoor;
@class RNRadiator;
@class RNRoom;
@class RNWindow;


@interface RNWallID : NSManagedObjectID {}
@end

@interface _RNWall : RNSurface {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RNWallID*)objectID;





@property (nonatomic, strong) NSSet *doors;

- (NSMutableSet*)doorsSet;




@property (nonatomic, strong) NSSet *radiators;

- (NSMutableSet*)radiatorsSet;




@property (nonatomic, strong) RNRoom *room;

//- (BOOL)validateRoom:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *windows;

- (NSMutableSet*)windowsSet;





@end

@interface _RNWall (CoreDataGeneratedAccessors)

- (void)addDoors:(NSSet*)value_;
- (void)removeDoors:(NSSet*)value_;
- (void)addDoorsObject:(RNDoor*)value_;
- (void)removeDoorsObject:(RNDoor*)value_;

- (void)addRadiators:(NSSet*)value_;
- (void)removeRadiators:(NSSet*)value_;
- (void)addRadiatorsObject:(RNRadiator*)value_;
- (void)removeRadiatorsObject:(RNRadiator*)value_;

- (void)addWindows:(NSSet*)value_;
- (void)removeWindows:(NSSet*)value_;
- (void)addWindowsObject:(RNWindow*)value_;
- (void)removeWindowsObject:(RNWindow*)value_;

@end

@interface _RNWall (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableSet*)primitiveDoors;
- (void)setPrimitiveDoors:(NSMutableSet*)value;



- (NSMutableSet*)primitiveRadiators;
- (void)setPrimitiveRadiators:(NSMutableSet*)value;



- (RNRoom*)primitiveRoom;
- (void)setPrimitiveRoom:(RNRoom*)value;



- (NSMutableSet*)primitiveWindows;
- (void)setPrimitiveWindows:(NSMutableSet*)value;


@end
