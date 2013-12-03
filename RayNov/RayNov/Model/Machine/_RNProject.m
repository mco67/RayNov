// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNProject.m instead.

#import "_RNProject.h"

const struct RNProjectAttributes RNProjectAttributes = {
	.creationDate = @"creationDate",
	.siteName = @"siteName",
	.siteReference = @"siteReference",
};

const struct RNProjectRelationships RNProjectRelationships = {
	.address = @"address",
	.client = @"client",
	.rooms = @"rooms",
};

const struct RNProjectFetchedProperties RNProjectFetchedProperties = {
};

@implementation RNProjectID
@end

@implementation _RNProject

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"RNProject" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"RNProject";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"RNProject" inManagedObjectContext:moc_];
}

- (RNProjectID*)objectID {
	return (RNProjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic creationDate;






@dynamic siteName;






@dynamic siteReference;






@dynamic address;

	

@dynamic client;

	

@dynamic rooms;

	
- (NSMutableSet*)roomsSet {
	[self willAccessValueForKey:@"rooms"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"rooms"];
  
	[self didAccessValueForKey:@"rooms"];
	return result;
}
	






@end
