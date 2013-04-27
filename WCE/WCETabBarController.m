//
//  WCETabBarController.m
//  WCE
//
//  Created by Peter on 4/25/13.
//  Copyright (c) 2013  Brian Beckerle. All rights reserved.
//

#import "WCETabBarController.h"
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
	
	// Do any additional setup after loading the view.
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
		[_buttonsInToolbar addObject:[self editButton]];
		[[self navigationItem] setRightBarButtonItems:_buttonsInToolbar animated:YES];
	}
}

- (IBAction)editButtonClicked:(id)sender
{
	LocationViewController *viewController = (LocationViewController *)[[self viewControllers] objectAtIndex:0];
	[viewController enterEditingMode:self];
}

- (IBAction)logoffButtonClicked:(id)sender
{
	[[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"loggedIn"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	[self performSegueWithIdentifier:@"pushLogin" sender:self];
}
@end
