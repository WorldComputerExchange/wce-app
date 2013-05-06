//
//  OrderFormViewController.m
//  WCE
//
//  Created by Alex on 4/20/13.
//

#import "OrderFormViewController.h"

@interface OrderFormViewController ()

@end

@implementation OrderFormViewController




/**Keyboard dismissed when return is hit**/

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
