//
//  ImplementationViewController.m
//  WCE
//
//

#import "ImplementationViewController.h"

@interface ImplementationViewController ()

@end

@implementation ImplementationViewController

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
    // Add a "Save" button to the navigation controller
	/*UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
																   style:UIBarButtonItemStyleDone
																  target:nil
																  action:nil];*/
	self.presentingViewController.navigationItem.backBarButtonItem.title = @"Back";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
