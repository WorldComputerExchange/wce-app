//
//  ChangePassViewController.m
//  WCE
//
//  Created by Peter on 4/30/13.
//

#import "ChangePassViewController.h"

@interface ChangePassViewController ()

@end

@implementation ChangePassViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	[[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.gif"]]];
}

- (void)viewDidAppear:(BOOL)animated
{
	[_passwordOld becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveNewPassword:(id)sender
{
    NSLog(@"Save new password");
	if([[_passwordOld text] isEqualToString:_oldPasswordToCheck])
	{
		if(![[_passwordNewOne text] isEqualToString:@""] && ![[_passwordNewTwo text] isEqualToString:@""])
		{
			if([[_passwordNewOne text] isEqualToString:[_passwordNewTwo text]])
			{
				[[NSUserDefaults standardUserDefaults] setValue:[_passwordNewTwo text] forKey:@"password"];
				[[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:TRUE] forKey:@"hasSetPassword"];
				[[NSUserDefaults standardUserDefaults] synchronize];
				
				[_cancelButton setEnabled:NO];
				[_saveButton setEnabled:NO];
				
				[_passwordOld resignFirstResponder];
				[_passwordNewOne resignFirstResponder];
				[_passwordNewTwo resignFirstResponder];
				
				[self setTitle:@"Password Changed!"];
				
				[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(dismissSelf) userInfo:nil repeats:NO];
			}
			else
			{
				[_passwordNewOne setText:@""];
				[_passwordNewTwo setText:@""];
                [_passwordNewOne becomeFirstResponder];
				
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Passwords do not match" message:@"The passwords you have entered do not match. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
			}
		}
		else
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Field cannot be blank" message:@"You cannot create a blank password. Please enter a new one." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
		}
	}
	else
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Old password is incorrect" message:@"Enter your old password again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
	}
}

- (IBAction)cancelChangePassword:(id)sender
{
    NSLog(@"Password change canceled");
	[_passwordOld setText:@""];
	[_passwordNewOne setText:@""];
	[_passwordNewTwo setText:@""];
    
    NSString *newPass = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
	NSLog(@"New password is: %@", newPass);
	[self dismissSelf];
}

- (void)dismissSelf
{
	[self dismissViewControllerAnimated:YES completion:nil];
	[_delegate didDismissViewController:self];
}

@end
