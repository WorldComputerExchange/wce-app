//
//  MainMenuViewController.h
//  WCE
//
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface MainMenuViewController : UITableViewController

@property IBOutlet UITableView *mainMenuTableView;
@property (nonatomic, retain) Location *sharedLocation;

@end
