//
//  EvaluationViewController.m
//  WCE
//
//  Created by  Brian Beckerle on 5/5/13.
//

#import "EvaluationViewController.h"
#import "Location.h"
#import "DataAccess.h"

@interface EvaluationViewController ()
@property (nonatomic, readonly) CGPoint originalOffset;
@property (nonatomic, readonly) UIView *activeField;
@end

@implementation EvaluationViewController


//FROM TUTORIAL Cocoa W/Love; need the following instance variables
CGFloat animatedDistance;
//FROM TUTORIAL Cocoa W/Love; need the following instance constants
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void) viewWillDisappear: (BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self name: UIKeyboardWillShowNotification object:nil];
    [nc removeObserver:self name: UIKeyboardWillHideNotification object:nil];
}





- (void)viewWillAppear:(BOOL)animated
{
	//[[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.gif"]]];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    self.evalTableView.backgroundView = backgroundImageView;
    
    //get the coversheet for the current partner from the database if it exists
    self.sharedLocation = [Location sharedLocation];
    
    DataAccess *db = [[DataAccess alloc] init];
    
    self.savedEvalForm = [[Evaluation alloc] init];
    self.savedEvalForm = [db getEvalForLocation:self.sharedLocation];
    
    if (self.savedEvalForm.evalId < 0) { //no cover sheet found
        self.hasEvalForm = false;
    }else {
        self.hasEvalForm = true;
        self.q1.text = self.savedEvalForm.q1;
        self.q2.text = self.savedEvalForm.q2;
        self.q3.text = self.savedEvalForm.q3;
        self.q4.text = self.savedEvalForm.q4;
        self.q5.text = self.savedEvalForm.q5;
        self.q6.text = self.savedEvalForm.q6;
        self.q7.text = self.savedEvalForm.q7;
        self.q8.text = self.savedEvalForm.q8;
        self.q9.selectedSegmentIndex = [self segmentIndexForString:self.savedEvalForm.q9];
        self.q10.text = self.savedEvalForm.q10;
        self.q11.text = self.savedEvalForm.q11;
        self.q12.text = self.savedEvalForm.q12;
        self.q13.text = self.savedEvalForm.q13;
        self.q14.text = self.savedEvalForm.q14;
        self.q15.selectedSegmentIndex = [self segmentIndexForString:self.savedEvalForm.q15];
        self.q16.selectedSegmentIndex = [self segmentIndexForString:self.savedEvalForm.q16];
        self.q17.selectedSegmentIndex = [self segmentIndexForString:self.savedEvalForm.q17];
        self.q18.text = self.savedEvalForm.q18;
        self.q19.text = self.savedEvalForm.q19;
        self.q20.text = self.savedEvalForm.q20;
        self.q21.text = self.savedEvalForm.q21;
        self.q22.text = self.savedEvalForm.q22;
        self.q23.text = self.savedEvalForm.q23;
        self.q24.text = self.savedEvalForm.q24;
        self.q25.text = self.savedEvalForm.q25;
        self.q26.text = self.savedEvalForm.q26;
        self.q27.text = self.savedEvalForm.q27;
        self.q28.text = self.savedEvalForm.q28;
    }
    
    
}

- (IBAction)backgroundTouched:(id)sender {
    [self.q1 resignFirstResponder];
    [self.q2 resignFirstResponder];
    [self.q3 resignFirstResponder];
    [self.q4 resignFirstResponder];
    [self.q5 resignFirstResponder];
    [self.q6 resignFirstResponder];
    [self.q7 resignFirstResponder];
    [self.q8 resignFirstResponder];
    [self.q9 resignFirstResponder];
    [self.q10 resignFirstResponder];
    [self.q11 resignFirstResponder];
    [self.q12 resignFirstResponder];
    [self.q13 resignFirstResponder];
    [self.q14 resignFirstResponder];
    [self.q15 resignFirstResponder];
    [self.q16 resignFirstResponder];
    [self.q17 resignFirstResponder];
    [self.q18 resignFirstResponder];
    [self.q19 resignFirstResponder];
    [self.q20 resignFirstResponder];
    [self.q21 resignFirstResponder];
    [self.q22 resignFirstResponder];
    [self.q23 resignFirstResponder];
    [self.q24 resignFirstResponder];
    [self.q25 resignFirstResponder];
    [self.q26 resignFirstResponder];
    [self.q27 resignFirstResponder];
    [self.q28 resignFirstResponder];
}


- (IBAction)saveChanges:(id)sender{
    NSLog(@"Saving changes to evaluation");
    
    Evaluation *curEvalForm =[[Evaluation alloc] init];
    
    curEvalForm.locationId = [self.sharedLocation locationId];
    
    curEvalForm.q1 = self.q1.text;
    curEvalForm.q2 = self.q2.text;
    curEvalForm.q3 = self.q3.text;
    curEvalForm.q4 = self.q4.text;
    curEvalForm.q5 = self.q5.text;
    curEvalForm.q6 = self.q6.text;
    curEvalForm.q7 = self.q7.text;
    curEvalForm.q8 = self.q8.text;
    curEvalForm.q9 = [self stringForSegmentIndex:self.q9.selectedSegmentIndex];
    curEvalForm.q10 = self.q10.text;
    curEvalForm.q11 = self.q11.text;
    curEvalForm.q12 = self.q12.text;
    curEvalForm.q13 = self.q13.text;
    curEvalForm.q14 = self.q14.text;
    curEvalForm.q15 = [self stringForSegmentIndex:self.q15.selectedSegmentIndex];
    curEvalForm.q16 = [self stringForSegmentIndex:self.q16.selectedSegmentIndex];
    curEvalForm.q17 = [self stringForSegmentIndex:self.q17.selectedSegmentIndex];
    curEvalForm.q18 = self.q18.text;
    curEvalForm.q19 = self.q19.text;
    curEvalForm.q20 = self.q20.text;
    curEvalForm.q21 = self.q21.text;
    curEvalForm.q22 = self.q22.text;
    curEvalForm.q23 = self.q23.text;
    curEvalForm.q24 = self.q24.text;
    curEvalForm.q25 = self.q25.text;
    curEvalForm.q26 = self.q26.text;
    curEvalForm.q27 = self.q27.text;
    curEvalForm.q28 = self.q28.text;
    
    DataAccess *db = [[DataAccess alloc] init];
    
    if (!self.hasEvalForm){
        [db insertEval:curEvalForm];
    }else{
        curEvalForm.evalId = self.savedEvalForm.evalId;
        [db updateEval:curEvalForm];
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




/**Keyboard dismissed when background is clicked or when return is hit**/

- (IBAction)textfieldReturn:(id)sender{
    [sender resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
