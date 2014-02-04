//
//  MainMenuViewController.h
//  WCE
//
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface MainMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property IBOutlet UITableView *mainMenuTableView;
@property (nonatomic, retain) Location *sharedLocation;

@end
