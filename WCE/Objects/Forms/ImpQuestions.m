//
//  ImpQuestions.m
//  WCE
//
//  Created by  Brian Beckerle on 8/28/13.
//

#import "ImpQuestions.h"

@implementation ImpQuestions

-(id)init {
    self = [super init];
    if (self != nil) {
        // initialize stuff here
        self.impId = -1; //impQuestions has not been assigned
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
        self.q12 = @"";
        self.q13 = @"";
        self.q14 = @"";
        self.q15 = @"";
        self.q16= @"";
        self.q17 = @"";
        self.q18 = @"";
        self.q19 = @"";
        self.q20 = @"";
        self.q21 = @"";
        self.q22 = @"";
        self.q23 = @"";
        self.q24 = @"";
        self.q25 = @"";
    }
    
    return self;
}

-(NSArray *)impProperties{
    return [NSArray arrayWithObjects:self.q1, self.q2, self.q3, self.q4, self.q5,
            self.q6, self.q7, self.q8, self.q9, self.q10, self.q11, self.q12,
            self.q13, self.q14, self.q15, self.q16, self.q17, self.q18, self.q19,
            self.q20, self.q21, self.q22, self.q23, self.q24, self.q25, nil];
}

@end
