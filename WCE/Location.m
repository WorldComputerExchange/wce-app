//
//  Location.m
//  WCE
//
//

#import "Location.h"

@implementation Location
@synthesize name, contact, phone, address, city, country, language, hasLocation;

static Location* _sharedLocation = nil;


+ (Location *) sharedLocation
 {
     return _sharedLocation;
 }

+ (void) initialize
{
    _sharedLocation = [[Location alloc] init];
}


-(id)init {
    self = [super init];
    if (self != nil) {
        // initialize stuff here
        self.name = @"NA";
        self.contact = @"NA";
        self.phone = @"NA";
        self.address = @"NA";
        self.city = @"NA";
        self.country =@"NA";
        self.language = @"NA";
        self.hasLocation = false;
    }
    
    return self;
}


@end
