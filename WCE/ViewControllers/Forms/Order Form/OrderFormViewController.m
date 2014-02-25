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


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    self.orderTableView.backgroundView = backgroundImageView;

    //get the impQuestions for the current partner if it exists
    User *sharedUser = [User sharedUser];
    
    self.sharedPartner = [sharedUser sharedPartner];
    
    DataAccess *db = [[DataAccess alloc] init];
    
    self.savedOrder = [[Order alloc] init];
    self.savedOrder = [db getOrderForPartner:self.sharedPartner];
    
    if (self.savedOrder.orderId < 0) { //no cover sheet found
        self.hasOrder = false;
    }else {
        self.hasOrder = true;
        self.q1.selectedSegmentIndex = [self segmentIndexForString:self.savedOrder.q1];
        self.q2_1.text = self.savedOrder.q2_1;
        self.q2_2.text = self.savedOrder.q2_2;
        self.q2_3.text = self.savedOrder.q2_3;
        self.q3.selectedSegmentIndex = [self segmentIndexForString:self.savedOrder.q3];
        self.q4_1.selectedSegmentIndex = [self segmentIndexForString:self.savedOrder.q4_1];
        self.q4_2.text = self.savedOrder.q4_2;
        self.q4_3.text = self.savedOrder.q4_3;
        self.q5_1.selectedSegmentIndex = [self segmentIndexForString:self.savedOrder.q5_1];
        self.q5_2.text = self.savedOrder.q5_2;
        self.q5_3.text = self.savedOrder.q5_3;
        self.q6_1.text = self.savedOrder.q6_1;
        self.q6_2.text = self.savedOrder.q6_2;
        self.q6_3.text = self.savedOrder.q6_4;
        self.q6_4.text = self.savedOrder.q6_4;
        self.q7_1.selectedSegmentIndex = [self segmentIndexForString:self.savedOrder.q7_1];
        self.q7_2.selectedSegmentIndex = [self segmentIndexForString:self.savedOrder.q7_2];
        self.q8.text = self.savedOrder.q8;
        self.q9.selectedSegmentIndex = [self segmentIndexForString:self.savedOrder.q9];
        self.q10.selectedSegmentIndex = [self segmentIndexForString:self.savedOrder.q10];
        self.q11.selectedSegmentIndex = [self segmentIndexForString:self.savedOrder.q11];
        self.q12.selectedSegmentIndex = [self segmentIndexForString:self.savedOrder.q12];
        self.q13_1.selectedSegmentIndex = [self segmentIndexForString:self.savedOrder.q13_1];
        self.q13_2.text = self.savedOrder.q13_2;
        self.q14.selectedSegmentIndex = [self segmentIndexForString:self.savedOrder.q14];
        self.q15.selectedSegmentIndex = [self segmentIndexForString:self.savedOrder.q15];
    }
    
    
}

- (IBAction)saveChanges:(id)sender{
    NSLog(@"Saving changes to impQuestions");
    
    Order *curOrder =[[Order alloc] init];
    
    curOrder.partnerId = [self.sharedPartner partnerId];
    
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
    
    if (!self.hasOrder){
        [db insertOrder:curOrder];
    }else{
        curOrder.orderId = self.savedOrder.orderId;
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
