//
//  CoverSheetViewController.m
//  WCE
//
//  Created by Sushruth Chandrasekar on 3/21/13.
//  Updated by Alex on 4/20/13.
//

#import "CoverSheetViewController.h"
#import "CoverSheet.h"
#import "DataAccess.h" 
#import "User.h"

@interface CoverSheetViewController ()

@end

@implementation CoverSheetViewController



@synthesize regionArray, locationTableView, locations, actionSheet, selectedCountry, sharedUser, hasCoverSheet, savedCoverSheet;



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
    
    
    //get the coversheet for the current partner from the database if it exists
    sharedUser = [User sharedUser];
    
    Partner *curPartner = [sharedUser sharedPartner];
    
    DataAccess *db = [[DataAccess alloc] init];
    
    savedCoverSheet = [[CoverSheet alloc] init];
    savedCoverSheet = [db getCoverSheetForPartner:curPartner];
    
    if (savedCoverSheet.coverSheetId < 0) { //no cover sheet found
        hasCoverSheet = false;
        selectedCountry = @"None";
    }else {
        hasCoverSheet = true;
        selectedCountry = savedCoverSheet.q1;
        self.q2.text = savedCoverSheet.q2;
        self.q3.text = savedCoverSheet.q3;
        self.q4.text = savedCoverSheet.q4;
        self.q5.text = savedCoverSheet.q5;
        self.q6.text = savedCoverSheet.q6;
    }
    regionArray = [[NSArray alloc] initWithObjects:@"Country", nil];
    
    
    locations = [[NSArray alloc] initWithObjects:
                 @"Afghanistan", @"Albania", @"Algeria", @"Andorra", @"Angola", @"Antigua and Barbuda", @"Argentina", @"Armenia", @"Aruba", @"Azerbaijan", @"Bahamas", @"Bahrain", @"Bangladesh", @"Barbados", @"Bassas da India", @"Belarus", @"Belize", @"Benin", @"Bermuda", @"Bhutan", @"Bolivia", @"Bosnia and Herzegovina", @"Botswana", @"Brasil", @"Brunei", @"Bulgaria", @"Burkina Faso", @"Burma", @"Burundi", @"Cambodia", @"Cameroon", @"Cape Verde", @"Cayman Islands", @"Central African Republic", @"Chad", @"Chile", @"China", @"Colombia", @"Comoros", @"Congo, Democratic Republic of the", @"Congo, Republic of the", @"Costa Rica", @"Cote d'Ivoire", @"Croatia", @"Cuba", @"Cyprus", @"Dhekelia", @"Dijibouti", @"Dominica", @"Dominican Republic", @"Ecuador", @"Egypt", @"El Salvador", @"Equatorial Guinea", @"Eritrea", @"Ethiopia", @"Fiji", @"French Guiana", @"French Polynesia", @"Gabon", @"The Gambia", @"Ghana", @"Georgia", @"Ghana", @"Guam", @"Guatemala", @"Guinea", @"Guinea Bissau", @"Guyana", @"Haiti", @"Honduras", @"India", @"Indonesia", @"Iran", @"Iraq", @"Jamaica", @"Jordan", @"Kazakhstan", @"Kenya", @"Kiribati", @"Kuwait", @"Kyrgyzstan", @"Laos", @"Lesotho", @"Liberia", @"Libya", @"Lithuania", @"Macau", @"Macedonia", @"Madagascar", @"Malawi", @"Malaysia", @"Mali", @"Marshall Islands", @"Martinique", @"Mauritania", @"Mauritius", @"Mayotte", @"Mexico", @"Micronesia", @"Mongolia", @"Moldova", @"Morocco", @"Mozambique", @"Namibia", @"Nepal", @"New Zealand", @"Nicaragua", @"Niger", @"Nigeria", @"Oman", @"Pakistan", @"Palau", @"Panama", @"Papua New Guinea", @"Paraguay", @"Peru", @"Philippines", @"Poland", @"Qatar", @"Romania", @"Russia", @"Rwanda", @"Saint Lucia", @"Samoa", @"Saudi Arabia", @"Senegal", @"Serbia and Montenegro", @"Sierra Leone", @"Singapore", @"Slovakia", @"Slovenia", @"Solomon Islands", @"Somalia", @"South Africa",  @"Sri Lanka",  @"Sudan",  @"Suriname",  @"Swaziland",  @"Syria",  @"Tajikistan",  @"Tanzania",  @"Thailand",  @"Timor-Leste",  @"Togo",  @"Tokelau",  @"Tonga",  @"Trinidad and Tobago",  @"Tunisia",  @"Turkey",  @"Turkmenistan",  @"Turks and Caicos Islands",  @"Tuvalu",  @"Uganda",  @"Ukraine",  @"United Arab Emirates",  @"United Kingdom",  @"United States", @"Uruguay",  @"Uzbekistan",  @"Vanuatu", @"Venezuala", @"Vietnam", @"Virgin Islands", @"Western Sahara", @"Yemen", @"Zambia", @"Zimbabwe", nil];
  
    
}

- (IBAction)saveChanges:(id)sender{
    NSLog(@"Saving changes to cover sheet");
    
    CoverSheet *curCoverSheet =[[CoverSheet alloc] init];
    
    curCoverSheet.partnerId = [[sharedUser sharedPartner] partnerId];
    
    curCoverSheet.q1 = selectedCountry;
    curCoverSheet.q2 = self.q2.text;
    curCoverSheet.q3 = self.q3.text;
    curCoverSheet.q4 = self.q4.text;
    curCoverSheet.q5 = self.q5.text;
    curCoverSheet.q6 = self.q6.text;
    
    DataAccess *db = [[DataAccess alloc] init];
    
    if (!hasCoverSheet){
        [db insertCoverSheet:curCoverSheet];
    }else{
        curCoverSheet.coverSheetId = savedCoverSheet.coverSheetId;
        [db updateCoverSheet:curCoverSheet];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**Keyboard dismissed when background is clicked or when return is hit**/

/**Does not work
    Maybe need a gesture recognizer for this functionality**/
- (IBAction)backgroundTouched:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)textfieldReturn:(id)sender{
    [sender resignFirstResponder];
}

/**TableView methods**/
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
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"LocationCell"];
	}
	//get the relevant location from the array
	NSString *region =  [self.regionArray objectAtIndex:indexPath.row];
	
	cell.textLabel.text = region;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.detailTextLabel.text = selectedCountry;
	
	return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectedCountry = [locations objectAtIndex:row];
}

- (void)pickerDoneClicked
{
    [locationTableView reloadData];
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
