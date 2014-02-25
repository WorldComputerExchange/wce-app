//
//  CoverSheetViewController.m
//  WCE
//
//  Created by Sushruth Chandrasekar on 3/21/13.
//  Updated by Alex on 4/20/13.
//  Updated by Alex on 9/24/13.

#import "CoverSheetViewController.h"
#import "CoverSheet.h"
#import "DataAccess.h" 
#import "User.h"

@interface CoverSheetViewController ()

@end

@implementation CoverSheetViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    self.coverTableView.backgroundView = backgroundImageView;
    
    //get the coversheet for the current partner from the database if it exists
    self.sharedUser = [User sharedUser];
    
    Partner *curPartner = [self.sharedUser sharedPartner];
    
    DataAccess *db = [[DataAccess alloc] init];
    
    self.savedCoverSheet = [[CoverSheet alloc] init];
    self.savedCoverSheet = [db getCoverSheetForPartner:curPartner];
    
    if (self.savedCoverSheet.coverSheetId < 0) { //no cover sheet found
        self.hasCoverSheet = false;
    }else {
        self.hasCoverSheet = true;
        self.q1.text = self.savedCoverSheet.q1;
        self.q2.text = self.savedCoverSheet.q2;
        self.q3.text = self.savedCoverSheet.q3;
        self.q4.text = self.savedCoverSheet.q4;
        self.q5.text = self.savedCoverSheet.q5;
        self.q6.text = self.savedCoverSheet.q6;
        self.q7.text = self.savedCoverSheet.q7;
        self.q8.text = self.savedCoverSheet.q8;
        self.q9.text = self.savedCoverSheet.q9;
        self.q10.text = self.savedCoverSheet.q10;
        self.q11.selectedSegmentIndex = [self segmentIndexForString:self.savedCoverSheet.q11];
        self.q12_1.text = self.savedCoverSheet.q12_1;
        self.q12_2.text = self.savedCoverSheet.q12_2;
        self.q13_1.text = self.savedCoverSheet.q13_1;
        self.q13_2.text = self.savedCoverSheet.q13_2;
        self.q14.text = self.savedCoverSheet.q14;
        self.q15.text = self.savedCoverSheet.q15;
        self.q16_1.text = self.savedCoverSheet.q16_1;
        self.q16_2.text = self.savedCoverSheet.q16_2;
        self.q17.selectedSegmentIndex = [self segmentIndexForString:self.savedCoverSheet.q17];
    }
    
    
    

  
    
}

- (IBAction)saveChanges:(id)sender{
    NSLog(@"Saving changes to cover sheet");
    
    CoverSheet *curCoverSheet =[[CoverSheet alloc] init];
    
    curCoverSheet.partnerId = [[self.sharedUser sharedPartner] partnerId];
    
    curCoverSheet.q1 = self.q1.text;
    curCoverSheet.q2 = self.q2.text;
    curCoverSheet.q3 = self.q3.text;
    curCoverSheet.q4 = self.q4.text;
    curCoverSheet.q5 = self.q5.text;
    curCoverSheet.q6 = self.q6.text;
    curCoverSheet.q7 = self.q7.text;
    curCoverSheet.q8 = self.q8.text;
    curCoverSheet.q9 = self.q9.text;
    curCoverSheet.q10 = self.q10.text;
    curCoverSheet.q11 = [self stringForSegmentIndex:self.q11.selectedSegmentIndex];
    curCoverSheet.q12_1 = self.q12_1.text;
    curCoverSheet.q12_2 = self.q12_2.text;
    curCoverSheet.q13_1 = self.q13_1.text;
    curCoverSheet.q13_2 = self.q13_2.text;
    curCoverSheet.q14 = self.q14.text;
    curCoverSheet.q15 = self.q15.text;
    curCoverSheet.q16_1 = self.q16_1.text;
    curCoverSheet.q16_2 = self.q16_2.text;
    curCoverSheet.q17 = [self stringForSegmentIndex:self.q17.selectedSegmentIndex];
    
    DataAccess *db = [[DataAccess alloc] init];
    
    if (!self.hasCoverSheet){
        [db insertCoverSheet:curCoverSheet];
    }else{
        curCoverSheet.coverSheetId = self.savedCoverSheet.coverSheetId;
        [db updateCoverSheet:curCoverSheet];
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


/**Keyboard dismissed when background is clicked or when return is hit**/
- (IBAction)textfieldReturn:(id)sender{
    [sender resignFirstResponder];
}
- (IBAction)textviewReturn:(id)sender{
    [sender resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
