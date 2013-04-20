//
//  LocationViewController.h
//  WCE
//
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "User.h"

@interface LocationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *locationTableView;
    IBOutlet UIBarButtonItem *editButton;
    
    UIActionSheet *actionSheet;
    NSMutableArray *locations;
    
	UIButton *chooseFromMap;
	UIView *footerView;
    Location *sharedLocation;
    User *sharedUser;
}

@property (nonatomic,retain) UITableView* locationTableView;
@property (nonatomic, copy) NSArray *locations;

@property (nonatomic, retain) UIButton *chooseFromMap;
@property (nonatomic, retain) UIView *footerView;
@property (nonatomic, retain) Location *sharedLocation;
@property (nonatomic, retain) User *sharedUser;

-(IBAction)enterEditingMode:(id)sender;

@end
