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
    UIImage *bg = [UIImage imageNamed:@"button-bg.png"];
    UIImage *stretchable_bg = [bg stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [website setBackgroundImage:stretchable_bg forState:UIControlStateNormal];
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
