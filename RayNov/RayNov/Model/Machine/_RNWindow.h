// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNWindow.h instead.

#import <CoreData/CoreData.h>
#import "RNSurface.h"

extern const struct RNWindowAttributes {
} RNWindowAttributes;

extern const struct RNWindowRelationships {
	__unsafe_unretained NSString *wall;
} RNWindowRelationships;

extern const struct RNWindowFetchedProperties {
} RNWindowFetchedProperties;

@class RNWall;


@interface RNWindowID : NSManagedObjectID {}
@end

@interface _RNWindow : RNSurface {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RNWindowID*)objectID;





@property (nonatomic, strong) RNWall *wall;

//- (BOOL)validateWall:(id*)value_ error:(NSError**)error_;





@end

@interface _RNWindow (CoreDataGeneratedAccessors)

@end

@interface _RNWindow (CoreDataGeneratedPrimitiveAccessors)



- (RNWall*)primitiveWall;
- (void)setPrimitiveWall:(RNWall*)value;


@end
