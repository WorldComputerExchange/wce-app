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

- (void)sayLocation{
    NSLog(@"LOCATION SHARED METHOD");
}

@end
