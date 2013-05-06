//
//  EvaluationViewController.m
//  WCE
//
//  Created by  Brian Beckerle on 5/5/13.
//  Copyright (c) 2013  Brian Beckerle. All rights reserved.
//

#import "EvaluationViewController.h"

@interface EvaluationViewController ()

@end

@implementation EvaluationViewController



/**Keyboard dismissed when background is clicked or when return is hit**/

- (IBAction)textfieldReturn:(id)sender{
    [sender resignFirstResponder];
}

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

@end
