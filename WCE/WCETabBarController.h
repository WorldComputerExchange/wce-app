//
//  WCETabBarController.h
//  WCE
//
//  Created by Peter on 4/25/13.
//  Copyright (c) 2013  Brian Beckerle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCETabBarController : UITabBarController <UITabBarControllerDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;

- (IBAction)editButtonClicked:(id)sender;

@end