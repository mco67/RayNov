// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNSite.h instead.

#import <CoreData/CoreData.h>


extern const struct RNSiteAttributes {
	__unsafe_unretained NSString *creationDate;
	__unsafe_unretained NSString *siteName;
	__unsafe_unretained NSString *siteReference;
} RNSiteAttributes;

extern const struct RNSiteRelationships {
	__unsafe_unretained NSString *address;
	__unsafe_unretained NSString *client;
	__unsafe_unretained NSString *rooms;
} RNSiteRelationships;

extern const struct RNSiteFetchedProperties {
} RNSiteFetchedProperties;

@class RNAddress;
@class RNClient;
@class RNRoom;





@interface RNSiteID : NSManagedObjectID {}
@end

@interface _RNSite : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RNSiteID*)objectID;





@property (nonatomic, strong) NSDate* creationDate;



//- (BOOL)validateCreationDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* siteName;



//- (BOOL)validateSiteName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* siteReference;



//- (BOOL)validateSiteReference:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) RNAddress *address;

//- (BOOL)validateAddress:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) RNClient *client;

//- (BOOL)validateClient:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *rooms;

- (NSMutableSet*)roomsSet;





@end

@interface _RNSite (CoreDataGeneratedAccessors)

- (void)addRooms:(NSSet*)value_;
- (void)removeRooms:(NSSet*)value_;
- (void)addRoomsObject:(RNRoom*)value_;
- (void)removeRoomsObject:(RNRoom*)value_;

@end

@interface _RNSite (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveCreationDate;
- (void)setPrimitiveCreationDate:(NSDate*)value;




- (NSString*)primitiveSiteName;
- (void)setPrimitiveSiteName:(NSString*)value;




- (NSString*)primitiveSiteReference;
- (void)setPrimitiveSiteReference:(NSString*)value;





- (RNAddress*)primitiveAddress;
- (void)setPrimitiveAddress:(RNAddress*)value;



- (RNClient*)primitiveClient;
- (void)setPrimitiveClient:(RNClient*)value;



- (NSMutableSet*)primitiveRooms;
- (void)setPrimitiveRooms:(NSMutableSet*)value;


@end
