//
//  NewPartnerViewController.h
//  WCE
//
//  Created by Alex on 4/22/13.s
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface NewPartnerViewController : UIViewController

@property IBOutlet UITextField *nameField;
@property IBOutlet UIBarButtonItem *saveButton;
@property User *sharedUser;


- (IBAction)saveChanges:(id)sender;
- (IBAction)cancel:(id)sender;

@end
