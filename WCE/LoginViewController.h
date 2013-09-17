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
    IBOutlet UIButton *login;
    IBOutlet UIButton *changePass;
}

@property (nonatomic, strong, readonly) NSString *password;
@property (nonatomic, weak) id <LoginViewControllerDelegate> delegate;

@end
