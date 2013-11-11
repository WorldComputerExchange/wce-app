//
//  LoginViewController.h
//  WCE
//
//

#import <UIKit/UIKit.h>
#import "ChangePassViewController.h"
#import "LoginViewControllerDelegate.h"


@class LoginViewController;

@interface LoginViewController : UIViewController <ChangePassViewControllerDelegate>
{
    IBOutlet UIButton *login;
    IBOutlet UIButton *changePass;
}

@property (weak, nonatomic) IBOutlet UITextField *passcodeField;
@property (nonatomic, strong, readonly) NSString *password;
@property (nonatomic, weak) id <LoginViewControllerDelegate> delegate;

 - (IBAction)pushLocationView:(id)sender;

@end
