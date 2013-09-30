//
//  CoverSheetViewController.h
//  WCE
//
//  Created by Alex Higuera 9/26/2013

#import <UIKit/UIKit.h>
#import "Location.h"
#import "User.h"
#import "CoverSheet.h"

@interface CoverSheetViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSArray *regionArray;
    UIActionSheet *actionSheet;
    NSArray *locations;

    UIPickerView *pickerView;
}

@property (nonatomic, retain) User *sharedUser;
@property (nonatomic, retain) NSArray *regionArray;
@property (nonatomic, retain) IBOutlet UITextField *q1;
@property (nonatomic, retain) IBOutlet UITextField *q2;
@property (nonatomic, retain) IBOutlet UITextField *q3;
@property (nonatomic, retain) IBOutlet UITextField *q4;
@property (nonatomic, retain) IBOutlet UITextView *q5;
@property (nonatomic, retain) IBOutlet UITextField *q6;
@property (nonatomic, retain) IBOutlet UITextField *q7;
@property (nonatomic, retain) IBOutlet UITextField *q8;
@property (nonatomic, retain) IBOutlet UITextField *q9;
@property (nonatomic, retain) IBOutlet UITextField *q10;
@property (weak, nonatomic) IBOutlet UISegmentedControl *q11;
@property (nonatomic, retain) IBOutlet UITextField *q12_1;
@property (nonatomic, retain) IBOutlet UITextField *q12_2;
@property (nonatomic, retain) IBOutlet UITextField *q13_1;
@property (nonatomic, retain) IBOutlet UITextField *q13_2;
@property (nonatomic, retain) IBOutlet UITextField *q14;
@property (nonatomic, retain) IBOutlet UITextField *q15;
@property (nonatomic, retain) IBOutlet UITextField *q16_1;
@property (nonatomic, retain) IBOutlet UITextField *q16_2;
@property (weak, nonatomic) IBOutlet UISegmentedControl *q17;

@property (nonatomic, copy) NSArray *locations;
@property (nonatomic, copy) UIActionSheet *actionSheet;
@property (nonatomic, retain) NSString *selectedCountry;
@property (nonatomic, retain) CoverSheet *savedCoverSheet;
@property (nonatomic, assign) BOOL hasCoverSheet; 

- (IBAction)saveChanges:(id)sender;

- (IBAction)textfieldReturn:(id)sender;
- (IBAction)backgroundTouched:(id)sender;

-(NSInteger)segmentIndexForString:(NSString *)string;
-(NSString *)stringForSegmentIndex:(NSInteger)segIndex;

@end
