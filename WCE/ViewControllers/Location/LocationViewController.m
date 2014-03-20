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
#import "LoginViewController.h"
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
@property NSURL *partnersCsvURL;
@property NSURL *evalCsvURL;
@end

#define EVAL_BUTTON_TAG 0
#define PARTNER_BUTTON_TAG 1

@implementation LocationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    
    UIImage *bg = [[UIImage imageNamed:@"button-bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [self.previewEvalButton setBackgroundImage:bg forState:UIControlStateNormal];
    [self.sendEvalButton setBackgroundImage:bg forState:UIControlStateNormal];
    [self.previewPartnersButton setBackgroundImage:bg forState:UIControlStateNormal];
    [self.sendPartnersButton setBackgroundImage:bg forState:UIControlStateNormal];
    
    [self.locationTableView registerClass:[CustomCell class]
           forCellReuseIdentifier:@"customCell"];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    self.locationTableView.backgroundColor = [UIColor clearColor];
    self.locationTableView.backgroundView = backgroundImage;
    
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
    
    //set up a csvExporter for evaluations
    NSString *evalFileName = @"WceEvaluation.csv";
    NSURL *evalFileURL = [NSURL fileURLWithPathComponents:[NSArray arrayWithObjects:documentsDirectory, evalFileName, nil]];
    self.evalCsvURL = evalFileURL;
    
    CHCSVWriter *evalCsvExporter = [[CHCSVWriter alloc] initForWritingToCSVFile:[evalFileURL path]];
    
    //set up a csvExporter for new partners
    NSString *newPartnersFileName = @"WceNewPartners.csv";
    NSURL *newPartnersFileURL = [NSURL fileURLWithPathComponents:[NSArray arrayWithObjects:documentsDirectory, newPartnersFileName, nil]];
    self.partnersCsvURL = newPartnersFileURL;
    
    CHCSVWriter *newPartnersCsvExporter = [[CHCSVWriter alloc] initForWritingToCSVFile:[newPartnersFileURL path]];
    
    User *sharedUser = [User sharedUser];
    
    DataAccess *db = [[DataAccess alloc] init];
    
    
    for (Location *loc in sharedUser.savedLocations){
        //write location info for both csv files
        [evalCsvExporter writeComment:@"Location"];
        [evalCsvExporter writeLineOfFields:[NSArray arrayWithObjects:@"Name", @"Contact", @"Phone",
                                        @"Address", @"Zipcode", @"City", @"Country", @"Language", nil]];
        [evalCsvExporter writeLineOfFields:loc.locationProperties];
        
        [newPartnersCsvExporter writeComment:@"Location"];
        [newPartnersCsvExporter writeLineOfFields:[NSArray arrayWithObjects:@"Name", @"Contact", @"Phone",
                                            @"Address", @"Zipcode", @"City", @"Country", @"Language", nil]];
        [newPartnersCsvExporter writeLineOfFields:loc.locationProperties];
        
        //write evaluation data to eval csv
        Evaluation *evalForm = [db getEvalForLocation:loc];
        if (evalForm.evalId > 0) {
            [evalCsvExporter writeComment:@"Evaluation Form"];
            [evalCsvExporter writeLineOfFields:[NSArray arrayWithObjects:@"Location name", @"Questions", nil]];
            [evalCsvExporter writeLineOfFields:[[NSArray arrayWithObject:loc.name] arrayByAddingObjectsFromArray:evalForm.evaluationProperties]];
        }
        
        //write partners data and associated forms to new partners csv
        NSMutableArray *partners = [db getPartnersForLocationName:loc.name];
        if (partners.count > 0) {
            [newPartnersCsvExporter writeComment:@"Partners"];
            [newPartnersCsvExporter writeLineOfFields:[NSArray arrayWithObjects:@"Partner Name", @"Location Name", nil]];
        }
        for (Partner *par in partners){
            NSArray *partnerFields = [NSArray arrayWithObjects:par.name, loc.name, nil];
            [newPartnersCsvExporter writeLineOfFields:partnerFields];
            CoverSheet *coverSheet = [db getCoverSheetForPartner:par];
            if (coverSheet.coverSheetId > 0) {
                [newPartnersCsvExporter writeComment:@"Cover Sheet"];
                [newPartnersCsvExporter writeLineOfFields:[NSArray arrayWithObjects:@"Partner Name", @"Location Name", @"Questions", nil]];
                [newPartnersCsvExporter writeLineOfFields:[partnerFields arrayByAddingObjectsFromArray:coverSheet.coverSheetproperties]];
            }
            Order *order = [db getOrderForPartner:par];
            if (order.orderId > 0) {
                [newPartnersCsvExporter writeComment:@"Order"];
                [newPartnersCsvExporter writeLineOfFields:[NSArray arrayWithObjects:@"Partner Name", @"Location Name", @"Questions", nil]];
                [newPartnersCsvExporter writeLineOfFields:[partnerFields arrayByAddingObjectsFromArray:order.orderProperties]];
            }
            ImpQuestions *impQuestions = [db getImpForPartner:par];
            if (impQuestions.impId > 0) {
                [newPartnersCsvExporter writeComment:@"Implementation Questions"];
                [newPartnersCsvExporter writeLineOfFields:[NSArray arrayWithObjects:@"Partner Name", @"Location Name", @"Questions", nil]];
                [newPartnersCsvExporter writeLineOfFields:[partnerFields arrayByAddingObjectsFromArray:impQuestions.impProperties]];
            }
            
        }
        [evalCsvExporter writeField:@" "];
        [evalCsvExporter finishLine];
        [evalCsvExporter writeField:@" "];
        [evalCsvExporter finishLine];
        
        [newPartnersCsvExporter writeField:@" "];
        [newPartnersCsvExporter finishLine];
        [newPartnersCsvExporter writeField:@" "];
        [newPartnersCsvExporter finishLine];
    }
    
    [evalCsvExporter closeStream];
    [newPartnersCsvExporter closeStream];
}

-(IBAction)previewCSVFile:(id)sender{
    UIButton *currentButton = (UIButton *)sender;
    NSURL *curURL = [[NSURL alloc] init];
    if (currentButton.tag == EVAL_BUTTON_TAG){
        curURL = self.evalCsvURL;
    }else{
        curURL = self.partnersCsvURL;
    }
    
    [self pushFormDatatoCSV];
        
    if (curURL) {
        
        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:curURL];
    
        [self.documentInteractionController setDelegate:self];
        
        [self.documentInteractionController presentPreviewAnimated:YES];
    }
}

-(IBAction)sendCSVFile:(id)sender{
    NSLog(@"Send CSV file button pressed");
    
   
    if ([MFMailComposeViewController canSendMail]){
        
        UIButton *currentButton = (UIButton *)sender;
        NSArray *toRecipients = [[NSArray alloc] init];
        NSString *subjectString = [[NSString alloc] init];
        NSString *bodyString = [[NSString alloc] init];
        NSURL *curURL = [[NSURL alloc] init];
        NSString *fileString = [[NSString alloc] init];
        
        MFMailComposeViewController *mailView = [[MFMailComposeViewController alloc] init];
        mailView.mailComposeDelegate = self;
        
        if (currentButton.tag == EVAL_BUTTON_TAG){
            toRecipients = [toRecipients arrayByAddingObject:@"eCorps@WorldComputerExchange.org"];
            subjectString = @"WCE iPhone App: Evaluation Forms";
            bodyString = @"The Evaluation form data is attached, if you would like to say anything about it or the trip please write your comments above.";
            fileString = @"WceEvaluation.csv";
            curURL = self.evalCsvURL;
        }else{
            toRecipients = [toRecipients arrayByAddingObject:@"Partners@WorldComputerExchange.org"];
            subjectString = @"WCE iPhone App: New Partner forms";
            bodyString = @"The New Partner form data is attached, if you would like to say anything about it or the trip please write your comments above.";
            fileString = @"WceNewPartners.csv";
            curURL = self.partnersCsvURL;
        }
        
        [mailView setSubject:subjectString];
        
        [mailView setToRecipients:toRecipients];
        
        [mailView setMessageBody:bodyString isHTML:NO];
        
        //create the CSV file
        [self pushFormDatatoCSV];
        
        //attach the CSV file
        NSData *csvData = [NSData dataWithContentsOfURL:curURL];
        
        [mailView addAttachmentData:csvData mimeType:@"text/csv" fileName:fileString];
        
        [self presentViewController:mailView animated:YES completion:NULL];
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support in app email, please share the file from the preview CSV screen" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - MFMailViewControllerDelegate methods
-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setDelegate:nil];
    [alert setCancelButtonIndex:[alert addButtonWithTitle:@"OK"]];
    
    switch (result) {
            
        case MFMailComposeResultCancelled:
            NSLog(@"Message sending cancelled");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Message sending failed");
            [alert setTitle:@"Failed"];
            [alert setMessage:@"Message failed to send, possibly due to an error"];
            [alert show];
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Message saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Message sent successfully");
            [alert setTitle:@"Message sent"];
            [alert setMessage:@"Message sent successfully!"];
            [alert show];
            break;
        default:
            NSLog(@"Message not sent");
            [alert setTitle:@"Message not sent"];
            [alert setMessage:@"Message not sent"];
            [alert show];
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
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


/**TableView Methods**/
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger idx = indexPath.row;
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
