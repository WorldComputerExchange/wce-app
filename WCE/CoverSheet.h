//
//  CoverSheet.h
//  WCE
//
//  Created by  Brian Beckerle on 8/27/13.
//Please work!!

#import <Foundation/Foundation.h>

@interface CoverSheet : NSObject
@property (nonatomic, retain) NSString *q1;
@property (nonatomic, retain) NSString *q2;
@property (nonatomic, retain) NSString *q3;
@property (nonatomic, retain) NSString *q4;
@property (nonatomic, retain) NSString *q5;
@property (nonatomic, retain) NSString *q6;
@property (nonatomic, assign) NSInteger coverSheetId;
@property (nonatomic, assign) NSInteger partnerId;

@end
