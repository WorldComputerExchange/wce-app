//
//  CoverSheetViewController.m
//  WCE
//
//  Created by Sushruth Chandrasekar on 3/21/13.
//  Copyright (c) 2013  Brian Beckerle. All rights reserved.
//

#import "CoverSheetViewController.h"

@interface CoverSheetViewController ()

@end

@implementation CoverSheetViewController

@synthesize regionArray, locationTableView, locations, actionSheet, footerView, chooseFromMap, sharedLocation;

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
    regionArray = [[NSMutableArray alloc] init];
    [regionArray addObject:@"Country"];
   
    
    locations = [[NSMutableArray alloc] initWithObjects:@"Japan", @"China", @"Your Face", @"Peter Goulakos", @"Is Fat", nil];
    
    //get shared location instance
    sharedLocation = [Location sharedLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
