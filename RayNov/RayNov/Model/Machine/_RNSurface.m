// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNSurface.m instead.

#import "_RNSurface.h"

const struct RNSurfaceAttributes RNSurfaceAttributes = {
	.surface = @"surface",
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
	
	if ([key isEqualToString:@"surfaceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"surface"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic surface;



- (double)surfaceValue {
	NSNumber *result = [self surface];
	return [result doubleValue];
}

- (void)setSurfaceValue:(double)value_ {
	[self setSurface:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveSurfaceValue {
	NSNumber *result = [self primitiveSurface];
	return [result doubleValue];
}

- (void)setPrimitiveSurfaceValue:(double)value_ {
	[self setPrimitiveSurface:[NSNumber numberWithDouble:value_]];
}










@end
