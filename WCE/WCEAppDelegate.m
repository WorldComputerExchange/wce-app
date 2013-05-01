//
//  WCEAppDelegate.m
//  WCE
//
//


#import "WCEAppDelegate.h"

@implementation WCEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions

{
	self.window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"136676912132100.gif"]];
	[[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:255./255. green:140/255. blue:0./255. alpha:1]];
	
	// Override point for customization after application launch.
   
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	
	BOOL isLoggedIn = [[NSUserDefaults standardUserDefaults] boolForKey:@"loggedIn"];
	
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
	UINavigationController *navController = (UINavigationController *)[[self window] rootViewController];
	_loginController = [storyboard instantiateViewControllerWithIdentifier:@"login"];
	_tabBarController = (WCETabBarController *)[navController topViewController];
	[_loginController setDelegate:_tabBarController];
	
	// used for segue between password and change password:
	//_loginNavController = [[UINavigationController alloc] initWithRootViewController:_loginController];
	
	if(!isLoggedIn)
	{
		[[_tabBarController view] setHidden:YES];
		[[_tabBarController navigationController] setNavigationBarHidden:YES];
		
		[[[self window] rootViewController] presentViewController:_loginController animated:YES completion:nil];
	}
}

- (void)presentLoginViewControllerAnimated:(BOOL)animated
{
	[[[self window] rootViewController] presentViewController:_loginController animated:animated completion:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
