//
//  AboutWCEViewController.m
//  WCE
//
//  Created by Peter on 3/21/13.
//

#import "AboutWCEViewController.h"

@interface AboutWCEViewController ()

@end

@implementation AboutWCEViewController

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
    
    //followed nathan barry's tutorial http://nathanbarry.com/designing-buttons-ios5/
    //to create these buttons
    UIImage *bg = [[UIImage imageNamed:@"button-bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [website setBackgroundImage:bg forState:UIControlStateNormal];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToWebsite:(id)sender
{
    [self performSegueWithIdentifier:@"pushWebView" sender:self];
}
@end
