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
        self.q1 = @"";
        self.q2 = @"";
        self.q3 = @"";
        self.q4 = @"";
        self.q5 = @"";
        self.q6 = @"";
        self.q7 = @"";
        self.q8 = @"";
        self.q9 = @"";
        self.q10 = @"";
        self.q11 = @"";
        self.q12_1 = @"";
        self.q12_2 = @"";
        self.q13_1 = @"";
        self.q13_2 = @"";
        self.q14 = @"";
        self.q15 = @"";
        self.q16_1 = @"";
        self.q16_2 = @"";
        self.q17 = @"";
    }
    
    return self;
}


-(NSArray *)coverSheetproperties{
    return [NSArray arrayWithObjects:self.q1, self.q2, self.q3, self.q4, self.q5,
            self.q6, self.q7, self.q8, self.q9, self.q10, self.q11, self.q12_1,
            self.q12_2, self.q13_1, self.q13_2, self.q14, self.q15, self.q16_1, self.q16_2,
            self.q17, nil];
}

@end
