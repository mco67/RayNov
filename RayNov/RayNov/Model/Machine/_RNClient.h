// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RNClient.h instead.

#import <CoreData/CoreData.h>


extern const struct RNClientAttributes {
	__unsafe_unretained NSString *emailAddress;
	__unsafe_unretained NSString *faxPhoneNumber;
	__unsafe_unretained NSString *firstName;
	__unsafe_unretained NSString *lastName;
	__unsafe_unretained NSString *mobilePhoneNumber;
	__unsafe_unretained NSString *phoneNumber;
} RNClientAttributes;

extern const struct RNClientRelationships {
	__unsafe_unretained NSString *address;
} RNClientRelationships;

extern const struct RNClientFetchedProperties {
} RNClientFetchedProperties;

@class RNAddress;








@interface RNClientID : NSManagedObjectID {}
@end

@interface _RNClient : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RNClientID*)objectID;





@property (nonatomic, strong) NSString* emailAddress;



//- (BOOL)validateEmailAddress:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* faxPhoneNumber;



//- (BOOL)validateFaxPhoneNumber:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* firstName;



//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* lastName;



//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* mobilePhoneNumber;



//- (BOOL)validateMobilePhoneNumber:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* phoneNumber;



//- (BOOL)validatePhoneNumber:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) RNAddress *address;

//- (BOOL)validateAddress:(id*)value_ error:(NSError**)error_;





@end

@interface _RNClient (CoreDataGeneratedAccessors)

@end

@interface _RNClient (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveEmailAddress;
- (void)setPrimitiveEmailAddress:(NSString*)value;




- (NSString*)primitiveFaxPhoneNumber;
- (void)setPrimitiveFaxPhoneNumber:(NSString*)value;




- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;




- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;




- (NSString*)primitiveMobilePhoneNumber;
- (void)setPrimitiveMobilePhoneNumber:(NSString*)value;




- (NSString*)primitivePhoneNumber;
- (void)setPrimitivePhoneNumber:(NSString*)value;





- (RNAddress*)primitiveAddress;
- (void)setPrimitiveAddress:(RNAddress*)value;


@end
