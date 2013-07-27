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

- (IBAction)backgroundTouched:(id)sender;
- (IBAction)textfieldReturn:(id)sender;



//- (IBAction)cancelChanges:(id)sender;
//- (IBAction)saveChanges:(id)sender;

@end
