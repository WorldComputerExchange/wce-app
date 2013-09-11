//
//  AddLocationViewController.m
//  WCE
//
//

#import "AddLocationViewController.h"
#import "User.h"
#import "Location.h"
#import "DataAccess.h"

@interface AddLocationViewController ()

@property (nonatomic, readonly) CGPoint originalOffset;
@property (nonatomic, readonly) UIView *activeField;

@end

@implementation AddLocationViewController

@synthesize locations, countries, languages, actionSheet, dataArray, sharedUser, selectedCountry, selectedLanguage;
@synthesize location, contact, phone, address, city, zip;


- (IBAction)backgroundTouched:(id)sender {
    [location resignFirstResponder];
    [contact resignFirstResponder];
    [phone resignFirstResponder];
    [address resignFirstResponder];
    [city resignFirstResponder];
    [zip resignFirstResponder];
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


- (void)viewWillAppear:(BOOL)animated
{
	[[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.gif"]]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dataArray = [[NSArray alloc] initWithObjects:@"Country", @"Language", nil];
    
    countries = [[NSArray alloc] initWithObjects:
                 @"Afghanistan", @"Albania", @"Algeria", @"Andorra", @"Angola", @"Antigua and Barbuda", @"Argentina", @"Armenia", @"Aruba", @"Azerbaijan", @"Bahamas", @"Bahrain", @"Bangladesh", @"Barbados", @"Bassas da India", @"Belarus", @"Belize", @"Benin", @"Bermuda", @"Bhutan", @"Bolivia", @"Bosnia and Herzegovina", @"Botswana", @"Brasil", @"Brunei", @"Bulgaria", @"Burkina Faso", @"Burma", @"Burundi", @"Cambodia", @"Cameroon", @"Cape Verde", @"Cayman Islands", @"Central African Republic", @"Chad", @"Chile", @"China", @"Colombia", @"Comoros", @"Congo, Democratic Republic of the", @"Congo, Republic of the", @"Costa Rica", @"Cote d'Ivoire", @"Croatia", @"Cuba", @"Cyprus", @"Dhekelia", @"Dijibouti", @"Dominica", @"Dominican Republic", @"Ecuador", @"Egypt", @"El Salvador", @"Equatorial Guinea", @"Eritrea", @"Ethiopia", @"Fiji", @"French Guiana", @"French Polynesia", @"Gabon", @"The Gambia", @"Ghana", @"Georgia", @"Ghana", @"Guam", @"Guatemala", @"Guinea", @"Guinea Bissau", @"Guyana", @"Haiti", @"Honduras", @"India", @"Indonesia", @"Iran", @"Iraq", @"Jamaica", @"Jordan", @"Kazakhstan", @"Kenya", @"Kiribati", @"Kuwait", @"Kyrgyzstan", @"Laos", @"Lesotho", @"Liberia", @"Libya", @"Lithuania", @"Macau", @"Macedonia", @"Madagascar", @"Malawi", @"Malaysia", @"Mali", @"Marshall Islands", @"Martinique", @"Mauritania", @"Mauritius", @"Mayotte", @"Mexico", @"Micronesia", @"Mongolia", @"Moldova", @"Morocco", @"Mozambique", @"Namibia", @"Nepal", @"New Zealand", @"Nicaragua", @"Niger", @"Nigeria", @"Oman", @"Pakistan", @"Palau", @"Panama", @"Papua New Guinea", @"Paraguay", @"Peru", @"Philippines", @"Poland", @"Qatar", @"Romania", @"Russia", @"Rwanda", @"Saint Lucia", @"Samoa", @"Saudi Arabia", @"Senegal", @"Serbia and Montenegro", @"Sierra Leone", @"Singapore", @"Slovakia", @"Slovenia", @"Solomon Islands", @"Somalia", @"South Africa",  @"Sri Lanka",  @"Sudan",  @"Suriname",  @"Swaziland",  @"Syria",  @"Tajikistan",  @"Tanzania",  @"Thailand",  @"Timor-Leste",  @"Togo",  @"Tokelau",  @"Tonga",  @"Trinidad and Tobago",  @"Tunisia",  @"Turkey",  @"Turkmenistan",  @"Turks and Caicos Islands",  @"Tuvalu",  @"Uganda",  @"Ukraine",  @"United Arab Emirates",  @"United Kingdom",  @"United States", @"Uruguay",  @"Uzbekistan",  @"Vanuatu", @"Venezuala", @"Vietnam", @"Virgin Islands", @"Western Sahara", @"Yemen", @"Zambia", @"Zimbabwe", nil];

    languages = [[NSArray alloc] initWithObjects:@"French", @"Arabic", @"English", @"Spanish", nil];
	
	// Add a "Save" button to the navigation controller
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save"
																   style:UIBarButtonItemStyleDone
																  target:self
																  action:@selector(saveChanges)];
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
        zip.text = editingLocation.zip;
        selectedLanguage = editingLocation.language;
        selectedCountry = editingLocation.country;
    }
}


- (void)viewDidDisappear:(BOOL)animated{
    [sharedUser setIsEditingLocation:false];
}


/**
 PickerView Methods
 **/
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

//Call method to save new location
- (IBAction)saveChanges:(id)sender
{
	[self saveNewLocation];
}

- (void)saveNewLocation
{
    /*save input fields to our user
     Should check that these values are non-null!*/
    Location *curLocation = [[Location alloc] init];
    
    if(location.text.length > 0){
        [curLocation setName:location.text];
    
        [curLocation setContact:contact.text];
    
        [curLocation setPhone:phone.text];
    
        [curLocation setAddress:address.text];
    
        [curLocation setCity:city.text];
        NSLog(@"selectedCountry %@", selectedCountry);
        NSLog(@"selectedLanguage %@", selectedLanguage);
        [curLocation setCountry:selectedCountry];
    
        [curLocation setLanguage:selectedLanguage];
    
        /**check if a location with this name exists already and replace it if it does**/
        int savedIdx;
        BOOL replaced = false;
        
        NSInteger savedLocationId; //if this location exists get its locationId for updating
    
        NSMutableArray *savedLocations = [sharedUser savedLocations];
        for (int idx = 0; idx < [savedLocations count]; idx++){
            Location *cur = [savedLocations objectAtIndex:idx];
            if ([cur.name isEqualToString:curLocation.name] ||
                [cur.name isEqualToString: [[sharedUser editingLocation] name]]){
                replaced = true;
                savedIdx = idx;
                savedLocationId = cur.locationId;
            }
            NSLog(@"index %d", idx);
        }
        
        //create dataAccess object
        DataAccess *db = [[DataAccess alloc] init];
        
        NSInteger curLocationId;
        
        if (!replaced){ //location not found, add the location
            //Save to database
            //remove redundancy once this is working
            
            BOOL success = [db insertLocation:curLocation];
            
            if(success){
                NSLog(@"Location %@ successfully added to database.", curLocation.name);
                //get the location id of the added location to add to the array
                curLocationId = [db getLocationIdForName:curLocation.name]; //not working always returns 0
                
                NSLog(@"Current location id %i", curLocationId);
                
                [curLocation setLocationId:curLocationId];
            }else{
                NSLog(@"Adding location %@ failed", curLocation.name);
            }
            [[sharedUser savedLocations] addObject:curLocation];
            
            
        }else{ //location exists update the location
            [[sharedUser savedLocations] replaceObjectAtIndex:savedIdx withObject:curLocation];
            
            curLocation.locationId = savedLocationId; //set the locationId to that of found location
            NSLog(@"Saved Location id: %i", savedLocationId);
            
            BOOL success = [db updateLocation:curLocation withName:[[sharedUser editingLocation] name]]; //update the location
            
            if(success){
                NSLog(@"Location %@ successfully updated database.", curLocation.name);
            }else{
                NSLog(@"Updating location %@ failed", curLocation.name);
            }
            
        }
        
        NSLog(@"Locations count %d", [[sharedUser savedLocations] count]);
		
		// save everything
		//[sharedUser saveAllLocations];
        
		
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        //Alert the user that a blank location name has been entered
        UIAlertView *blankNameMessage = [[UIAlertView alloc] initWithTitle:@"Blank Location Name" message:@"Please enter a location name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        // Actually shows the alert message
        [blankNameMessage show];
        
    }
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
    fieldOrigin = [self.view convertPoint:fieldOrigin toView:self.view.superview];
    _originalOffset = _scrollView.contentOffset;
	
	// scroll the scrollview down a tiny bit more
	CGRect fieldRect = _activeField.frame;
	CGRect tallerRect = CGRectMake(fieldRect.origin.x, fieldRect.origin.y, fieldRect.size.width, fieldRect.size.height + 50); // 50 more
	
    if (!CGRectContainsPoint(aRect, fieldOrigin) ) {
        [_scrollView scrollRectToVisible:tallerRect animated:YES];
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
	_activeField = textField;
}

@end
