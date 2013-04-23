//
//  AddLocationViewController.m
//  WCE
//
//

#import "AddLocationViewController.h"
#import "User.h"
#import "Location.h"

@interface AddLocationViewController ()

@property (nonatomic, readonly) CGPoint originalOffset;
@property (nonatomic, readonly) UIView *activeField;

@end

@implementation AddLocationViewController

@synthesize locations, countries, languages, actionSheet, dropDownTableView, dataArray, sharedUser, selectedCountry, selectedLanguage;
@synthesize location, contact, phone, address, city;


- (IBAction)backgroundTouched:(id)sender {
    [location resignFirstResponder];
    [contact resignFirstResponder];
    [phone resignFirstResponder];
    [address resignFirstResponder];
    [city resignFirstResponder];
}

- (IBAction)textfieldReturn:(id)sender{
    [sender resignFirstResponder];
    
}


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
    
    countries = [[NSArray alloc] initWithObjects:
                 @"Afghanistan", @"Bangladesh",  @"Benin", @"Bolivia", @"Bosnia", @"Botswana",
                 @"Brasil", @"Bulgaria", @"Burkina Faso", @"Burundi",  @"Cambodia", @"Cameroon",
                 @"Chile", @"Colombia", @"Congo",  @"Costa Rica", @"D.R. Congo",
                 @"Dominican Republic", @"Ecuador", @"Egypt", @"El Salvador", @"Ethiopia",
                 @"The Gambia", @"Ghana",  @"Georgia", @"Guatemala", @"Guinea",
                 @"Guinea Bissau", @"Guyana", @"Haiti",  @"Honduras", @"India",
                 @"Indonesia", @"Iraq", @"Jamaica", @"Jordan", @"Kenya", @"Liberia",
                 @"Lithuania", @"Macedonia", @"Madagascar", @"Malawi", @"Mali",  @"Mexico",
                 @"Mongolia", @"Nepal", @"Moldova", @"Morocco", @"Mozambique", @"Namibia",
                 @"Nicaragua", @"Nigeria", @"Pakistan", @"Paraguay", @"Peru", @"Philippines",
                 @"Russia", @"Senegal", @"Sri Lanka", @"Ukraine", @"Venezuala", @"Test", nil];

    languages = [[NSArray alloc] initWithObjects:@"French", @"Arabic", @"English", @"Spanish", nil];
	
	// Add a "Save" button to the navigation controller
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save"
																   style:UIBarButtonItemStyleDone
																  target:self
																  action:@selector(saveInfo)];
	[[self navigationItem] setRightBarButtonItem:saveButton];
	
	// Listen for keyboard notifications
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:)
												 name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:)
												 name:UIKeyboardWillHideNotification object:nil];
    
    sharedUser = [User sharedUser];
    selectedCountry = @"None";
    selectedLanguage = @"None";
    
    if ([sharedUser isEditingLocation]){
        Location *editingLocation = [sharedUser editingLocation];
        location.text = editingLocation.name;
        contact.text = editingLocation.contact;
        phone.text = editingLocation.phone;
        address.text = editingLocation.address;
        city.text = editingLocation.city;
        selectedLanguage = editingLocation.language;
        selectedCountry = editingLocation.country;
    }
}


- (void)viewDidDisappear:(BOOL)animated{
    [sharedUser setIsEditingLocation:false];
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
    if (pickerView.tag == countryPicker){
        selectedCountry = [countries objectAtIndex:row];
    }else{
        selectedLanguage = [languages objectAtIndex:row];
    }
}

- (void)pickerDoneClicked
{
    [dropDownTableView reloadData];
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
    int idx = indexPath.row;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DataCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DataCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    cell.textLabel.text = [dataArray objectAtIndex:idx];
    
    if (idx == 0){
        cell.detailTextLabel.text = selectedCountry;
    }else {
        cell.detailTextLabel.text = selectedLanguage;
    }
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
    /*save input fields to our user
     Should check that these values are non-null!*/
    Location *curLocation = [[Location alloc] init];
    
    [curLocation setName:location.text];
    
    [curLocation setContact:contact.text];
    
    [curLocation setPhone:phone.text];
    
    [curLocation setAddress:address.text];
    
    [curLocation setCity:city.text];
    
    [curLocation setCountry:selectedCountry];
    
    [curLocation setLanguage:selectedLanguage];
    
    /**check if a location with this name exists already and replace it if it does**/
    int idx = 0;
    BOOL replaced = false;
    for (Location *cur in [sharedUser savedLocations]){
        if ([cur.name isEqualToString:curLocation.name] ||
            [cur.name isEqualToString: [[sharedUser editingLocation] name]]){
            [[sharedUser savedLocations] replaceObjectAtIndex:idx withObject:curLocation];
            replaced = true;
        }
        idx++;
    }
    if (!replaced){
        [[sharedUser savedLocations] addObject:curLocation];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// called when the keyboard is shown
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect toView:nil];
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
	
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    //aRect.size.height -= self.toolbar.frame.size.height;
    CGPoint fieldOrigin = _activeField.frame.origin;
    fieldOrigin.y -= _scrollView.contentOffset.y;
	fieldOrigin.y += 40;
    fieldOrigin = [self.view convertPoint:fieldOrigin toView:self.view.superview];
    _originalOffset = _scrollView.contentOffset;
    if (!CGRectContainsPoint(aRect, fieldOrigin) ) {
        [_scrollView scrollRectToVisible:_activeField.frame animated:YES];
    }
}

/// called when the keyboard is hidden
- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
	UIEdgeInsets contentInsets = UIEdgeInsetsZero;
	_scrollView.contentInset = contentInsets;
	_scrollView.scrollIndicatorInsets = contentInsets;
	[_scrollView setContentOffset:_originalOffset animated:YES];
}

/// called when a text field is selected
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	NSLog(@"text field began!!");
	_activeField = textField;
}

@end
