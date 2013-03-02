//
//  LocationViewController.h
//  WCE
//
//

#import <UIKit/UIKit.h>

@interface LocationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource> {
    IBOutlet UITableView *locationTableView;
    NSMutableArray *regionArray;
    UIActionSheet *actionSheet;
    NSMutableArray *locations;
    
}

@property (nonatomic, retain) NSMutableArray *regionArray;
@property (nonatomic,retain) UITableView* locationTableView;
@property (nonatomic, copy) NSArray *locations;
@property (nonatomic, copy) UIActionSheet *actionSheet;

@end
