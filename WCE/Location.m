//
//  Location.m
//  WCE
//
//

#import "Location.h"

@implementation Location
@dynamic region, country, language, name, hasLocation;

static Location* _sharedLocation = nil;

+ (Location *) sharedLocation
{
    static Location *sharedLocation;
        
    @synchronized(self){
        
        if (!sharedLocation)
            sharedLocation = [[Location alloc] init];
            return _sharedLocation;
    }
}

+(id)alloc {
    @synchronized([Location class]) {
        NSAssert(_sharedLocation == nil, @"Attempted to allocate a second instance of a singleton.");
        _sharedLocation = [super alloc];
        return _sharedLocation;
    }
    return nil;
}

-(id)init {
    self = [super init];
    if (self != nil) {
        // initialize stuff here
        self.region = @"NA";
        self.country = @"NA";
        self.language = @"NA";
        self.name = @"NA";
        self.hasLocation = false;
    }
    return self;
}

- (void)sayLocation{
    NSLog(@"Location of shared instance is %@", [[self sharedLocation] region]);
}

@end
