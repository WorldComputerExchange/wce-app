//
//  WCETabBarController.h
//  WCE
//
//  Created by Peter on 4/25/13.
//

#import <UIKit/UIKit.h>
#import "LoginViewControllerDelegate.h"

@interface WCETabBarController : UITabBarController <UITabBarControllerDelegate, LoginViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;

@end