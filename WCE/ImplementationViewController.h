//
//  ImplementationViewController.h
//  WCE
//
//

#import <UIKit/UIKit.h>


@interface ImplementationViewController : UIViewController <UIActionSheetDelegate, UITextFieldDelegate, UITextViewDelegate>
{
    UIActionSheet *actionSheet;
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (nonatomic, copy) UIActionSheet *actionSheet;

@property (weak, nonatomic) IBOutlet UITextField *iqq1;
@property (weak, nonatomic) IBOutlet UITextField *iqq2;
@property (weak, nonatomic) IBOutlet UITextView *iqq3;
@property (weak, nonatomic) IBOutlet UITextView *iqq4;
@property (weak, nonatomic) IBOutlet UITextView *iqq5;
@property (weak, nonatomic) IBOutlet UITextField *iqq6;
@property (weak, nonatomic) IBOutlet UISegmentedControl *iqq7;
@property (weak, nonatomic) IBOutlet UITextView *iqq8;
@property (weak, nonatomic) IBOutlet UITextField *iqq9;
@property (weak, nonatomic) IBOutlet UITextView *iqq10;
@property (weak, nonatomic) IBOutlet UITextView *iqq11;
@property (weak, nonatomic) IBOutlet UITextView *iqq12;
@property (weak, nonatomic) IBOutlet UITextView *iqq13;
@property (weak, nonatomic) IBOutlet UITextView *iqq14;
@property (weak, nonatomic) IBOutlet UITextView *iqq15;
@property (weak, nonatomic) IBOutlet UITextView *iqq16;
@property (weak, nonatomic) IBOutlet UITextView *iqq17;
@property (weak, nonatomic) IBOutlet UITextView *iqq18;
@property (weak, nonatomic) IBOutlet UITextView *iqq19;
@property (weak, nonatomic) IBOutlet UITextView *iqq20;
@property (weak, nonatomic) IBOutlet UITextView *iqq21;
@property (weak, nonatomic) IBOutlet UITextView *iqq22;
@property (weak, nonatomic) IBOutlet UITextField *iqq23;
@property (weak, nonatomic) IBOutlet UISegmentedControl *iqq24;
@property (weak, nonatomic) IBOutlet UITextView *iqq25;

- (IBAction)backgroundTouched:(id)sender;
- (IBAction)textfieldReturn:(id)sender;
//- (IBAction)textviewReturn:(id)sender;



//- (IBAction)cancelChanges:(id)sender;
//- (IBAction)saveChanges:(id)sender;

@end
