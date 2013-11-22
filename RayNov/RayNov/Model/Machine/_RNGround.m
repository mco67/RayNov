// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNGround.m instead.

#import "_RNGround.h"

const struct RNGroundAttributes RNGroundAttributes = {
};

const struct RNGroundRelationships RNGroundRelationships = {
	.room = @"room",
};

const struct RNGroundFetchedProperties RNGroundFetchedProperties = {
};

@implementation RNGroundID
@end

@implementation _RNGround

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"RNGround" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"RNGround";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"RNGround" inManagedObjectContext:moc_];
}

- (RNGroundID*)objectID {
	return (RNGroundID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic room;

	






@end
