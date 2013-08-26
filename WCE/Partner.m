//
//  Partner.m
//  WCE
//
//  Created by  Brian Beckerle on 8/24/13.
//

#import "Partner.h"

@implementation Partner
@synthesize name, partnerId, locationId;


-(id)init {
    self = [super init];
    if (self != nil) {
        // initialize stuff here
        self.name = @"NA";
    }
    
    return self;
}
@end
