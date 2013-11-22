// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNWall.m instead.

#import "_RNWall.h"

const struct RNWallAttributes RNWallAttributes = {
};

const struct RNWallRelationships RNWallRelationships = {
	.doors = @"doors",
	.radiators = @"radiators",
	.room = @"room",
	.windows = @"windows",
};

const struct RNWallFetchedProperties RNWallFetchedProperties = {
};

@implementation RNWallID
@end

@implementation _RNWall

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"RNWall" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"RNWall";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"RNWall" inManagedObjectContext:moc_];
}

- (RNWallID*)objectID {
	return (RNWallID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic doors;

	
- (NSMutableSet*)doorsSet {
	[self willAccessValueForKey:@"doors"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"doors"];
  
	[self didAccessValueForKey:@"doors"];
	return result;
}
	

@dynamic radiators;

	
- (NSMutableSet*)radiatorsSet {
	[self willAccessValueForKey:@"radiators"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"radiators"];
  
	[self didAccessValueForKey:@"radiators"];
	return result;
}
	

@dynamic room;

	

@dynamic windows;

	
- (NSMutableSet*)windowsSet {
	[self willAccessValueForKey:@"windows"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"windows"];
  
	[self didAccessValueForKey:@"windows"];
	return result;
}
	






@end
