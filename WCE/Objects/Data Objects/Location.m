//
//  Location.m
//  WCE
//
//

#import "Location.h"

@implementation Location

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
        self.zip = @"NA";
		self.annotation = nil;
        self.hasLocation = false;
    }
    
    return self;
}

- (NSArray *)locationProperties{
    return [NSArray arrayWithObjects:self.name, self.contact, self.phone, self.address, self.zip, self.city, self.country, self.language, nil];
}


@end
