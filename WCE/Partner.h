//
//  Partner.h
//  WCE
//
//  Created by  Brian Beckerle on 8/24/13.
//

#import <Foundation/Foundation.h>

@interface Partner : NSObject

@property (nonatomic, assign) NSInteger partnerId;
@property (nonatomic, assign) NSInteger locationId;
@property (nonatomic, retain) NSString * name;

@end
