//
//  LocationViewController.m
//  WCE
//
//

/**
 Location menu where a user can add or choose a location
 **/

#import "LocationViewController.h"
#import "Location.h"
#import "User.h"
#import "WCETabBarController.h"
#import "DataAccess.h"
#import "CustomCell.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

@synthesize locationTableView, chooseFromMap, sharedLocation, sharedUser;


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
    

    [locationTableView registerClass:[CustomCell class]
           forCellReuseIdentifier:@"customCell"];
    
    //get shared location instance
    sharedLocation = [Location sharedLocation];
    NSLog(@"sharedLocation %@", [sharedLocation name]);
    
    //get shared user instance
    sharedUser = [User sharedUser];
}

/**Push the Map View Screen
   Called when Map icon in tab bar is pushed**/
- (void)showMap
{
	[self performSegueWithIdentifier:@"pushMapView" sender:self];
}


/**Enables/Disables editing of table rows, deleting and editing locations
 Called when edit button in nav bar is pushed**/
-(IBAction)enterEditingMode:(id)sender{
    
    if([locationTableView isEditing]){ //Exit editing mode
        NSLog(@"Exited editing mode");
        [locationTableView setEditing:NO animated:YES];
        [locationTableView reloadData];
		
        //Replace done button with edit button
		if([sender isKindOfClass:[WCETabBarController class]])
		{
			WCETabBarController *tabController = (WCETabBarController *)sender;
			[[tabController editButton] setStyle:UIBarButtonItemStylePlain];
			[[tabController editButton] setTitle:@"Edit"];
		}
    }else { //Enter editing mode 
         NSLog(@"Entered editing mode");
        [locationTableView setEditing:YES animated:YES];
        [locationTableView setAllowsSelectionDuringEditing:YES];
		
        //replace edit button with done button
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
    
    int idx = indexPath.row;
    Location *selectedLocation;
    
    if (idx >= [[sharedUser savedLocations] count]){ //Add location row selected
        [self performSegueWithIdentifier:@"pushAddLocation" sender:self];
    }else if  ([locationTableView isEditing]){ //location selected in editing mode
        selectedLocation = [[sharedUser savedLocations] objectAtIndex:idx];
        [sharedUser setIsEditingLocation:YES];
        [sharedUser setEditingLocation:selectedLocation];
        [self performSegueWithIdentifier:@"pushAddLocation" sender:self];
    }else{ //location selected NOT in editing mode
        
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
        [sharedLocation setLocationId:[selectedLocation locationId]];
        
        [self performSegueWithIdentifier:@"pushMainMenu" sender:self];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return [[sharedUser savedLocations] count] + 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    // cell background image view
    UIImageView *background;
    
    // first cell check
    if ([[sharedUser savedLocations] count] == 0){
        background = [[UIImageView alloc] initWithImage:
                      [UIImage imageNamed:@"solo-cell-bg.png"]];
    }else if (indexPath.row == 0) {
        background = [[UIImageView alloc] initWithImage:
                      [UIImage imageNamed:@"top-cell-bg.png"]];
        // last cell check
    } else if (indexPath.row ==
               [tableView numberOfRowsInSection:indexPath.section] - 1) {
        background = [[UIImageView alloc] initWithImage:
                      [UIImage imageNamed:@"bottom-cell-bg.png"]];
        // middle cells*/
    } else {
        background = [[UIImageView alloc] initWithImage:
                      [UIImage imageNamed:@"middle-cell-bg.png"]];
    }
    background.alpha = 0.70; //make background semitransparent
    // set background view
    [cell setBackgroundView:background];
    // release image view
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"customCell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	//get the relevant location from the array
    NSString *name;
    if (indexPath.row == [[sharedUser savedLocations] count]){
        name = @"Add New Location";
    }else {
        Location *curLocation = [[sharedUser savedLocations] objectAtIndex:indexPath.row];
        name =  [curLocation name];
	}

    cell.mainTextLabel.text = name;

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


/**
 Delete button hit
 remove the location from the array and database
 **/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Location *curLocation = [[sharedUser savedLocations] objectAtIndex:indexPath.row];
        
        DataAccess *db = [[DataAccess alloc] init];
        
        BOOL success = [db deleteLocation:curLocation]; //delete from database
        
        if(!success){
            NSLog(@"Location %@ could not be deleted from the database", curLocation.name);
        }else{
            NSLog(@"Location %@ successfully deleted from the database", curLocation.name);
        }
        
        [[sharedUser savedLocations] removeObjectAtIndex:indexPath.row]; //remove from User array
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
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
