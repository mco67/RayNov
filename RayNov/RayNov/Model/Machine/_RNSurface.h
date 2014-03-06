// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNSurface.h instead.

#import <CoreData/CoreData.h>


extern const struct RNSurfaceAttributes {
	__unsafe_unretained NSString *surface;
} RNSurfaceAttributes;

extern const struct RNSurfaceRelationships {
} RNSurfaceRelationships;

extern const struct RNSurfaceFetchedProperties {
} RNSurfaceFetchedProperties;




@interface RNSurfaceID : NSManagedObjectID {}
@end

@interface _RNSurface : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RNSurfaceID*)objectID;





@property (nonatomic, strong) NSNumber* surface;



@property double surfaceValue;
- (double)surfaceValue;
- (void)setSurfaceValue:(double)value_;

//- (BOOL)validateSurface:(id*)value_ error:(NSError**)error_;






@end

@interface _RNSurface (CoreDataGeneratedAccessors)

@end

@interface _RNSurface (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveSurface;
- (void)setPrimitiveSurface:(NSNumber*)value;

- (double)primitiveSurfaceValue;
- (void)setPrimitiveSurfaceValue:(double)value_;




@end
