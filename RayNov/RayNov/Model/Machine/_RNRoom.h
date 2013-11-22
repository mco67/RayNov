// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNRoom.h instead.

#import <CoreData/CoreData.h>


extern const struct RNRoomAttributes {
} RNRoomAttributes;

extern const struct RNRoomRelationships {
	__unsafe_unretained NSString *ceiling;
	__unsafe_unretained NSString *ground;
	__unsafe_unretained NSString *project;
	__unsafe_unretained NSString *walls;
} RNRoomRelationships;

extern const struct RNRoomFetchedProperties {
} RNRoomFetchedProperties;

@class RNCeiling;
@class RNGround;
@class RNProject;
@class RNWall;


@interface RNRoomID : NSManagedObjectID {}
@end

@interface _RNRoom : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RNRoomID*)objectID;





@property (nonatomic, strong) RNCeiling *ceiling;

//- (BOOL)validateCeiling:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) RNGround *ground;

//- (BOOL)validateGround:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) RNProject *project;

//- (BOOL)validateProject:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *walls;

- (NSMutableSet*)wallsSet;





@end

@interface _RNRoom (CoreDataGeneratedAccessors)

- (void)addWalls:(NSSet*)value_;
- (void)removeWalls:(NSSet*)value_;
- (void)addWallsObject:(RNWall*)value_;
- (void)removeWallsObject:(RNWall*)value_;

@end

@interface _RNRoom (CoreDataGeneratedPrimitiveAccessors)



- (RNCeiling*)primitiveCeiling;
- (void)setPrimitiveCeiling:(RNCeiling*)value;



- (RNGround*)primitiveGround;
- (void)setPrimitiveGround:(RNGround*)value;



- (RNProject*)primitiveProject;
- (void)setPrimitiveProject:(RNProject*)value;



- (NSMutableSet*)primitiveWalls;
- (void)setPrimitiveWalls:(NSMutableSet*)value;


@end
