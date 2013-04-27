//
//  LoginViewController.m
//  WCE
//
//

#import "LoginViewController.h"
#import "LocationViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *passcodeField;

- (IBAction)pushLocationView:(id)sender;

@end

@implementation LoginViewController

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
	
	[[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"136676912132100.gif"]]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushLocationView:(id)sender{
	
	// "self.passcodeField.text" refers to the text currently entered in the passcode field (which is an outlet for this class, WCELoginViewController)
    if ([self.passcodeField.text isEqualToString:@"12345"]) // We compare it to the string "12345"
    {
        self.passcodeField.text = @""; // Erase the passcode entered in the text field
		
		// Remeber that the user has logged in
		[[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"loggedIn"];
		[[NSUserDefaults standardUserDefaults] synchronize];
        
        // Tell this view controller (WCELoginViewController) to do a "segue" transition to the next page of the app. The way you set this up is in
        // the storyboard. You drag a line (by holding the control key) from the view controller that you're starting from, to the view controller that you want
        // to "segue" to. You know, I'll just make a screen capture video that'll be easier to show you with.
        //[self performSegueWithIdentifier:@"pushLocation" sender:self];
		
		[_delegate willDismissPresentedViewController];
		[self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        self.passcodeField.text = @""; // Erase the passcode entered in the text field
        
        // Copied this right off a website, it just creates an alert box that tells you that the passcode you entered was wrong
        UIAlertView *incorrectCodeMessage = [[UIAlertView alloc] initWithTitle:@"Incorrect Passcode" message:@"Try entering your passcode again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        // Actually shows the alert message
        [incorrectCodeMessage show];
    }
    
}
@end
