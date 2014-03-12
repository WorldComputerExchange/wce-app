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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    self.aboutWCETableView.backgroundView = backgroundImageView;
    
    UIImage *bg = [[UIImage imageNamed:@"button-bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [website setBackgroundImage:bg forState:UIControlStateNormal];  
}
@end
