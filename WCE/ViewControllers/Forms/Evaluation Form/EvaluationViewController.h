//
//  EvaluationViewController.h
//  WCE
//
//  Created by  Brian Beckerle on 5/5/13.
//

#import <UIKit/UIKit.h>
#import "Evaluation.h"
#import "Location.h"


@interface EvaluationViewController : UITableViewController <UIActionSheetDelegate, UITextFieldDelegate, UITextViewDelegate>
{
    UIActionSheet *actionSheet;    
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *q1;
@property (weak, nonatomic) IBOutlet UITextField *q2;
@property (weak, nonatomic) IBOutlet UITextField *q3;
@property (weak, nonatomic) IBOutlet UITextField *q4;
@property (weak, nonatomic) IBOutlet UITextField *q5;
@property (weak, nonatomic) IBOutlet UITextField *q6;
@property (weak, nonatomic) IBOutlet UITextField *q7;
@property (weak, nonatomic) IBOutlet UITextField *q8;
@property (weak, nonatomic) IBOutlet UISegmentedControl *q9; //Yes = 0, No = 1
@property (weak, nonatomic) IBOutlet UITextField *q10;
@property (weak, nonatomic) IBOutlet UITextField *q11;
@property (weak, nonatomic) IBOutlet UITextField *q12;
@property (weak, nonatomic) IBOutlet UITextField *q13;
@property (weak, nonatomic) IBOutlet UITextField *q14;
@property (weak, nonatomic) IBOutlet UISegmentedControl *q15;
@property (weak, nonatomic) IBOutlet UISegmentedControl *q16;
@property (weak, nonatomic) IBOutlet UISegmentedControl *q17;
@property (weak, nonatomic) IBOutlet UITextField *q18;
@property (weak, nonatomic) IBOutlet UITextView *q19;
@property (weak, nonatomic) IBOutlet UITextView *q20;
@property (weak, nonatomic) IBOutlet UITextView *q21;
@property (weak, nonatomic) IBOutlet UITextView *q22;
@property (weak, nonatomic) IBOutlet UITextView *q23;
@property (weak, nonatomic) IBOutlet UITextView *q24;
@property (weak, nonatomic) IBOutlet UITextView *q25;
@property (weak, nonatomic) IBOutlet UITextView *q26;
@property (weak, nonatomic) IBOutlet UITextView *q27;
@property (weak, nonatomic) IBOutlet UITextView *q28;
@property (nonatomic, retain) Evaluation *savedEvalForm;
@property (nonatomic, retain) Location *sharedLocation;
@property (nonatomic, assign) BOOL hasEvalForm;

- (IBAction)backgroundTouched:(id)sender;
- (IBAction)textfieldReturn:(id)sender;
- (IBAction)saveChanges:(id)sender; 

-(NSInteger)segmentIndexForString:(NSString *)string;
-(NSString *)stringForSegmentIndex:(NSInteger)segIndex;

@end
