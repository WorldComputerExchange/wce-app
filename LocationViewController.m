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

@synthesize locationTableView, locations, footerView, chooseFromMap, sharedLocation, sharedUser;


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
    
    locations = [[NSMutableArray alloc] initWithObjects:@"ABC School", @"Xavier School", @"Chicago", @"Cairo", @"Ayacucho", nil];
    
    //get shared location instance
    sharedLocation = [Location sharedLocation];
    
    //get shared user instance
    sharedUser = [User sharedUser];
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

/*- (IBAction)OrBoton:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [button setBackgroundColor:[UIColor blackColor]];
}*/


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
    
    NSString *selectedName = [locations objectAtIndex:idx];
    
    [sharedLocation setName:selectedName];
    
    [self performSegueWithIdentifier:@"pushMainMenu" sender:self];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
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
        name =  [[sharedUser savedLocations] objectAtIndex:indexPath.row];
	}
	cell.textLabel.text = name;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	/*[[[segue destinationViewController] navigationItem] setTitle:[[Location sharedLocation] name]];*/
	NSLog(@"sharedl ocation: %@", [[Location sharedLocation] name]);
}

@end
