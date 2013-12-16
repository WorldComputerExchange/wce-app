//
//  WCEAppDelegate.m
//  WCE
//
//


#import "WCEAppDelegate.h"

@implementation WCEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Set the database name and path to check for a database
    self.databaseName = @"Wce.db";
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    self.databasePath = [documentDir stringByAppendingPathComponent:self.databaseName];
    
    //check if a database exists, if one doesn't create one
    [self createAndCheckDatabase];
    
    //set the background image and navigation bar color
	self.window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default.png"]];
    
    UIImage *navBackgroundImage = [UIImage imageNamed:@"navBar-bg.png"];
    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:135./255. green:0./255. blue:0./255. alpha:1.0]];
   
    return YES;
}

/***
 Check if a database exists for the application, if one doesn't create one
 ***/
-(void)createAndCheckDatabase
{
    BOOL success;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:self.databasePath];
    
    if(success) return;
    
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath]
                                     stringByAppendingPathComponent:self.databaseName];
    [fileManager copyItemAtPath:databasePathFromApp toPath:self.databasePath error:nil];
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
	
	BOOL isLoggedIn = [[NSUserDefaults standardUserDefaults] boolForKey:@"loggedIn"];
	
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
	_loginController = [storyboard instantiateViewControllerWithIdentifier:@"login"];
	_tabBarController = (WCETabBarController *)[[self window] rootViewController];
	[_loginController setDelegate:_tabBarController];
	
	
	if(!isLoggedIn)
	{
		[[[self window] rootViewController] presentViewController:_loginController animated:YES completion:nil];
	}
}

- (void)presentLoginViewControllerAnimated:(BOOL)animated
{
	[[[self window] rootViewController] presentViewController:_loginController animated:animated completion:nil];
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

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
