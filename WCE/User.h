//
//  User.h
//  WCE
//
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, retain) NSMutableArray * savedLocations; //can only hold Location objects!!!
@property (nonatomic, assign) BOOL loggedIn;

+ (User *)sharedUser;
@end
