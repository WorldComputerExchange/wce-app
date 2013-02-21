//
//  LoginViewController.m
//  WCE
//
//

#import "LoginViewController.h"
#import "LocationViewController.h"

@interface LoginViewController ()

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

- (IBAction)pushLocationView:(id)sender{
    NSLog(@"Login button pushed");
    LocationViewController *locationView = [[LocationViewController alloc] init];
    [self.navigationController pushViewController:locationView animated:YES];
}
@end
