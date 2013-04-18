//
//  LocationViewController.h
//  WCE
//
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface LocationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *locationTableView;
    NSArray *regionArray;
    UIActionSheet *actionSheet;
    NSMutableArray *locations;
    
	UIButton *chooseFromMap;
	UIView *footerView;
    Location *sharedLocation;
}

@property (nonatomic, retain) NSArray *regionArray;
@property (nonatomic,retain) UITableView* locationTableView;
@property (nonatomic, copy) NSArray *locations;

@property (nonatomic, retain) UIButton *chooseFromMap;
@property (nonatomic, retain) UIView *footerView;
@property (nonatomic, retain) Location *sharedLocation;

@end
