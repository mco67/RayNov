// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNSurface.m instead.

#import "_RNSurface.h"

const struct RNSurfaceAttributes RNSurfaceAttributes = {
	.height = @"height",
	.width = @"width",
};

const struct RNSurfaceRelationships RNSurfaceRelationships = {
};

const struct RNSurfaceFetchedProperties RNSurfaceFetchedProperties = {
};

@implementation RNSurfaceID
@end

@implementation _RNSurface

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"RNSurface" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"RNSurface";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"RNSurface" inManagedObjectContext:moc_];
}

- (RNSurfaceID*)objectID {
	return (RNSurfaceID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"heightValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"height"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"widthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"width"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic height;



- (double)heightValue {
	NSNumber *result = [self height];
	return [result doubleValue];
}

- (void)setHeightValue:(double)value_ {
	[self setHeight:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveHeightValue {
	NSNumber *result = [self primitiveHeight];
	return [result doubleValue];
}

- (void)setPrimitiveHeightValue:(double)value_ {
	[self setPrimitiveHeight:[NSNumber numberWithDouble:value_]];
}





@dynamic width;



- (double)widthValue {
	NSNumber *result = [self width];
	return [result doubleValue];
}

- (void)setWidthValue:(double)value_ {
	[self setWidth:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveWidthValue {
	NSNumber *result = [self primitiveWidth];
	return [result doubleValue];
}

- (void)setPrimitiveWidthValue:(double)value_ {
	[self setPrimitiveWidth:[NSNumber numberWithDouble:value_]];
}










@end
