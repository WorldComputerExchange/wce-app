//
//  WCEViewController.m
//  WCE
//
//  Created by  Brian Beckerle on 2/13/13.
//  Copyright (c) 2013  Brian Beckerle. All rights reserved.
//

#import "WCEViewController.h"

@interface WCEViewController ()

@end

@implementation WCEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[[self view] setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    myButton.frame = CGRectMake(20, 20, 200, 44); // position in the parent view and set the size of the button
    [myButton setTitle:@"Click Me!" forState:UIControlStateNormal];
    // add targets and actions
    [myButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    // add to a view
 
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
