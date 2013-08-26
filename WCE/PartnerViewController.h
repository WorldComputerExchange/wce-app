//
//  PartnerViewController.h
//  WCE
//
//  Created by  Brian Beckerle on 4/24/13.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface PartnerViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *partnerTableView;
    IBOutlet UIBarButtonItem *editButton;
    
    User *sharedUser;
}

@property (nonatomic,retain) UITableView* partnerTableView;
@property (nonatomic, retain) NSMutableArray *partners;
@property (nonatomic, retain) User *sharedUser;

-(IBAction)enterEditingMode:(id)sender;

@end
