//
//  OrderFormViewController.h
//  WCE
//
//  Created by Alex on 4/20/13.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "Order.h"
#import "Partner.h"



@interface OrderFormViewController : UITableViewController <UIActionSheetDelegate, UITextFieldDelegate, UITextViewDelegate>
{
    UIActionSheet *actionSheet;
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *q1;
@property (weak, nonatomic) IBOutlet UITextField *q2_1;
@property (weak, nonatomic) IBOutlet UITextField *q2_2;
@property (weak, nonatomic) IBOutlet UITextField *q2_3;
@property (weak, nonatomic) IBOutlet UISegmentedControl *q3;
@property (weak, nonatomic) IBOutlet UISegmentedControl *q4_1;
@property (weak, nonatomic) IBOutlet UITextField *q4_2;
@property (weak, nonatomic) IBOutlet UITextField *q4_3;
@property (weak, nonatomic) IBOutlet UISegmentedControl *q5_1;
@property (weak, nonatomic) IBOutlet UITextField *q5_2;
@property (weak, nonatomic) IBOutlet UITextField *q5_3;
@property (weak, nonatomic) IBOutlet UITextField *q6_1;
@property (weak, nonatomic) IBOutlet UITextField *q6_2;
@property (weak, nonatomic) IBOutlet UITextField *q6_3;
@property (weak, nonatomic) IBOutlet UITextField *q6_4;
@property (weak, nonatomic) IBOutlet UISegmentedControl *q7_1;
@property (weak, nonatomic) IBOutlet UISegmentedControl *q7_2;
@property (weak, nonatomic) IBOutlet UITextField *q8;
@property (weak, nonatomic) IBOutlet UISegmentedControl *q9;
@property (weak, nonatomic) IBOutlet UISegmentedControl *q10;
@property (weak, nonatomic) IBOutlet UISegmentedControl *q11;
@property (weak, nonatomic) IBOutlet UISegmentedControl *q12;
@property (weak, nonatomic) IBOutlet UISegmentedControl *q13_1;
@property (weak, nonatomic) IBOutlet UITextView *q13_2;
@property (weak, nonatomic) IBOutlet UISegmentedControl *q14;
@property (weak, nonatomic) IBOutlet UISegmentedControl *q15;
@property (nonatomic, retain) Order *savedOrder;
@property (nonatomic, retain) Partner *sharedPartner;
@property (nonatomic, assign) BOOL hasOrder;

- (IBAction)backgroundTouched:(id)sender;
- (IBAction)textfieldReturn:(id)sender;

- (IBAction)saveChanges:(id)sender;
-(NSInteger)segmentIndexForString:(NSString *)string;
-(NSString *)stringForSegmentIndex:(NSInteger)segIndex;



@end
