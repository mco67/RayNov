// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNAddress.m instead.

#import "_RNAddress.h"

const struct RNAddressAttributes RNAddressAttributes = {
	.country = @"country",
	.postalAddress1 = @"postalAddress1",
	.postalAddress2 = @"postalAddress2",
	.postalCode = @"postalCode",
	.town = @"town",
};

const struct RNAddressRelationships RNAddressRelationships = {
};

const struct RNAddressFetchedProperties RNAddressFetchedProperties = {
};

@implementation RNAddressID
@end

@implementation _RNAddress

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"RNAddress" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"RNAddress";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"RNAddress" inManagedObjectContext:moc_];
}

- (RNAddressID*)objectID {
	return (RNAddressID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic country;






@dynamic postalAddress1;






@dynamic postalAddress2;






@dynamic postalCode;






@dynamic town;











@end
