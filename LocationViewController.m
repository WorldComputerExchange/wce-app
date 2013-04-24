//
//  LocationViewController.m
//  WCE
//
//

#import "LocationViewController.h"
#import "Location.h"
#import "User.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

@synthesize locationTableView, footerView, chooseFromMap, sharedLocation, sharedUser;


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

    //get shared location instance
    sharedLocation = [Location sharedLocation];
    NSLog(@"sharedLocation %@", [sharedLocation name]);
    
    //get shared user instance
    sharedUser = [User sharedUser];
}

// Called when Choose from Map button is pressed
- (void)showMap
{
	[self performSegueWithIdentifier:@"pushMapView" sender:self];
}

-(IBAction)enterEditingMode:(id)sender{
    if([locationTableView isEditing]){
        NSLog(@"Exited editing mode");
        [locationTableView setEditing:NO animated:YES];
    }else {
         NSLog(@"Entered editing mode");
        [locationTableView setEditing:YES animated:YES];
        [locationTableView setAllowsSelectionDuringEditing:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    //show navigation bar programmatically
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setTitle:@"Choose Location"];
    
    [locationTableView setBackgroundView:nil];
    [locationTableView setBackgroundColor:[UIColor clearColor]];
    [locationTableView setSeparatorColor:[UIColor grayColor]];
    [locationTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
    
    [locationTableView reloadData];
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
    Location *selectedLocation;
    
    if (idx >= [[sharedUser savedLocations] count]){
        [self performSegueWithIdentifier:@"pushAddLocation" sender:self];
    }else if  ([locationTableView isEditing]){
        selectedLocation = [[sharedUser savedLocations] objectAtIndex:idx];
        [sharedUser setIsEditingLocation:YES];
        [sharedUser setEditingLocation:selectedLocation];
        [self performSegueWithIdentifier:@"pushAddLocation" sender:self];
    }else{
        selectedLocation = [[sharedUser savedLocations] objectAtIndex:idx];
        NSString *selectedName =  [selectedLocation name];
        
        [sharedLocation setName:selectedName];
        
        NSLog(@"%@", selectedName);
        NSLog(@"%@", [sharedLocation name]);
        
        [self performSegueWithIdentifier:@"pushMainMenu" sender:self];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    NSLog(@"#of saved locations: %d", [[sharedUser savedLocations] count]);
	return [[sharedUser savedLocations] count] + 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//initialize a cell
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCellID"];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LocationCell"];
	}
	//get the relevant location from the array
    NSString *name;
    if (indexPath.row == [[sharedUser savedLocations] count]){
        name = @"Add New Location";
    }else {
        Location *curLocation = [[sharedUser savedLocations] objectAtIndex:indexPath.row];
        name =  [curLocation name];
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
    if (indexPath.row >= [[sharedUser savedLocations] count]) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[sharedUser savedLocations] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}



// Returns a UIView that serves as the footer for this table view
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	if(footerView == nil)
	{
		footerView = [[UIView alloc] init];
		
		chooseFromMap = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[chooseFromMap setFrame:CGRectMake(10, 20, 300, 40)];
		[chooseFromMap setTitle:@"Choose from Map" forState:UIControlStateNormal];
		[chooseFromMap addTarget:self
						  action:@selector(showMap)
				forControlEvents:UIControlEventTouchUpInside];
		
		[footerView addSubview:chooseFromMap];
	}
	
	return footerView;
}

// Tells the table view how tall its footer should be (the footer contains the Choose from Map button)
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 60;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pushAddLocation"] && [sharedUser isEditingLocation]){
        [[[segue destinationViewController] navigationItem] setTitle:@"Editing Location"];
    }else{
        [[[segue destinationViewController] navigationItem] setTitle:[[Location sharedLocation] name]];
        NSLog(@"shared  location: %@", [[Location sharedLocation] name]);
    }
}

@end
