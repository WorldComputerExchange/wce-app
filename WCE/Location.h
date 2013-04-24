//
//  Location.h
//  WCE
//
//

#import <Foundation/Foundation.h>
#import "AddressAnnotation.h"

@interface Location : NSObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * contact;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) AddressAnnotation *annotation;
@property (nonatomic, assign) BOOL hasLocation;

+ (Location *)sharedLocation;
+ (void) initialize;
@end
