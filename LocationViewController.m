//
//  LocationViewController.m
//  WCE
//
//

#import "LocationViewController.h"
#import "Location.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

@synthesize regionArray, locationTableView, locations, actionSheet, footerView, chooseFromMap, sharedLocation;


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
    regionArray = [[NSArray alloc] initWithObjects:
                   @"Africa", @"Asia", @"Caribbean",
                   @"Eastern Europe", @"Latin America",
                   @"Middle East", nil];
    
    locations = [[NSMutableArray alloc] initWithObjects:@"ABC School", @"Xavier School", @"Chicago", @"Cairo", @"Ayacucho", nil];
    
    //get shared location instance
    sharedLocation = [Location sharedLocation];
}

// Called when Choose from Map button is pressed
- (void)showMap
{
	[self performSegueWithIdentifier:@"pushMapView" sender:self];
}

- (void)viewWillAppear:(BOOL)animated{
    //show navigation bar programmatically
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setTitle:@"Choose Location"];
    
    [locationTableView setBackgroundView:nil];
    [locationTableView setBackgroundColor:[UIColor blackColor]];
}

- (IBAction)OrBoton:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [button setBackgroundColor:[UIColor blackColor]];
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
    
    NSString *selectedRegion = [regionArray objectAtIndex:idx];
    
    [sharedLocation setRegion:selectedRegion];
    
    /**prepare pickerview for appearance**/
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:nil
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
    closeButton.momentary = YES;
    closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
    closeButton.tintColor = [UIColor colorWithRed:34.0/255.0 green:97.0/255.0 blue:221.0/255.0 alpha:1];
    [closeButton addTarget:self action:@selector(pickerDoneClicked) forControlEvents:UIControlEventValueChanged];
    
    [actionSheet addSubview:pickerView];
    [actionSheet addSubview:closeButton];
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return [regionArray count];
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
	NSString *region =  [self.regionArray objectAtIndex:indexPath.row];
	
	cell.textLabel.text = region;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
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

/**PickerView Methods**/
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [locations count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [locations objectAtIndex:row];
}

- (void)pickerDoneClicked
{
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
    
    /**set the Location name to that chosen in the picker**/
    int idx = [pickerView selectedRowInComponent:0];
    
    NSString *selectedName = [locations objectAtIndex:idx];
    
    [sharedLocation setName:selectedName];
    

    /**TEST***/
    [self performSegueWithIdentifier:@"pushMainMenu" sender:self];
}


@end
