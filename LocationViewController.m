//
//  LocationViewController.m
//  WCE
//
//  Created by  Brian Beckerle on 2/13/13.
//  Copyright (c) 2013  Brian Beckerle. All rights reserved.
//

#import "LocationViewController.h"
#import "WCEUser.h"

@interface LocationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation LocationViewController

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
    if (self.user) {
        //do some setup here.
        self.nameLabel.text = self.user.username;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
