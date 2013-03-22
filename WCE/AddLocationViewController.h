//
//  AddLocationViewController.h
//  WCE
//
//

#import <UIKit/UIKit.h>
#define countryPicker 0
#define languagePicker 1

@interface AddLocationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSArray *locations;
    NSArray *dataArray;
    UIActionSheet *actionSheet;
    IBOutlet UITableView *dropDownTableView;
}

@property (nonatomic, copy) NSArray *locations;
@property (nonatomic, copy) UIActionSheet *actionSheet;
@property (nonatomic, retain) IBOutlet UITableView *dropDownTableView;
@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, retain) NSArray *countries;
@property (nonatomic, retain) NSArray *languages;

- (IBAction)cancelChanges:(id)sender;
- (IBAction)saveChanges:(id)sender;

@end