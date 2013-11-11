//
//  OrderFormViewController.m
//  WCE
//
//  Created by Alex on 4/20/13.
//

#import "OrderFormViewController.h"
#import "DataAccess.h"
#import "User.h"

@interface OrderFormViewController ()

@end

@implementation OrderFormViewController





@synthesize q1, q2_1, q2_2, q2_3, q3, q4_1, q4_2, q4_3, q5_1, q5_2, q5_3, q6_1, q6_2, q6_3, q6_4, q7_1, q7_2, q8, q9, q10, q11, q12, q13_1, q13_2, q14, q15, sharedPartner, savedOrder, hasOrder;



//FROM TUTORIAL Cocoa W/Love; need the following instance variables
CGFloat animatedDistance;
//FROM TUTORIAL Cocoa W/Love; need the following instance constants
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

- (IBAction)backgroundTouched:(id)sender {
    [q1 resignFirstResponder];
    [q2_1 resignFirstResponder];
    [q2_2 resignFirstResponder];
    [q2_3 resignFirstResponder];
    [q3 resignFirstResponder];
    [q4_1 resignFirstResponder];
    [q4_2 resignFirstResponder];
    [q4_3 resignFirstResponder];
    [q5_1 resignFirstResponder];
    [q5_2 resignFirstResponder];
    [q5_3 resignFirstResponder];
    [q6_1 resignFirstResponder];
    [q6_2 resignFirstResponder];
    [q6_3 resignFirstResponder];
    [q6_4 resignFirstResponder];
    [q7_1 resignFirstResponder];
    [q7_2 resignFirstResponder];
    [q8 resignFirstResponder];
    [q9 resignFirstResponder];
    [q10 resignFirstResponder];
    [q11 resignFirstResponder];
    [q12 resignFirstResponder];
    [q13_1 resignFirstResponder];
    [q13_2 resignFirstResponder];
    [q14 resignFirstResponder];
    [q15 resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    //get the impQuestions for the current partner if it exists
    User *sharedUser = [User sharedUser];
    
    sharedPartner = [sharedUser sharedPartner];
    
    DataAccess *db = [[DataAccess alloc] init];
    
    savedOrder = [[Order alloc] init];
    savedOrder = [db getOrderForPartner:sharedPartner];
    
    if (savedOrder.orderId < 0) { //no cover sheet found
        hasOrder = false;
    }else {
        hasOrder = true;
        self.q1.selectedSegmentIndex = [self segmentIndexForString:savedOrder.q1];
        self.q2_1.text = savedOrder.q2_1;
        self.q2_2.text = savedOrder.q2_2;
        self.q2_3.text = savedOrder.q2_3;
        self.q3.selectedSegmentIndex = [self segmentIndexForString:savedOrder.q3];
        self.q4_1.selectedSegmentIndex = [self segmentIndexForString:savedOrder.q4_1];
        self.q4_2.text = savedOrder.q4_2;
        self.q4_3.text = savedOrder.q4_3;
        self.q5_1.selectedSegmentIndex = [self segmentIndexForString:savedOrder.q5_1];
        self.q5_2.text = savedOrder.q5_2;
        self.q5_3.text = savedOrder.q5_3;
        self.q6_1.text = savedOrder.q6_1;
        self.q6_2.text = savedOrder.q6_2;
        self.q6_3.text = savedOrder.q6_4;
        self.q6_4.text = savedOrder.q6_4;
        self.q7_1.selectedSegmentIndex = [self segmentIndexForString:savedOrder.q7_1];
        self.q7_2.selectedSegmentIndex = [self segmentIndexForString:savedOrder.q7_2];
        self.q8.text = savedOrder.q8;
        self.q9.selectedSegmentIndex = [self segmentIndexForString:savedOrder.q9];
        self.q10.selectedSegmentIndex = [self segmentIndexForString:savedOrder.q10];
        self.q11.selectedSegmentIndex = [self segmentIndexForString:savedOrder.q11];
        self.q12.selectedSegmentIndex = [self segmentIndexForString:savedOrder.q12];
        self.q13_1.selectedSegmentIndex = [self segmentIndexForString:savedOrder.q13_1];
        self.q13_2.text = savedOrder.q13_2;
        self.q14.selectedSegmentIndex = [self segmentIndexForString:savedOrder.q14];
        self.q15.selectedSegmentIndex = [self segmentIndexForString:savedOrder.q15];
    }
    
    
}

- (IBAction)saveChanges:(id)sender{
    NSLog(@"Saving changes to impQuestions");
    
    Order *curOrder =[[Order alloc] init];
    
    curOrder.partnerId = [sharedPartner partnerId];
    
    curOrder.q1 = [self stringForSegmentIndex:self.q1.selectedSegmentIndex];
    curOrder.q2_1 = self.q2_1.text;
    curOrder.q2_2 = self.q2_2.text;
    curOrder.q2_3 = self.q2_3.text;
    curOrder.q3 = [self stringForSegmentIndex:self.q3.selectedSegmentIndex];
    curOrder.q4_1 = [self stringForSegmentIndex:self.q4_1.selectedSegmentIndex];
    curOrder.q4_2 = self.q4_2.text;
    curOrder.q4_3 = self.q4_3.text;
    curOrder.q5_1 = [self stringForSegmentIndex:self.q5_1.selectedSegmentIndex];
    curOrder.q5_2 = self.q5_2.text;
    curOrder.q5_3 = self.q5_3.text;
    curOrder.q6_1 = self.q6_1.text;
    curOrder.q6_2 = self.q6_2.text;
    curOrder.q6_3 = self.q6_3.text;
    curOrder.q6_4 = self.q6_4.text;
    curOrder.q7_1 = [self stringForSegmentIndex:self.q7_1.selectedSegmentIndex];
    curOrder.q7_2 = [self stringForSegmentIndex:self.q7_2.selectedSegmentIndex];
    curOrder.q8 = self.q8.text;
    curOrder.q9 = [self stringForSegmentIndex:self.q9.selectedSegmentIndex];
    curOrder.q10 = [self stringForSegmentIndex:self.q10.selectedSegmentIndex];
    curOrder.q11 = [self stringForSegmentIndex:self.q11.selectedSegmentIndex];
    curOrder.q12 = [self stringForSegmentIndex:self.q12.selectedSegmentIndex];
    curOrder.q13_1 = [self stringForSegmentIndex:self.q13_1.selectedSegmentIndex];
    curOrder.q13_2 = self.q13_2.text;
    curOrder.q14 = [self stringForSegmentIndex:self.q14.selectedSegmentIndex];
    curOrder.q15 = [self stringForSegmentIndex:self.q15.selectedSegmentIndex];
    
    DataAccess *db = [[DataAccess alloc] init];
    
    if (!hasOrder){
        [db insertOrder:curOrder];
    }else{
        curOrder.orderId = savedOrder.orderId;
        [db updateOrder:curOrder];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

//return the correct segment (YES or NO) for the given string
-(NSInteger)segmentIndexForString:(NSString *)string{
    if([[string lowercaseString] characterAtIndex:0] == 'y'){
        return 0;
    }else{
        return 1;
    }
}

//return YES or NO depending on segment index
-(NSString *)stringForSegmentIndex:(NSInteger)segIndex{
    if(segIndex == 0){
        return @"YES";
    }else{
        return @"NO";
    }
}







/**Keyboard dismissed when background is clicked or when return is hit**/

- (IBAction)textfieldReturn:(id)sender{
    [sender resignFirstResponder];
}
- (IBAction)textviewReturn:(id)sender{
    [sender resignFirstResponder];
}





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





//FROM TUTORIAL: www.cocoawithlove.com/2008/10/sliding-uitextfields-around-to-avoid.html

//Animate upwards when the text field is selected
//Get the rects of the text field being edited and the view that we're going to scroll. We convert everything to window coordinates, since they're not necessarily in the same coordinate space.
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFieldRect =
    [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    //So now we have the bounds, we need to calculate the fraction between the top and bottom of the middle section for the text field's midline:
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    
    //Clamp this fraction so that the top section is all "0.0" and the bottom section is all "1.0".
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    
    //Now take this fraction and convert it into an amount to scroll by multiplying by the keyboard height for the current screen orientation. Notice the calls to floor so that we only scroll by whole pixel amounts.
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    
    //Finally, apply the animation. Note the use of setAnimationBeginsFromCurrentState: — this will allow a smooth transition to new text field if the user taps on another.
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}


//ANIMATE BACK AGAIN:  The return animation is far simpler since we've saved the amount to animate.
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

//dismisses the keyboard when the return/done button is pressed for TextFields.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//dismisses the keyboard when the return/done button is pressed for TextViews.
- (BOOL)textViewShouldReturn:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}



//SAME CODE AS ABOVE, BUT FOR TEXTVIEW
//FROM TUTORIAL: www.cocoawithlove.com/2008/10/sliding-uitextfields-around-to-avoid.html

//Animate upwards when the text field is selected
//Get the rects of the text field being edited and the view that we're going to scroll. We convert everything to window coordinates, since they're not necessarily in the same coordinate space.
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    CGRect textFieldRect =
    [self.view.window convertRect:textView.bounds fromView:textView];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    //So now we have the bounds, we need to calculate the fraction between the top and bottom of the middle section for the text field's midline:
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    
    //Clamp this fraction so that the top section is all "0.0" and the bottom section is all "1.0".
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    
    //Now take this fraction and convert it into an amount to scroll by multiplying by the keyboard height for the current screen orientation. Notice the calls to floor so that we only scroll by whole pixel amounts.
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    
    //Finally, apply the animation. Note the use of setAnimationBeginsFromCurrentState: — this will allow a smooth transition to new text field if the user taps on another.
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}


//ANIMATE BACK AGAIN:  The return animation is far simpler since we've saved the amount to animate.
- (void)textViewDidEndEditing:(UITextView *)textView
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}









@end
