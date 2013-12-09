#import "RNClient.h"
#import "RNAddress.h"

@interface RNClient ()

@end


@implementation RNClient

@synthesize displayName;
@synthesize displayAddress;

- (NSString*) displayName
{
    return [NSString stringWithFormat:@"%@ %@", self.lastName, self.firstName];
}

- (NSString*) displayAddress
{
    return [NSString stringWithFormat:@"%@ %@", self.address.town , self.phoneNumber];
}

@end
