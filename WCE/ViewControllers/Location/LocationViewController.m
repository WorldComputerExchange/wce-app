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
#import "CustomCell.h"
#import "CHCSVParser.h"
#import "DataAccess.h"
#import "CoverSheet.h"
#import "Evaluation.h"
#import "ImpQuestions.h"
#import "Order.h"
#import "Partner.h"


@interface LocationViewController ()

@property UIDocumentInteractionController *documentInteractionController;
@property NSURL *csvURL;

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
    
    UIImage *bg = [[UIImage imageNamed:@"button-bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [self.previewCSVButton setBackgroundImage:bg forState:UIControlStateNormal];
    [self.sendCSVButton setBackgroundImage:bg forState:UIControlStateNormal];
    
    [self.locationTableView registerClass:[CustomCell class]
           forCellReuseIdentifier:@"customCell"];
    
    //get shared location instance
    self.sharedLocation = [Location sharedLocation];
    
    NSLog(@"sharedLocation %@", [self.sharedLocation name]);
    
    //get shared user instance
    self.sharedUser = [User sharedUser];
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
    
    if([self.locationTableView isEditing]){ //Exit editing mode
        
        NSLog(@"Exited editing mode");
        [self.locationTableView setEditing:NO animated:YES];
        
        //Replace done button with edit button
        [self.editButton setStyle:UIBarButtonItemStylePlain];
        [self.editButton setTitle:@"Edit"];
        
    }else { //Enter editing mode
        
         NSLog(@"Entered editing mode");
        [self.locationTableView setEditing:YES animated:YES];
        [self.locationTableView setAllowsSelectionDuringEditing:YES];
		
        //replace edit button with done button
        [self.editButton setStyle:UIBarButtonItemStyleDone];
        [self.editButton setTitle:@"Done"];
    }
}



#pragma mark - CSV methods
-(void)pushFormDatatoCSV{
    NSLog(@"Pushing form data to CSV");
    
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filename = @"Wce.csv";
    NSURL *fileURL = [NSURL fileURLWithPathComponents:[NSArray arrayWithObjects:documentsDirectory, filename, nil]];
    
    self.csvURL = fileURL;
    
    CHCSVWriter *csvExporter = [[CHCSVWriter alloc] initForWritingToCSVFile:[fileURL path]];
    
    User *sharedUser = [User sharedUser];
    
    DataAccess *db = [[DataAccess alloc] init];
    
    
    for (Location *loc in sharedUser.savedLocations){
        [csvExporter writeComment:@"Location"];
        [csvExporter writeLineOfFields:[NSArray arrayWithObjects:@"Name", @"Contact", @"Phone",
                                        @"Address", @"Zipcode", @"City", @"Country", @"Language", nil]];
        [csvExporter writeLineOfFields:loc.locationProperties];
        
        Evaluation *evalForm = [db getEvalForLocation:loc];
        if (evalForm.evalId > 0) {
            [csvExporter writeComment:@"Evaluation Form"];
            [csvExporter writeLineOfFields:[NSArray arrayWithObjects:@"Location name", @"Questions", nil]];
            [csvExporter writeLineOfFields:[[NSArray arrayWithObject:loc.name] arrayByAddingObjectsFromArray:evalForm.evaluationProperties]];
        }
        
        NSMutableArray *partners = [db getPartnersForLocationName:loc.name];
        if (partners.count > 0) {
            [csvExporter writeComment:@"Partners"];
            [csvExporter writeLineOfFields:[NSArray arrayWithObjects:@"Partner Name", @"Location Name", nil]];
        }
        for (Partner *par in partners){
            NSArray *partnerFields = [NSArray arrayWithObjects:par.name, loc.name, nil];
            [csvExporter writeLineOfFields:partnerFields];
            CoverSheet *coverSheet = [db getCoverSheetForPartner:par];
            if (coverSheet.coverSheetId > 0) {
                [csvExporter writeComment:@"Cover Sheet"];
                [csvExporter writeLineOfFields:[NSArray arrayWithObjects:@"Partner Name", @"Location Name", @"Questions", nil]];
                [csvExporter writeLineOfFields:[partnerFields arrayByAddingObjectsFromArray:coverSheet.coverSheetproperties]];
            }
            Order *order = [db getOrderForPartner:par];
            if (order.orderId > 0) {
                [csvExporter writeComment:@"Order"];
                [csvExporter writeLineOfFields:[NSArray arrayWithObjects:@"Partner Name", @"Location Name", @"Questions", nil]];
                [csvExporter writeLineOfFields:[partnerFields arrayByAddingObjectsFromArray:order.orderProperties]];
            }
            ImpQuestions *impQuestions = [db getImpForPartner:par];
            if (impQuestions.impId > 0) {
                [csvExporter writeComment:@"Implementation Questions"];
                [csvExporter writeLineOfFields:[NSArray arrayWithObjects:@"Partner Name", @"Location Name", @"Questions", nil]];
                [csvExporter writeLineOfFields:[partnerFields arrayByAddingObjectsFromArray:impQuestions.impProperties]];
            }
            
        }
        [csvExporter writeField:@" "];
        [csvExporter finishLine];
        [csvExporter writeField:@" "];
        [csvExporter finishLine];
    }
    
    [csvExporter closeStream];
}

-(IBAction)previewCSVFile:(id)sender{
    
    [self pushFormDatatoCSV];
        
    if (self.csvURL) {
        
        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:self.csvURL];
        
        [self.documentInteractionController setDelegate:self];
        
        [self.documentInteractionController presentPreviewAnimated:YES];
    }
}

-(IBAction)sendCSVFile:(id)sender{
    NSLog(@"Send CSV file button pressed");
}

#pragma mark - DocumentInteractionControllerDelegate methods
- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller {
    return self;
}

-(IBAction)logoff:(id)sender{
    [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"loggedIn"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	WCEAppDelegate *appDelegate = (WCEAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate presentLoginViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	BOOL isLoggedIn = [[NSUserDefaults standardUserDefaults] boolForKey:@"loggedIn"];
	
	if(isLoggedIn)
	{
		//show navigation bar programmatically
		[self.navigationItem setTitle:@"Choose Location"];
		
		[self.locationTableView setBackgroundView:nil];
		
		[self.locationTableView reloadData];
		
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
    
    if (idx >= [[self.sharedUser savedLocations] count]){ //Add location row selected
        [self performSegueWithIdentifier:@"pushAddLocation" sender:self];
    }else if  ([self.locationTableView isEditing]){ //location selected in editing mode
        selectedLocation = [[self.sharedUser savedLocations] objectAtIndex:idx];
        [self.sharedUser setIsEditingLocation:YES];
        [self.sharedUser setEditingLocation:selectedLocation];
        [self performSegueWithIdentifier:@"pushAddLocation" sender:self];
    }else{ //location selected NOT in editing mode
        
        selectedLocation = [[self.sharedUser savedLocations] objectAtIndex:idx];
        NSString *selectedName =  [selectedLocation name];

        
        [self.sharedLocation setName:selectedName];
        [self.sharedLocation setContact:[selectedLocation contact]];
        [self.sharedLocation setAddress: [selectedLocation address]];
        [self.sharedLocation setPhone:[selectedLocation phone]];
        [self.sharedLocation setCity: [selectedLocation city]];
        [self.sharedLocation setCountry:[selectedLocation country]];
        [self.sharedLocation setZip: [selectedLocation zip]];
        [self.sharedLocation setLanguage: [selectedLocation language]];
        [self.sharedLocation setLocationId:[selectedLocation locationId]];
        
        [self performSegueWithIdentifier:@"pushMainMenu" sender:self];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return [[self.sharedUser savedLocations] count] + 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    // cell background image view
    UIImageView *background;
    UIImageView *selectedBackground;
    
    //no locations, solo cell
    if ([tableView numberOfRowsInSection:indexPath.section] == 1){
        background = [[UIImageView alloc] initWithImage:
                      [UIImage imageNamed:@"solo-cell-bg.png"]];
        selectedBackground = [[UIImageView alloc] initWithImage:
                              [UIImage imageNamed:@"solo-cell-bg-selected.png"]];
    }else if (indexPath.row == 0) { //first cell
        background = [[UIImageView alloc] initWithImage:
                      [UIImage imageNamed:@"top-cell-bg.png"]];
        selectedBackground =  [[UIImageView alloc] initWithImage:
                               [UIImage imageNamed:@"top-cell-bg-selected.png"]];
    } else if (indexPath.row ==
               [tableView numberOfRowsInSection:indexPath.section] - 1) { //last cell
        background = [[UIImageView alloc] initWithImage:
                      [UIImage imageNamed:@"bottom-cell-bg.png"]];
        selectedBackground = [[UIImageView alloc] initWithImage:
                              [UIImage imageNamed:@"bottom-cell-selected-bg.png"]];
        // middle cells
    } else {
        background = [[UIImageView alloc] initWithImage:
                      [UIImage imageNamed:@"middle-cell-bg.png"]];
        selectedBackground = [[UIImageView alloc] initWithImage:
                              [UIImage imageNamed:@"middle-cell-bg-selected.png"]];
    }
    background.alpha = 0.70; //make background semitransparent
    
    // set background view
    [cell setSelectedBackgroundView:selectedBackground];
    [cell setBackgroundView:background];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"customCell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	//get the relevant location from the array
    NSString *name;

    //set up edit accessory view
    UIImage *edit= [UIImage imageNamed:@"edit-disclosure.png"];
    UIImageView* editView = [[UIImageView alloc] initWithImage:edit];
    if (indexPath.row == [[self.sharedUser savedLocations] count]){
        name = @"Add New Location";
        cell.editingAccessoryView = nil;
    }else {
        Location *curLocation = [[self.sharedUser savedLocations] objectAtIndex:indexPath.row];
        name =  [curLocation name];
        cell.editingAccessoryView = editView;
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
    if (indexPath.row >= [[self.sharedUser savedLocations] count]) {
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
        Location *curLocation = [[self.sharedUser savedLocations] objectAtIndex:indexPath.row];
        
        DataAccess *db = [[DataAccess alloc] init];
        
        BOOL success = [db deleteLocation:curLocation]; //delete from database
        
        if(!success){
            NSLog(@"Location %@ could not be deleted from the database", curLocation.name);
        }else{
            NSLog(@"Location %@ successfully deleted from the database", curLocation.name);
        }
        
        [[self.sharedUser savedLocations] removeObjectAtIndex:indexPath.row]; //remove from User array
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        if (indexPath.row == 0) {
            //reload the top cell with an animation because image needs to be modified
            NSIndexPath *modifiedCellIdx = [NSIndexPath indexPathForRow:0 inSection:0];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:modifiedCellIdx] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pushAddLocation"] && [self.sharedUser isEditingLocation]){
        [[[segue destinationViewController] navigationItem] setTitle:@"Editing Location"];
    }else if ([[segue identifier] isEqualToString:@"pushAddLocation"]) {
        [[[segue destinationViewController] navigationItem] setTitle:@"Add Location"];
    }else{
        [[segue destinationViewController] setHidesBottomBarWhenPushed:YES]; //need to hide tab on all contained views
        [[[segue destinationViewController] navigationItem] setTitle:[[Location sharedLocation] name]];
        NSLog(@"shared  location: %@", [[Location sharedLocation] name]);
    }
}

@end
