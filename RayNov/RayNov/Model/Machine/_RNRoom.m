// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNRoom.m instead.

#import "_RNRoom.h"

const struct RNRoomAttributes RNRoomAttributes = {
	.dummy = @"dummy",
};

const struct RNRoomRelationships RNRoomRelationships = {
	.ceiling = @"ceiling",
	.ground = @"ground",
	.project = @"project",
	.walls = @"walls",
};

const struct RNRoomFetchedProperties RNRoomFetchedProperties = {
};

@implementation RNRoomID
@end

@implementation _RNRoom

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"RNRoom" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"RNRoom";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"RNRoom" inManagedObjectContext:moc_];
}

- (RNRoomID*)objectID {
	return (RNRoomID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"dummyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"dummy"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic dummy;



- (BOOL)dummyValue {
	NSNumber *result = [self dummy];
	return [result boolValue];
}

- (void)setDummyValue:(BOOL)value_ {
	[self setDummy:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveDummyValue {
	NSNumber *result = [self primitiveDummy];
	return [result boolValue];
}

- (void)setPrimitiveDummyValue:(BOOL)value_ {
	[self setPrimitiveDummy:[NSNumber numberWithBool:value_]];
}





@dynamic ceiling;

	

@dynamic ground;

	

@dynamic project;

	

@dynamic walls;

	
- (NSMutableSet*)wallsSet {
	[self willAccessValueForKey:@"walls"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"walls"];
  
	[self didAccessValueForKey:@"walls"];
	return result;
}
	






@end
