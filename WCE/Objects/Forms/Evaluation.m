//
//  Evaluation.m
//  WCE
//
//  Created by  Brian Beckerle on 8/28/13.
//

#import "Evaluation.h"

@implementation Evaluation

-(id)init {
    self = [super init];
    if (self != nil) {
        // initialize stuff here
        self.evalId = -1; //-1 says evalForm has not been assigned
    }
    
    return self;
}

@end
