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
	[self.passwordOld becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveNewPassword:(id)sender
{
    NSLog(@"Save new password");
	if([[self.passwordOld text] isEqualToString:self.oldPasswordToCheck])
	{
		if(![[self.passwordNewOne text] isEqualToString:@""] && ![[self.passwordNewTwo text] isEqualToString:@""])
		{
			if([[self.passwordNewOne text] isEqualToString:[self.passwordNewTwo text]])
			{
				[[NSUserDefaults standardUserDefaults] setValue:[self.passwordNewTwo text] forKey:@"password"];
				[[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:TRUE] forKey:@"hasSetPassword"];
				[[NSUserDefaults standardUserDefaults] synchronize];
				
				[self.cancelButton setEnabled:NO];
				[self.saveButton setEnabled:NO];
				
				[self.passwordOld resignFirstResponder];
				[self.passwordNewOne resignFirstResponder];
				[self.passwordNewTwo resignFirstResponder];
				
				[self setTitle:@"Password Changed!"];
				
				[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(dismissSelf) userInfo:nil repeats:NO];
			}
			else
			{
				[self.passwordNewOne setText:@""];
				[self.passwordNewTwo setText:@""];
                [self.passwordNewOne becomeFirstResponder];
				
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
	[self.passwordOld setText:@""];
	[self.passwordNewOne setText:@""];
	[self.passwordNewTwo setText:@""];
    
    NSString *newPass = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
	NSLog(@"New password is: %@", newPass);
	[self dismissSelf];
}

- (void)dismissSelf
{
	[self dismissViewControllerAnimated:YES completion:nil];
	[self.delegate didDismissViewController:self];
}

@end
