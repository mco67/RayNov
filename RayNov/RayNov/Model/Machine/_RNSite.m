// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNSite.m instead.

#import "_RNSite.h"

const struct RNSiteAttributes RNSiteAttributes = {
	.creationDate = @"creationDate",
	.siteName = @"siteName",
	.siteReference = @"siteReference",
};

const struct RNSiteRelationships RNSiteRelationships = {
	.address = @"address",
	.client = @"client",
	.rooms = @"rooms",
};

const struct RNSiteFetchedProperties RNSiteFetchedProperties = {
};

@implementation RNSiteID
@end

@implementation _RNSite

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"RNSite" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"RNSite";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"RNSite" inManagedObjectContext:moc_];
}

- (RNSiteID*)objectID {
	return (RNSiteID*)[super objectID];
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
