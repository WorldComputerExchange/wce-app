//
//  WCETabBarController.m
//  WCE
//
//  Created by Peter on 4/25/13.
//
#import "WCETabBarController.h"
#import "LoginViewController.h"
#import "LocationViewController.h"
#import "LocationMapViewController.h"

@interface WCETabBarController ()

@property (nonatomic, strong, readonly) NSMutableArray *buttonsInToolbar;

@end

@implementation WCETabBarController

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
	[self setDelegate:self];
	
	_buttonsInToolbar = [[NSMutableArray alloc] init];
	
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:135./255. green:0./255. blue:0./255. alpha:1.0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
	_buttonsInToolbar = [[[self navigationItem] rightBarButtonItems] mutableCopy];
	
	if([viewController isKindOfClass:[LocationMapViewController class]])
	{
		[_buttonsInToolbar removeObject:[self editButton]];
		[[self navigationItem] setRightBarButtonItems:_buttonsInToolbar animated:YES];
	}
	else if([viewController isKindOfClass:[LocationViewController class]])
	{
		if(![_buttonsInToolbar containsObject:[self editButton]]) // prevent adding more than one 'Edit' button
		{
			[_buttonsInToolbar addObject:[self editButton]];
			[[self navigationItem] setRightBarButtonItems:_buttonsInToolbar animated:YES];
		}
	}
}

- (void)willDismissPresentedViewController
{
	[[self view] setHidden:NO];
	[[self navigationController] setNavigationBarHidden:NO];
}

@end
