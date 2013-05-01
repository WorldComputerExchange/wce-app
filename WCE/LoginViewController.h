//
//  LoginViewController.h
//  WCE
//
//

#import <UIKit/UIKit.h>
#import "LocationViewController.h"
#import "ChangePassViewController.h"

@class LoginViewController;
@protocol LoginViewControllerDelegate <NSObject>

- (void)willDismissPresentedViewController;

@end

@interface LoginViewController : UIViewController <ChangePassViewControllerDelegate>
{
}

@property (nonatomic, strong, readonly) NSString *password;
@property (nonatomic, weak) id <LoginViewControllerDelegate> delegate;

@end
