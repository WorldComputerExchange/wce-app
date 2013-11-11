//
//  ImplementationViewController.m
//  WCE
//
//

#import "ImplementationViewController.h"
#import "User.h" 
#import "DataAccess.h" 

@interface ImplementationViewController ()

@end

@implementation ImplementationViewController




@synthesize q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, sharedPartner, savedImpQues, hasImpQues;



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
    [q2 resignFirstResponder];
    [q3 resignFirstResponder];
    [q4 resignFirstResponder];
    [q5 resignFirstResponder];
    [q6 resignFirstResponder];
    [q7 resignFirstResponder];
    [q8 resignFirstResponder];
    [q9 resignFirstResponder];
    [q10 resignFirstResponder];
    [q11 resignFirstResponder];
    [q12 resignFirstResponder];
    [q13 resignFirstResponder];
    [q14 resignFirstResponder];
    [q15 resignFirstResponder];
    [q16 resignFirstResponder];
    [q17 resignFirstResponder];
    [q18 resignFirstResponder];
    [q19 resignFirstResponder];
    [q20 resignFirstResponder];
    [q21 resignFirstResponder];
    [q22 resignFirstResponder];
    [q23 resignFirstResponder];
    [q24 resignFirstResponder];
    [q25 resignFirstResponder];    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    //get the impQuestions for the current partner if it exists
    User *sharedUser = [User sharedUser];
    
    sharedPartner = [sharedUser sharedPartner];
    
    DataAccess *db = [[DataAccess alloc] init];
    
    savedImpQues = [[ImpQuestions alloc] init];
    savedImpQues = [db getImpForPartner:sharedPartner];
    
    if (savedImpQues.impId < 0) { //no cover sheet found
        hasImpQues = false;
    }else {
        hasImpQues= true;
        self.q1.text = savedImpQues.q1;
        self.q2.text = savedImpQues.q2;
        self.q3.text = savedImpQues.q3;
        self.q4.text = savedImpQues.q4;
        self.q5.text = savedImpQues.q5;
        self.q6.text = savedImpQues.q6;
        self.q7.selectedSegmentIndex = [self segmentIndexForString:savedImpQues.q7];
        self.q8.text = savedImpQues.q8;
        self.q9.text = savedImpQues.q9;
        self.q10.text = savedImpQues.q10;
        self.q11.text = savedImpQues.q11;
        self.q12.text = savedImpQues.q12;
        self.q13.text = savedImpQues.q13;
        self.q14.text = savedImpQues.q14;
        self.q15.text = savedImpQues.q15;
        self.q16.text = savedImpQues.q16;
        self.q17.text = savedImpQues.q17;
        self.q18.text = savedImpQues.q18;
        self.q19.text = savedImpQues.q19;
        self.q20.text = savedImpQues.q20;
        self.q21.text = savedImpQues.q21;
        self.q22.text = savedImpQues.q22;
        self.q23.text = savedImpQues.q23;
        self.q24.selectedSegmentIndex = [self segmentIndexForString:savedImpQues.q24];
        self.q25.text = savedImpQues.q25;
    }
    
    
}



- (IBAction)saveChanges:(id)sender{
    NSLog(@"Saving changes to impQuestions");
    
    ImpQuestions *curImpQues =[[ImpQuestions alloc] init];
    
    curImpQues.partnerId = [sharedPartner partnerId];
    
    curImpQues.q1 = self.q1.text;
    curImpQues.q2 = self.q2.text;
    curImpQues.q3 = self.q3.text;
    curImpQues.q4 = self.q4.text;
    curImpQues.q5 = self.q5.text;
    curImpQues.q6 = self.q6.text;
    curImpQues.q7 = [self stringForSegmentIndex:self.q7.selectedSegmentIndex];
    curImpQues.q8 = self.q8.text;
    curImpQues.q9 = self.q9.text;
    curImpQues.q10 = self.q10.text;
    curImpQues.q11 = self.q11.text;
    curImpQues.q12 = self.q12.text;
    curImpQues.q13 = self.q13.text;
    curImpQues.q14 = self.q14.text;
    curImpQues.q15 = self.q15.text;
    curImpQues.q16 = self.q16.text;
    curImpQues.q17 = self.q17.text;
    curImpQues.q18 = self.q18.text;
    curImpQues.q19 = self.q19.text;
    curImpQues.q20 = self.q20.text;
    curImpQues.q21 = self.q21.text;
    curImpQues.q22 = self.q22.text;
    curImpQues.q23 = self.q23.text;
    curImpQues.q24 = [self stringForSegmentIndex:self.q24.selectedSegmentIndex];
    curImpQues.q25 = self.q25.text;
    
    DataAccess *db = [[DataAccess alloc] init];
    
    if (!hasImpQues){
        [db insertImp:curImpQues];
    }else{
        curImpQues.impId = savedImpQues.impId;
        [db updateImp:curImpQues];
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
