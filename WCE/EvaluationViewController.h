//
//  EvaluationViewController.h
//  WCE
//
//  Created by  Brian Beckerle on 5/5/13.
//

#import <UIKit/UIKit.h>


@interface EvaluationViewController : UIViewController <UIActionSheetDelegate, UITextFieldDelegate, UITextViewDelegate>
{
    UIActionSheet *actionSheet;
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *efq1;
@property (weak, nonatomic) IBOutlet UITextField *efq2;
@property (weak, nonatomic) IBOutlet UITextField *efq3;
@property (weak, nonatomic) IBOutlet UITextField *efq4;
@property (weak, nonatomic) IBOutlet UITextField *efq5;
@property (weak, nonatomic) IBOutlet UITextField *efq6;
@property (weak, nonatomic) IBOutlet UITextField *efq7;
@property (weak, nonatomic) IBOutlet UITextField *efq8;
@property (weak, nonatomic) IBOutlet UISegmentedControl *efq9;
@property (weak, nonatomic) IBOutlet UITextField *efq10;
@property (weak, nonatomic) IBOutlet UITextField *efq11;
@property (weak, nonatomic) IBOutlet UITextField *efq12;
@property (weak, nonatomic) IBOutlet UITextField *efq13;
@property (weak, nonatomic) IBOutlet UITextField *efq14;
@property (weak, nonatomic) IBOutlet UISegmentedControl *efq15;
@property (weak, nonatomic) IBOutlet UISegmentedControl *efq16;
@property (weak, nonatomic) IBOutlet UISegmentedControl *efq17;
@property (weak, nonatomic) IBOutlet UITextField *efq18;
@property (weak, nonatomic) IBOutlet UITextView *efq19;
@property (weak, nonatomic) IBOutlet UITextView *efq20;
@property (weak, nonatomic) IBOutlet UITextView *efq21;
@property (weak, nonatomic) IBOutlet UITextView *efq22;
@property (weak, nonatomic) IBOutlet UITextView *efq23;
@property (weak, nonatomic) IBOutlet UITextView *efq24;
@property (weak, nonatomic) IBOutlet UITextView *efq25;
@property (weak, nonatomic) IBOutlet UITextView *efq26;
@property (weak, nonatomic) IBOutlet UITextView *efq27;
@property (weak, nonatomic) IBOutlet UITextView *efq28;

- (IBAction)backgroundTouched:(id)sender;
- (IBAction)textfieldReturn:(id)sender;

@end
