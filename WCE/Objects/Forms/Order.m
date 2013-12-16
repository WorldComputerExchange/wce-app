//
//  Order.m
//  WCE
//
//  Created by  Brian Beckerle on 8/28/13.
//

#import "Order.h"

@implementation Order

-(id)init {
    self = [super init];
    if (self != nil) {
        // initialize stuff here
        self.orderId = -1; //order has not been assigned
    }
    
    return self;
}
@end
