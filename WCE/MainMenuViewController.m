//
//  MainMenuViewController.m
//  WCE
//
//

#import "MainMenuViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

@synthesize sharedLocation;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    sharedLocation = [Location sharedLocation];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//initialize a cell
    UITableViewCell *cell;
    if (indexPath.row == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"Info"];
    }else if (indexPath.row == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:@"Forms"];
    }else if (indexPath.row == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:@"Phrases"];
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Misc"];
    }
    
	return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 2){
        NSLog(@"Current Language is : %@", sharedLocation.language);
        if ([sharedLocation.language isEqualToString:@"Arabic"]){
            [self performSegueWithIdentifier:@"pushArabic" sender:self];
        }else if ([sharedLocation.language isEqualToString:@"French"]){
            [self performSegueWithIdentifier:@"pushFrench" sender:self];
        }else if ([sharedLocation.language isEqualToString:@"Spanish"]){
            [self performSegueWithIdentifier:@"pushSpanish" sender:self];
        }else{
            [self performSegueWithIdentifier:@"pushSpanish" sender:self];
        }
        
    }
}

@end
