//
//  WCETabBarController.h
//  WCE
//
//  Created by Peter on 4/25/13.
//  Copyright (c) 2013  Brian Beckerle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "WCEAppDelegate.h"

@interface WCETabBarController : UITabBarController <UITabBarControllerDelegate, LoginViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;

- (IBAction)editButtonClicked:(id)sender;
- (IBAction)logoffButtonClicked:(id)sender;

@end