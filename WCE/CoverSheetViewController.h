//
//  CoverSheetViewController.h
//  WCE
//
//  Created by Sushruth Chandrasekar on 3/21/13.
//

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
@property (nonatomic,retain) IBOutlet UITableView* locationTableView;
@property (nonatomic, retain) IBOutlet UITextField *q2;
@property (nonatomic, retain) IBOutlet UITextField *q3;
@property (nonatomic, retain) IBOutlet UITextField *q4;
@property (nonatomic, retain) IBOutlet UITextField *q5;
@property (nonatomic, retain) IBOutlet UITextField *q6;
@property (nonatomic, copy) NSArray *locations;
@property (nonatomic, copy) UIActionSheet *actionSheet;
@property (nonatomic, retain) NSString *selectedCountry;
@property (nonatomic, retain) CoverSheet *savedCoverSheet;
@property (nonatomic, assign) BOOL hasCoverSheet; 

- (IBAction)saveChanges:(id)sender;

- (IBAction)textfieldReturn:(id)sender;
- (IBAction)backgroundTouched:(id)sender;

@end
