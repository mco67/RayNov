// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNSurface.h instead.

#import <CoreData/CoreData.h>


extern const struct RNSurfaceAttributes {
	__unsafe_unretained NSString *height;
	__unsafe_unretained NSString *width;
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





@property (nonatomic, strong) NSNumber* height;



@property double heightValue;
- (double)heightValue;
- (void)setHeightValue:(double)value_;

//- (BOOL)validateHeight:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* width;



@property double widthValue;
- (double)widthValue;
- (void)setWidthValue:(double)value_;

//- (BOOL)validateWidth:(id*)value_ error:(NSError**)error_;






@end

@interface _RNSurface (CoreDataGeneratedAccessors)

@end

@interface _RNSurface (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveHeight;
- (void)setPrimitiveHeight:(NSNumber*)value;

- (double)primitiveHeightValue;
- (void)setPrimitiveHeightValue:(double)value_;




- (NSNumber*)primitiveWidth;
- (void)setPrimitiveWidth:(NSNumber*)value;

- (double)primitiveWidthValue;
- (void)setPrimitiveWidthValue:(double)value_;




@end
