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
        self.q1 = @"";
        self.q2_1 = @"";
        self.q2_2 = @"";
        self.q2_3 = @"";
        self.q3 = @"";
        self.q4_1 = @"";
        self.q4_2 = @"";
        self.q4_3 = @"";
        self.q5_1 = @"";
        self.q5_2 = @"";
        self.q5_3 = @"";
        self.q6_1 = @"";
        self.q6_2 = @"";
        self.q6_3 = @"";
        self.q6_4 = @"";
        self.q7_1 = @"";
        self.q7_2 = @"";
        self.q8 = @"";
        self.q9 = @"";
        self.q10 = @"";
        self.q11 = @"";
        self.q12 = @"";
        self.q13_1 = @"";
        self.q13_2 = @"";
        self.q14 = @"";
        self.q15 = @"";
    }
    
    return self;
}

-(NSArray *)orderProperties{
    return [NSArray arrayWithObjects:self.q1, self.q2_1, self.q2_2, self.q2_3,
            self.q3, self.q4_1, self.q4_2, self.q4_3, self.q5_1, self.q5_2,
            self.q5_3, self.q6_1, self.q6_2, self.q6_3, self.q6_4, self.q7_1,
            self.q7_2, self.q8, self.q9, self.q10, self.q11, self.q12, self.q13_1,
            self.q13_2, self.q14, self.q15, nil];
}

@end
