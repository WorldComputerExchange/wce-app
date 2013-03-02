//
//  LocationViewController.m
//  WCE
//
//

#import "LocationViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

@synthesize locationArray;
@synthesize locationTableView;

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
    locationArray = [[NSMutableArray alloc] init];
    [locationArray addObject:@"Liberia"];
    [locationArray addObject:@"Pakistan"];
    [locationArray addObject:@"Stony Point"];
    [locationArray addObject:@"Pennsylvania"];
    
    
    
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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return [locationArray count];
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
	NSString *location =  [self.locationArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = location;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
	return cell;
}

@end
