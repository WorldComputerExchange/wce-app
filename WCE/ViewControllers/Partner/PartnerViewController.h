//
//  PartnerViewController.h
//  WCE
//
//  Created by  Brian Beckerle on 4/24/13.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface PartnerViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *partnerTableView;
}

@property (nonatomic, retain) NSMutableArray *partners;
@property (nonatomic, retain) User *sharedUser;
@property IBOutlet UIBarButtonItem *editButton;

-(IBAction)enterEditingMode:(id)sender;

@end
