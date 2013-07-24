//
//  ChangePassViewController.h
//  WCE
//
//  Created by Peter on 4/30/13.
//

#import <UIKit/UIKit.h>

@class ChangePassViewController;
@protocol ChangePassViewControllerDelegate <NSObject>

- (void)didDismissViewController:(ChangePassViewController *)viewController;

@end

@interface ChangePassViewController : UIViewController

- (IBAction)saveNewPassword:(id)sender;
- (IBAction)cancelChangePassword:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property (weak, nonatomic) NSString *oldPasswordToCheck;
@property (weak, nonatomic) IBOutlet UITextField *passwordOld;
@property (weak, nonatomic) IBOutlet UITextField *passwordNewOne;
@property (weak, nonatomic) IBOutlet UITextField *passwordNewTwo;
@property (weak, nonatomic) id <ChangePassViewControllerDelegate> delegate; //LoginViewController will be this class's delegate

@end
