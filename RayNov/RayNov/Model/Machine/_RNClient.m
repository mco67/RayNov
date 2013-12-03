// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNClient.m instead.

#import "_RNClient.h"

const struct RNClientAttributes RNClientAttributes = {
	.emailAddress = @"emailAddress",
	.faxPhoneNumber = @"faxPhoneNumber",
	.firstName = @"firstName",
	.lastName = @"lastName",
	.mobilePhoneNumber = @"mobilePhoneNumber",
	.phoneNumber = @"phoneNumber",
};

const struct RNClientRelationships RNClientRelationships = {
	.address = @"address",
};

const struct RNClientFetchedProperties RNClientFetchedProperties = {
};

@implementation RNClientID
@end

@implementation _RNClient

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"RNClient" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"RNClient";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"RNClient" inManagedObjectContext:moc_];
}

- (RNClientID*)objectID {
	return (RNClientID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic emailAddress;






@dynamic faxPhoneNumber;






@dynamic firstName;






@dynamic lastName;






@dynamic mobilePhoneNumber;






@dynamic phoneNumber;






@dynamic address;

	






@end
