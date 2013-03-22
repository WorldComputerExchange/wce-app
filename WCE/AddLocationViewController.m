//
//  AddLocationViewController.m
//  WCE
//
//

#import "AddLocationViewController.h"

@interface AddLocationViewController ()

@end

@implementation AddLocationViewController

@synthesize locations, countries, languages, actionSheet, dropDownTableView, dataArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated{
        
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    dataArray = [[NSArray alloc] initWithObjects:@"Country", @"Language", nil];
    
    countries = [[NSArray alloc] initWithObjects:@"Libya", @"Zambia", @"Pakistan", @"Guatemala", nil];
    
    languages = [[NSArray alloc] initWithObjects:@"French", @"Arabic", @"English", @"Spanish", nil];
	
	// Add a "Save" button to the navigation controller
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save"
																   style:UIBarButtonItemStyleDone
																  target:self
																  action:@selector(saveInfo)];
	[[self navigationItem] setRightBarButtonItem:saveButton];
}


/*PickerView Methods*/
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == countryPicker){
        return [countries count];
    }else if (pickerView.tag == languagePicker){
        return [languages count];
    }else {
        return [languages count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == countryPicker){
        return [countries objectAtIndex:row];
    }else{
        return [languages objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	
}

- (void)pickerDoneClicked
{
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (IBAction)saveInfo
{
	NSLog(@"saving!!!");
}


/**TableView methods**/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DataCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DataCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    return cell;
}

/**TableView Methods**/
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int idx = indexPath.row; //row 0 corresponds to country picker view, row 1 to language
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:nil
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    
    if (idx == countryPicker){
        pickerView.tag = countryPicker;
    }else {
        pickerView.tag = languagePicker;
    }
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Next"]];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelChanges:(id)sender
{
	///// Here's both a UIAlertView and a UIActionSheet--I don't know what you might think looks better so both of them are here to try out
	
	//UIAlertView *cancelConfirmation = [[UIAlertView alloc] initWithTitle:@"Discard changes?"
															//	 message:@"The changes you made here won't be saved. Do you want to continue?"
																//delegate:self
													//   cancelButtonTitle:@"Cancel"
													  // otherButtonTitles:@"Discard", nil];
	
	//[cancelConfirmation show];
	
	
	UIActionSheet *cancelConfirmation = [[UIActionSheet alloc] initWithTitle:@"Are you sure you want to discard the changes you've made to this location?"
																	delegate:self
														   cancelButtonTitle:@"Cancel"
													  destructiveButtonTitle:@"Discard Changes"
														   otherButtonTitles:nil];
	
	[cancelConfirmation showInView:[[UIApplication sharedApplication] keyWindow]];
	
}

// Called when a button is clicked in the UIAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 1)
		[self dismissViewControllerAnimated:YES completion:nil];
}

// Called when a button is clicked in the UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
        [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveChanges:(id)sender
{
	[self saveNewLocation];
}

- (void)saveNewLocation
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
