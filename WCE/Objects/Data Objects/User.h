//
//  User.h
//  WCE
//
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "Partner.h"

@interface User : NSObject

@property (nonatomic, retain) NSMutableArray * savedLocations; //should only hold Location objects!!!
@property (nonatomic, retain) NSMutableArray * savedPartners; //should only hold Partner objects!!! unneccessary?
@property (nonatomic, assign) BOOL loggedIn;
@property (nonatomic, assign) BOOL isEditingLocation;
@property (nonatomic, retain) Location *editingLocation;

@property (nonatomic, assign) BOOL isEditingPartner;
@property (nonatomic, retain) Partner *editingPartner;
@property (nonatomic, retain) Partner *sharedPartner;

+ (User *)sharedUser;

@end
