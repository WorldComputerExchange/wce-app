//
//  Location.h
//  WCE
//
//

#import <Foundation/Foundation.h>

@interface Location : NSObject


@property (nonatomic, retain) NSString * region;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, assign) BOOL hasLocation;

+ (Location *)sharedLocation;

-(void)sayLocation;

@end
