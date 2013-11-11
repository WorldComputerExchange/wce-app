//
//  WCEAppDelegate.h
//  WCE
//
//

#import <UIKit/UIKit.h>
#import "WCETabBarController.h"
#import "LocationViewController.h"
#import "LoginViewController.h"

@class WCEAppDelegate;

@interface WCEAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LoginViewController *loginController;
//@property (strong, nonatomic) LocationViewController *locationController;
@property (strong, nonatomic, readonly) WCETabBarController *tabBarController;
@property (strong, nonatomic, readonly) UINavigationController *loginNavController;
@property (strong, nonatomic) NSString *databaseName;
@property (strong, nonatomic) NSString *databasePath;

- (void)presentLoginViewControllerAnimated:(BOOL)animated;

@end
