// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNDoor.m instead.

#import "_RNDoor.h"

const struct RNDoorAttributes RNDoorAttributes = {
};

const struct RNDoorRelationships RNDoorRelationships = {
	.wall = @"wall",
};

const struct RNDoorFetchedProperties RNDoorFetchedProperties = {
};

@implementation RNDoorID
@end

@implementation _RNDoor

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"RNDoor" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"RNDoor";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"RNDoor" inManagedObjectContext:moc_];
}

- (RNDoorID*)objectID {
	return (RNDoorID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic wall;

	






@end
