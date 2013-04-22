//
//  User.h
//  WCE
//
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface User : NSObject

@property (nonatomic, retain) NSMutableArray * savedLocations; //can only hold Location objects!!!
@property (nonatomic, assign) BOOL loggedIn;
@property (nonatomic, assign) BOOL isEditingLocation;
@property (nonatomic, retain) Location *editingLocation;

+ (User *)sharedUser;
@end
