//
//  ChangePassViewController.m
//  WCE
//
//  Created by Peter on 4/30/13.
//  Copyright (c) 2013  Brian Beckerle. All rights reserved.
//

#import "ChangePassViewController.h"

@interface ChangePassViewController ()

@end

@implementation ChangePassViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveNewPassword:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}
@end
