//
//  CoverSheet.m
//  WCE
//
//  Created by  Brian Beckerle on 8/27/13.
//

#import "CoverSheet.h"

@implementation CoverSheet

-(id)init {
    self = [super init];
    if (self != nil) {
        // initialize stuff here
        self.coverSheetId = -1; //Cover sheet has not been assigned
    }
    
    return self;
}
@end
