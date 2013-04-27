//
//  WCEAppDelegate.h
//  WCE
//
//

#import <UIKit/UIKit.h>

#import "LoginViewController.h"
#import "WCETabBarController.h"

@class WCETabBarController;

@interface WCEAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic, readonly) LoginViewController *loginController;
@property (strong, nonatomic, readonly) WCETabBarController *tabBarController;

- (void)presentLoginViewControllerAnimated:(BOOL)animated;

@end
