//
//  NewPartnerViewController.m
//  WCE
//
//  Created by Alex on 4/22/13.
//

#import "NewPartnerViewController.h"
#import "User.h"

@interface NewPartnerViewController ()

@end

@implementation NewPartnerViewController

@synthesize nameField, sharedUser, saveButton;


- (IBAction)backgroundTouched:(id)sender {
    [nameField resignFirstResponder];
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
    
    sharedUser = [User sharedUser];
    
    if ([sharedUser isEditingPartner]){
        [nameField setText:[sharedUser editingPartner]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
	[[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"136676912132100.gif"]]];
}

- (void)viewDidDisappear:(BOOL)animated{
    [sharedUser setIsEditingPartner:false];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)saveChanges:(id)sender  
{
    /*save input fields to our user
     Should check that these values are non-null!*/
    NSLog(@"changes being saved!");
    NSString *name = nameField.text;
    if (name.length > 0){
    
        /**check if a location with this name exists already and replace it if it does**/
        int savedIdx;
        BOOL replaced = false;
    
        NSMutableArray *savedPartners = [sharedUser savedPartners];
        for (int idx = 0; idx < [savedPartners count]; idx++){
            NSString *cur = [savedPartners objectAtIndex:idx];
            if ([cur isEqualToString:name]){
                replaced = true;
                savedIdx = idx;
            }   
        }
        if (!replaced){
            [[sharedUser savedPartners] addObject:name];
        }else{
            [[sharedUser savedPartners] replaceObjectAtIndex:savedIdx withObject:name];
        }
        NSLog(@"Number of saved partners %d", [[sharedUser savedPartners] count]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
