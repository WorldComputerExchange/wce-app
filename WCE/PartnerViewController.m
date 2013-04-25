//
//  PartnerViewController.m
//  WCE
//
//  Created by  Brian Beckerle on 4/24/13.
//

#import "PartnerViewController.h"

@interface PartnerViewController ()

@end

@implementation PartnerViewController
@synthesize partnerTableView, partners, sharedUser;

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
}

-(void)viewWillAppear:(BOOL)animated{
    [partnerTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**TableView Methods**/
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    /**set the region name to that chosen in the table**/
    int idx = indexPath.row;
    NSString *selectedPartner;
    
    if (idx >= [[sharedUser savedPartners] count]){
        [self performSegueWithIdentifier:@"pushAddPartner" sender:self];
    }else if  ([partnerTableView isEditing]){
        selectedPartner = [[sharedUser savedPartners] objectAtIndex:idx];
        [sharedUser setIsEditingPartner:YES];
        [sharedUser setEditingPartner:selectedPartner];
        [self performSegueWithIdentifier:@"pushAddPartner" sender:self];
    }else{
        selectedPartner = [[sharedUser savedPartners] objectAtIndex:idx];
        
        [sharedUser setSharedPartner:selectedPartner];
        
        NSLog(@"%@", selectedPartner);
        
        [self performSegueWithIdentifier:@"pushPartnerForms" sender:self];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    NSLog(@"#of saved partners: %d", [[sharedUser savedPartners] count]);
	return [[sharedUser savedPartners] count] + 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//initialize a cell
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PartnerCellID"];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PartnerCell"];
	}
	//get the relevant location from the array
    NSString *name;
    if (indexPath.row == [[sharedUser savedPartners] count]){
        name = @"Add New Partner";
    }else {
        NSString *curPartner = [[sharedUser savedPartners] objectAtIndex:indexPath.row];
        name =  curPartner;
	}
	cell.textLabel.text = name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
	return cell;
}


/**Editing Methods**/

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    // int idx = indexPath.row;
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= [[sharedUser savedPartners] count]) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[sharedUser savedPartners] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


-(IBAction)enterEditingMode:(id)sender{
    if([partnerTableView isEditing]){
        NSLog(@"Exited editing mode");
        [partnerTableView setEditing:NO animated:YES];
    }else {
        NSLog(@"Entered editing mode");
        [partnerTableView setEditing:YES animated:YES];
        [partnerTableView setAllowsSelectionDuringEditing:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pushAddPartner"] && [sharedUser isEditingPartner]){
        [[[segue destinationViewController] navigationItem] setTitle:@"Editing Partner"];
    }else{
        [[[segue destinationViewController] navigationItem] setTitle:[sharedUser sharedPartner]];
        NSLog(@"shared  partner: %@", [sharedUser sharedPartner]);
    }
}

@end
