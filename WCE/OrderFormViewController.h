//
//  OrderFormViewController.h
//  WCE
//
//  Created by Alex on 4/20/13.
//

#import <UIKit/UIKit.h>
#import "Location.h"



@interface OrderFormViewController : UIViewController <UIActionSheetDelegate, UITextFieldDelegate, UITextViewDelegate>
{
    UIActionSheet *actionSheet;
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (nonatomic, copy) UIActionSheet *actionSheet;



@property (weak, nonatomic) IBOutlet UISegmentedControl *ofq1;
@property (weak, nonatomic) IBOutlet UITextField *ofq2a;
@property (weak, nonatomic) IBOutlet UITextField *ofq2b;
@property (weak, nonatomic) IBOutlet UITextField *ofq2c;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ofq3;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ofq4a;
@property (weak, nonatomic) IBOutlet UITextField *ofq4b;
@property (weak, nonatomic) IBOutlet UITextField *ofq4c;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ofq5a;
@property (weak, nonatomic) IBOutlet UITextField *ofq5b;
@property (weak, nonatomic) IBOutlet UITextField *ofq5c;
@property (weak, nonatomic) IBOutlet UITextField *ofq6a;
@property (weak, nonatomic) IBOutlet UITextField *ofq6b;
@property (weak, nonatomic) IBOutlet UITextField *ofq6c;
@property (weak, nonatomic) IBOutlet UITextField *ofq6d;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ofq7a;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ofq7b;
@property (weak, nonatomic) IBOutlet UITextField *ofq8;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ofq9;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ofq10;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ofq11;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ofq12;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ofq13a;
@property (weak, nonatomic) IBOutlet UITextView *ofq13b;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ofq14;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ofq15;


- (IBAction)backgroundTouched:(id)sender;
- (IBAction)textfieldReturn:(id)sender;
//- (IBAction)textviewReturn:(id)sender;



@end
