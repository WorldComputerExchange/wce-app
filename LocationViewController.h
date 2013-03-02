//
//  LocationViewController.h
//  WCE
//
//

#import <UIKit/UIKit.h>

@interface LocationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource> {
    IBOutlet UITableView *locationTableView;
    NSMutableArray *locationArray;
    UIActionSheet *actionSheet;
    NSArray *locations;
    
}

@property (nonatomic, retain) NSMutableArray *locationArray;
@property (nonatomic,retain) UITableView* locationTableView;
@property (nonatomic, copy) NSArray *locations;
@property (nonatomic, copy) UIActionSheet *actionSheet;

@end
