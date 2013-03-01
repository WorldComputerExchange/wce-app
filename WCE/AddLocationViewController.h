//
//  AddLocationViewController.h
//  WCE
//
//

#import <UIKit/UIKit.h>

@interface AddLocationViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource>
{
    NSArray *locations;
    NSMutableArray *dataArray;
    UIActionSheet *actionSheet;
    IBOutlet UITableView *dropDownTableView;
}

@property (nonatomic, copy) NSArray *locations;
@property (nonatomic, copy) UIActionSheet *actionSheet;
@property (nonatomic, retain) IBOutlet UITableView *dropDownTableView;
@property (nonatomic, retain) NSMutableArray *dataArray;

@end