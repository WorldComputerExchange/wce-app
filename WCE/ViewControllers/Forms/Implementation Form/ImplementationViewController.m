//
//  ImplementationViewController.m
//  WCE
//
//

#import "ImplementationViewController.h"
#import "User.h" 
#import "DataAccess.h" 
#import "CustomCell.h"

@interface ImplementationViewController ()

@end

@implementation ImplementationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    self.impTableView.backgroundView = backgroundImageView;
    
    //get the impQuestions for the current partner if it exists
    User *sharedUser = [User sharedUser];
    
    self.sharedPartner = [sharedUser sharedPartner];
    
    DataAccess *db = [[DataAccess alloc] init];
    
    self.savedImpQues = [[ImpQuestions alloc] init];
    self.savedImpQues = [db getImpForPartner:self.sharedPartner];
    
    if (self.savedImpQues.impId < 0) { //no cover sheet found
        self.hasImpQues = false;
    }else {
        self.hasImpQues= true;
        self.q1.text = self.savedImpQues.q1;
        self.q2.text = self.savedImpQues.q2;
        self.q3.text = self.savedImpQues.q3;
        self.q4.text = self.savedImpQues.q4;
        self.q5.text = self.savedImpQues.q5;
        self.q6.text = self.savedImpQues.q6;
        self.q7.selectedSegmentIndex = [self segmentIndexForString:self.savedImpQues.q7];
        self.q8.text = self.savedImpQues.q8;
        self.q9.text = self.savedImpQues.q9;
        self.q10.text = self.savedImpQues.q10;
        self.q11.text = self.savedImpQues.q11;
        self.q12.text = self.savedImpQues.q12;
        self.q13.text = self.savedImpQues.q13;
        self.q14.text = self.savedImpQues.q14;
        self.q15.text = self.savedImpQues.q15;
        self.q16.text = self.savedImpQues.q16;
        self.q17.text = self.savedImpQues.q17;
        self.q18.text = self.savedImpQues.q18;
        self.q19.text = self.savedImpQues.q19;
        self.q20.text = self.savedImpQues.q20;
        self.q21.text = self.savedImpQues.q21;
        self.q22.text = self.savedImpQues.q22;
        self.q23.text = self.savedImpQues.q23;
        self.q24.selectedSegmentIndex = [self segmentIndexForString:self.savedImpQues.q24];
        self.q25.text = self.savedImpQues.q25;
    }
}

- (IBAction)saveChanges:(id)sender{
    NSLog(@"Saving changes to impQuestions");
    
    ImpQuestions *curImpQues =[[ImpQuestions alloc] init];
    
    curImpQues.partnerId = [self.sharedPartner partnerId];
    
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
    
    if (!self.hasImpQues){
        [db insertImp:curImpQues];
    }else{
        curImpQues.impId = self.savedImpQues.impId;
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


@end
