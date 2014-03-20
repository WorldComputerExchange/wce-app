//
//  LocationViewController.h
//  WCE
//
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "User.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "DataAccess.h"
#import "WCEAppDelegate.h"
#import <MessageUI/MessageUI.h>


@interface LocationViewController : UIViewController <MFMailComposeViewControllerDelegate, UIDocumentInteractionControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property IBOutlet UIBarButtonItem *editButton;
@property IBOutlet UIBarButtonItem *logOffButton;
@property IBOutlet UIButton *previewPartnersButton;
@property IBOutlet UIButton *sendPartnersButton;
@property IBOutlet UIButton *previewEvalButton;
@property IBOutlet UIButton *sendEvalButton;

@property IBOutlet UITableView *locationTableView;

@property (nonatomic, copy) NSArray *locations;

@property (nonatomic, retain) UIButton *chooseFromMap;
@property (nonatomic, retain) Location *sharedLocation;
@property (nonatomic, retain) User *sharedUser;


-(IBAction)enterEditingMode:(id)sender;
-(IBAction)logoff:(id)sender;

-(IBAction)sendCSVFile:(id)sender;
-(IBAction)previewCSVFile:(id)sender;

-(void)pushFormDatatoCSV;

@end
