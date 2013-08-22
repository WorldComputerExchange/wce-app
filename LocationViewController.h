//
//  LocationViewController.h
//  WCE
//
//

/**
 Location menu where a user can add or choose a location
 **/

#import <UIKit/UIKit.h>
#import "Location.h"
#import "User.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "DataAccess.h"


@interface LocationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *locationTableView;
    IBOutlet UIBarButtonItem *editButton;
    
    
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
