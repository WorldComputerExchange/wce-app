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
    static Location *sharedLocation;
        
    @synchronized(self){
        
        if (!sharedLocation)
            sharedLocation = [[Location alloc] init];
        
        return _sharedLocation;
    }
    return nil;
}

/*+(id)alloc {
    @synchronized([Location class]) {
        NSAssert(_sharedLocation == nil, @"Attempted to allocate a second instance of a singleton.");
        _sharedLocation = [super alloc];
        return _sharedLocation;
    }
    return nil;
}*/

-(id)init {
    self = [super init];
    if (self != nil) {
        // initialize stuff here
        self.country = @"NA";
        self.language = @"NA";
        self.name = @"NA";
        self.hasLocation = false;
    }
    return self;
}


@end
