//
//  Order.h
//  WCE
//
//  Created by  Brian Beckerle on 8/28/13.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject

@property (nonatomic, retain) NSString *q1;
@property (nonatomic, retain) NSString *q2_1;
@property (nonatomic, retain) NSString *q2_2;
@property (nonatomic, retain) NSString *q2_3;
@property (nonatomic, retain) NSString *q3;
@property (nonatomic, retain) NSString *q4_1;
@property (nonatomic, retain) NSString *q4_2;
@property (nonatomic, retain) NSString *q4_3;
@property (nonatomic, retain) NSString *q5_1;
@property (nonatomic, retain) NSString *q5_2;
@property (nonatomic, retain) NSString *q5_3;
@property (nonatomic, retain) NSString *q6_1;
@property (nonatomic, retain) NSString *q6_2;
@property (nonatomic, retain) NSString *q6_3;
@property (nonatomic, retain) NSString *q6_4;
@property (nonatomic, retain) NSString *q7_1;
@property (nonatomic, retain) NSString *q7_2;
@property (nonatomic, retain) NSString *q8;
@property (nonatomic, retain) NSString *q9;
@property (nonatomic, retain) NSString *q10;
@property (nonatomic, retain) NSString *q11;
@property (nonatomic, retain) NSString *q12;
@property (nonatomic, retain) NSString *q13_1;
@property (nonatomic, retain) NSString *q13_2;
@property (nonatomic, retain) NSString *q14;
@property (nonatomic, retain) NSString *q15;
@property (nonatomic, assign) NSInteger orderId;
@property (nonatomic, assign) NSInteger partnerId;

-(NSArray *)orderProperties;

@end
