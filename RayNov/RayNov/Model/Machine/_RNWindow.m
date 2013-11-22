// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNWindow.m instead.

#import "_RNWindow.h"

const struct RNWindowAttributes RNWindowAttributes = {
};

const struct RNWindowRelationships RNWindowRelationships = {
	.wall = @"wall",
};

const struct RNWindowFetchedProperties RNWindowFetchedProperties = {
};

@implementation RNWindowID
@end

@implementation _RNWindow

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"RNWindow" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"RNWindow";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"RNWindow" inManagedObjectContext:moc_];
}

- (RNWindowID*)objectID {
	return (RNWindowID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic wall;

	






@end
