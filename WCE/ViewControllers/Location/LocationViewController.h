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
#import "WCEAppDelegate.h"


@interface LocationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *locationTableView;
    
	UIButton *chooseFromMap;
    Location *sharedLocation;
    User *sharedUser;
}


@property IBOutlet UIBarButtonItem *editButton;
@property IBOutlet UIBarButtonItem *logOffButton;

@property (nonatomic,retain) UITableView* locationTableView;
@property (nonatomic, copy) NSArray *locations;

@property (nonatomic, retain) UIButton *chooseFromMap;
@property (nonatomic, retain) Location *sharedLocation;
@property (nonatomic, retain) User *sharedUser;

-(IBAction)enterEditingMode:(id)sender;
-(IBAction)logoff:(id)sender;
@end
