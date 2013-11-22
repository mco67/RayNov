// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNRadiator.m instead.

#import "_RNRadiator.h"

const struct RNRadiatorAttributes RNRadiatorAttributes = {
};

const struct RNRadiatorRelationships RNRadiatorRelationships = {
	.wall = @"wall",
};

const struct RNRadiatorFetchedProperties RNRadiatorFetchedProperties = {
};

@implementation RNRadiatorID
@end

@implementation _RNRadiator

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"RNRadiator" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"RNRadiator";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"RNRadiator" inManagedObjectContext:moc_];
}

- (RNRadiatorID*)objectID {
	return (RNRadiatorID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic wall;

	






@end
