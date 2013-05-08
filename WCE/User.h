//
//  User.h
//  WCE
//
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface User : NSObject

@property (nonatomic, retain) NSMutableArray * savedLocations; //can only hold Location objects!!!
@property (nonatomic, retain) NSMutableArray * savedPartners; //strings representing partner names!
@property (nonatomic, assign) BOOL loggedIn;
@property (nonatomic, assign) BOOL isEditingLocation;
@property (nonatomic, retain) Location *editingLocation;

@property (nonatomic, assign) BOOL isEditingPartner;
@property (nonatomic, retain) NSString *editingPartner;
@property (nonatomic, retain) NSString *sharedPartner;

+ (User *)sharedUser;
- (void)saveAllLocations;

@end
