//
//  LoginViewController.m
//  WCE
//
//

#import "LoginViewController.h"
#import "LocationViewController.h"
#import "WCEUser.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) WCEUser *registeredUser;

- (IBAction)loginButtonPressed:(id)sender;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"pushLocation"]) {
        LocationViewController *locationVC = segue.destinationViewController;
       
        locationVC.user = self.registeredUser;
    }
}

#pragma mark Private Methods

- (IBAction)loginButtonPressed:(id)sender {
   
    //some asynchronous connection here.
    /*
    [NSURLConnection sendAsynchronousRequest:nil
                                       queue:nil
                           completionHandler:^(NSURLResponse *, NSData *, NSError *) {
                               //placeholder code
                           }];
     */
    
    self.registeredUser = [[WCEUser alloc] init];
    self.registeredUser.username = @"Bebo";
    self.registeredUser.registered = NO;
    
    
    if (self.registeredUser.registered) {
        //already registered, go straight to main screen
    } else {
        [self performSegueWithIdentifier:@"pushLocation" sender:nil];
    }

}



@end
