//
//  NewPartnerViewController.m
//  WCE
//
//  Created by Alex on 4/22/13.
//

#import "NewPartnerViewController.h"
#import "User.h"
#import "DataAccess.h"

@interface NewPartnerViewController ()

@end

@implementation NewPartnerViewController

- (IBAction)backgroundTouched:(id)sender {
    [self.nameField resignFirstResponder];
}

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
    
    self.sharedUser = [User sharedUser];
    
    if ([self.sharedUser isEditingPartner]){
        [self.nameField setText:[[self.sharedUser editingPartner] name]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
	[[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Default.png"]]];
}

- (void)viewDidDisappear:(BOOL)animated{
    [self.sharedUser setIsEditingPartner:false];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveChanges:(id)sender  
{
    /*save input fields to our user and database
     Should check that these values are non-null!*/
    
    Partner *curPartner = [[Partner alloc] init];
    curPartner.name = self.nameField.text;
    
    if (curPartner.name.length > 0){
    
        //create dataAccess object
        DataAccess *db = [[DataAccess alloc] init];
        
        NSString *curLocationName = [[Location sharedLocation] name];
        
        [curPartner setLocationId:[db getLocationIdForName:curLocationName]];
        
        BOOL success;
        
        if ([self.sharedUser isEditingPartner]){
            Partner *oldPartner = [self.sharedUser editingPartner];
            [curPartner setPartnerId:[oldPartner partnerId]];
            success = [db updatePartner:curPartner];
        }else{
            success = [db insertPartner:curPartner];
        }
        
        if (!success){ //user tried to create a partner with same name as another
        
            UIAlertView *repeatPartnerMessage = [[UIAlertView alloc] initWithTitle:@"Repeat Partner Name" message:@"Partner names must be unique." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            
            //show the alert message
            [repeatPartnerMessage show];
            
        }else{
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    
    }else{
       
        //Alert the user that a blank location name has been entered
        UIAlertView *blankNameMessage = [[UIAlertView alloc] initWithTitle:@"Blank Partner Name" message:@"Please enter a partner name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        //show the alert message
        [blankNameMessage show];
    }
}

- (void)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
