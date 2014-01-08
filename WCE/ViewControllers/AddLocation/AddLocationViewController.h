//
//  AddLocationViewController.h
//  WCE
//
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Location.h"
#import "DataAccess.h"
#define countryPicker 0
#define languagePicker 1

@interface AddLocationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
{
    IBOutlet UITableView *dropDownTableView;
}

@property (nonatomic, copy) NSArray *locations;
@property (nonatomic, retain) UIActionSheet *actionSheet;
@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, retain) NSArray *countries;
@property (nonatomic, retain) NSArray *languages;
@property (nonatomic, retain) User *sharedUser;

@property (nonatomic, retain) NSString *selectedCountry;
@property (nonatomic, retain) NSString *selectedLanguage;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *location;
@property (weak, nonatomic) IBOutlet UITextField *contact;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UITextField *zip;

@property (nonatomic, readonly) CGPoint originalOffset;
@property (nonatomic, readonly) UIView *activeField;


- (IBAction)cancelChanges:(id)sender;
- (IBAction)saveChanges:(id)sender;

- (IBAction)backgroundTouched:(id)sender;
- (IBAction)textfieldReturn:(id)sender;

@end