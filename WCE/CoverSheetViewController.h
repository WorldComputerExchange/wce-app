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
    IBOutlet UITableView *ChooseCountry;
    NSArray *regionArray;
    UIActionSheet *actionSheet;
    NSArray *locations;

    UIPickerView *pickerView;
}

@property (nonatomic, retain) NSArray *regionArray;
@property (nonatomic,retain) UITableView* locationTableView;
@property (nonatomic, copy) NSArray *locations;
@property (nonatomic, copy) UIActionSheet *actionSheet;

@end
