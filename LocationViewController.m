//
//  LocationViewController.m
//  WCE
//
//

#import "LocationViewController.h"
#import "Location.h"
#import "User.h"
#import "WCETabBarController.h"

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
		
		if([sender isKindOfClass:[WCETabBarController class]])
		{
			WCETabBarController *tabController = (WCETabBarController *)sender;
			[[tabController editButton] setStyle:UIBarButtonItemStylePlain];
			[[tabController editButton] setTitle:@"Edit"];
		}
    }else {
         NSLog(@"Entered editing mode");
        [locationTableView setEditing:YES animated:YES];
        [locationTableView setAllowsSelectionDuringEditing:YES];
		
		if([sender isKindOfClass:[WCETabBarController class]])
		{
			WCETabBarController *tabController = (WCETabBarController *)sender;
			[[tabController editButton] setStyle:UIBarButtonItemStyleDone];
			[[tabController editButton] setTitle:@"Done"];
		}
    }
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	BOOL isLoggedIn = [[NSUserDefaults standardUserDefaults] boolForKey:@"loggedIn"];
	
	if(isLoggedIn)
	{
		//show navigation bar programmatically
		[self.navigationItem setTitle:@"Choose Location"];
		
		[locationTableView setBackgroundView:nil];
		[locationTableView setBackgroundColor:[UIColor clearColor]];
		[locationTableView setSeparatorColor:[UIColor lightGrayColor]];
		[locationTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
		
		[locationTableView reloadData];
		
		[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
	}
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
        [sharedLocation setContact:[selectedLocation contact]];
        [sharedLocation setAddress: [selectedLocation address]];
        [sharedLocation setPhone:[selectedLocation phone]];
        [sharedLocation setCity: [selectedLocation city]];
        [sharedLocation setCountry:[selectedLocation country]];
        [sharedLocation setZip: [selectedLocation zip]];
        [sharedLocation setLanguage: [selectedLocation language]];
        
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
		
		// save these changes
		[sharedUser saveAllLocations];
    }
}


// Tells the table view how tall its footer should be (the footer contains the Choose from Map button)
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 0;
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
