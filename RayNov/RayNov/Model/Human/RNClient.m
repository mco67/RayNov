#import "RNClient.h"


@interface RNClient ()

@end


@implementation RNClient

@synthesize displayName;

- (NSString*) displayName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}
@end
