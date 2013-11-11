//
//  ImplementationViewController.h
//  WCE
//
//

#import <UIKit/UIKit.h>
#import "Partner.h"
#import "ImpQuestions.h"

@interface ImplementationViewController : UIViewController <UIActionSheetDelegate, UITextFieldDelegate, UITextViewDelegate>
{
    UIActionSheet *actionSheet;
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *q1;
@property (weak, nonatomic) IBOutlet UITextField *q2;
@property (weak, nonatomic) IBOutlet UITextView *q3;
@property (weak, nonatomic) IBOutlet UITextView *q4;
@property (weak, nonatomic) IBOutlet UITextView *q5;
@property (weak, nonatomic) IBOutlet UITextField *q6;
@property (weak, nonatomic) IBOutlet UISegmentedControl *q7;
@property (weak, nonatomic) IBOutlet UITextView *q8;
@property (weak, nonatomic) IBOutlet UITextField *q9;
@property (weak, nonatomic) IBOutlet UITextView *q10;
@property (weak, nonatomic) IBOutlet UITextView *q11;
@property (weak, nonatomic) IBOutlet UITextView *q12;
@property (weak, nonatomic) IBOutlet UITextView *q13;
@property (weak, nonatomic) IBOutlet UITextView *q14;
@property (weak, nonatomic) IBOutlet UITextView *q15;
@property (weak, nonatomic) IBOutlet UITextView *q16;
@property (weak, nonatomic) IBOutlet UITextView *q17;
@property (weak, nonatomic) IBOutlet UITextView *q18;
@property (weak, nonatomic) IBOutlet UITextView *q19;
@property (weak, nonatomic) IBOutlet UITextView *q20;
@property (weak, nonatomic) IBOutlet UITextView *q21;
@property (weak, nonatomic) IBOutlet UITextView *q22;
@property (weak, nonatomic) IBOutlet UITextField *q23;
@property (weak, nonatomic) IBOutlet UISegmentedControl *q24;
@property (weak, nonatomic) IBOutlet UITextView *q25;
@property (nonatomic, retain) ImpQuestions *savedImpQues;
@property (nonatomic, retain) Partner *sharedPartner;
@property (nonatomic, assign) BOOL hasImpQues;


- (IBAction)backgroundTouched:(id)sender;
- (IBAction)textfieldReturn:(id)sender;

- (IBAction)saveChanges:(id)sender;
-(NSInteger)segmentIndexForString:(NSString *)string;
-(NSString *)stringForSegmentIndex:(NSInteger)segIndex;

@end
