//
//  User.m
//  WCE
//
//

#import "User.h"

@implementation User
@synthesize savedLocations, loggedIn;

static User* _sharedUser = nil;

+ (User *) sharedUser
{
    static User *sharedUser;
    
    @synchronized(self){
        
        if (!sharedUser)
            sharedUser = [[User alloc] init];
        
        return _sharedUser;
    }
    return nil;
}

+(id)alloc {
    @synchronized([User class]) {
        NSAssert(_sharedUser == nil, @"Attempted to allocate a second instance of a singleton.");
        _sharedUser = [super alloc];
        return _sharedUser;
    }
    return nil;
}

-(id)init {
    self = [super init];
    if (self != nil) {
        // initialize stuff here
        self.loggedIn = false;
        self.savedLocations = [[NSMutableArray alloc] init];
    }
    return self;
}



@end
