//
//  MainMenuViewController.h
//  WCE
//
//

/**Info, Forms, Phrases, Misc Menu**/

#import <UIKit/UIKit.h>
#import "Location.h"

@interface MainMenuViewController : UITableViewController
{
    IBOutlet UITableView *mainMenuTableView;
}
@property (nonatomic, retain) Location *sharedLocation;

@end
