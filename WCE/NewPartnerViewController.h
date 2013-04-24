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
@property NSString *name;
@property User *sharedUser;

@end
