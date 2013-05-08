//
//  User.m
//  WCE
//
//

#import "User.h"
#import "Location.h"

@implementation User
@synthesize savedLocations, savedPartners, loggedIn, isEditingLocation, editingLocation, sharedPartner;

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
        self.savedPartners = [[NSMutableArray alloc] init];
        self.isEditingLocation = false;
        self.editingLocation = [[Location alloc] init];
        self.isEditingPartner = false;
        self.editingPartner = @"";
		
		// retrieve saved locations from NSUserDefaults
		NSArray *locations = [[NSUserDefaults standardUserDefaults] objectForKey:@"locations"];
		if([locations count] > 0)
		{
			for(int i = 0; i < [locations count]; i++)
			{
				Location *loc = [[Location alloc] init];
				NSDictionary *dict = [locations objectAtIndex:i];
				
				loc.name = [dict objectForKey:@"name"];
				loc.contact = [dict objectForKey:@"contact"];
				loc.phone = [dict objectForKey:@"phone"];
				loc.address = [dict objectForKey:@"address"];
				loc.city = [dict objectForKey:@"city"];
				loc.country = [dict objectForKey:@"country"];
				loc.language = [dict objectForKey:@"language"];
				loc.zip = [dict objectForKey:@"zip"];
				
				[savedLocations addObject:loc];
			}
		}
    }
    return self;
}

- (void)saveAllLocations
{
	// save to NSUserDefaults
	NSMutableArray *locations = [[NSMutableArray alloc] initWithCapacity:[savedLocations count]];
	
	for(Location *loc in savedLocations)
	{
		NSDictionary *location = [[NSDictionary alloc] initWithObjectsAndKeys:[loc name], @"name", [loc contact], @"contact", [loc phone], @"phone", [loc address], @"address", [loc city], @"city", [loc country], @"country", [loc language], @"language", [loc zip], @"zip", nil];
		[locations addObject:location];
	}
	
	[[NSUserDefaults standardUserDefaults] setObject:locations forKey:@"locations"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}


@end
