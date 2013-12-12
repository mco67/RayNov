// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNAddress.h instead.

#import <CoreData/CoreData.h>


extern const struct RNAddressAttributes {
	__unsafe_unretained NSString *country;
	__unsafe_unretained NSString *postalAddress1;
	__unsafe_unretained NSString *postalAddress2;
	__unsafe_unretained NSString *postalCode;
	__unsafe_unretained NSString *town;
} RNAddressAttributes;

extern const struct RNAddressRelationships {
} RNAddressRelationships;

extern const struct RNAddressFetchedProperties {
} RNAddressFetchedProperties;








@interface RNAddressID : NSManagedObjectID {}
@end

@interface _RNAddress : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RNAddressID*)objectID;





@property (nonatomic, strong) NSString* country;



//- (BOOL)validateCountry:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* postalAddress1;



//- (BOOL)validatePostalAddress1:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* postalAddress2;



//- (BOOL)validatePostalAddress2:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* postalCode;



//- (BOOL)validatePostalCode:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* town;



//- (BOOL)validateTown:(id*)value_ error:(NSError**)error_;






@end

@interface _RNAddress (CoreDataGeneratedAccessors)

@end

@interface _RNAddress (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCountry;
- (void)setPrimitiveCountry:(NSString*)value;




- (NSString*)primitivePostalAddress1;
- (void)setPrimitivePostalAddress1:(NSString*)value;




- (NSString*)primitivePostalAddress2;
- (void)setPrimitivePostalAddress2:(NSString*)value;




- (NSString*)primitivePostalCode;
- (void)setPrimitivePostalCode:(NSString*)value;




- (NSString*)primitiveTown;
- (void)setPrimitiveTown:(NSString*)value;




@end
