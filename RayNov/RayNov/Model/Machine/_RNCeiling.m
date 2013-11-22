// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNCeiling.m instead.

#import "_RNCeiling.h"

const struct RNCeilingAttributes RNCeilingAttributes = {
};

const struct RNCeilingRelationships RNCeilingRelationships = {
	.room = @"room",
};

const struct RNCeilingFetchedProperties RNCeilingFetchedProperties = {
};

@implementation RNCeilingID
@end

@implementation _RNCeiling

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"RNCeiling" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"RNCeiling";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"RNCeiling" inManagedObjectContext:moc_];
}

- (RNCeilingID*)objectID {
	return (RNCeilingID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic room;

	






@end
