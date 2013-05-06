//
//  CoverSheetViewController.h
//  WCE
//
//  Created by Sushruth Chandrasekar on 3/21/13.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface CoverSheetViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSArray *regionArray;
    UIActionSheet *actionSheet;
    NSArray *locations;

    UIPickerView *pickerView;
}

@property (nonatomic, retain) NSArray *regionArray;
@property (nonatomic,retain) IBOutlet UITableView* locationTableView;
@property (nonatomic, copy) NSArray *locations;
@property (nonatomic, copy) UIActionSheet *actionSheet;
@property (nonatomic, retain) NSString *selectedCountry;

- (IBAction)textfieldReturn:(id)sender;
- (IBAction)backgroundTouched:(id)sender;

@end
