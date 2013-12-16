//
//  CoverSheetViewController.m
//  WCE
//
//  Created by Sushruth Chandrasekar on 3/21/13.
//  Updated by Alex on 4/20/13.
//  Updated by Alex on 9/24/13.

#import "CoverSheetViewController.h"
#import "CoverSheet.h"
#import "DataAccess.h" 
#import "User.h"

@interface CoverSheetViewController ()

@end

@implementation CoverSheetViewController

//@synthesize regionArray, locations, actionSheet, selectedCountry, sharedUser, hasCoverSheet, savedCoverSheet;

//FROM TUTORIAL Cocoa W/Love; need the following instance variables/constants
CGFloat animatedDistance;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

- (IBAction)backgroundTouched:(id)sender {
    [self.q1 resignFirstResponder];
    [self.q2 resignFirstResponder];
    [self.q3 resignFirstResponder];
    [self.q4 resignFirstResponder];
    [self.q5 resignFirstResponder];
    [self.q6 resignFirstResponder];
    [self.q7 resignFirstResponder];
    [self.q8 resignFirstResponder];
    [self.q9 resignFirstResponder];
    [self.q10 resignFirstResponder];
    [self.q11 resignFirstResponder];
    [self.q12_1 resignFirstResponder];
    [self.q12_2 resignFirstResponder];
    [self.q13_1 resignFirstResponder];
    [self.q13_2 resignFirstResponder];
    [self.q14 resignFirstResponder];
    [self.q15 resignFirstResponder];
    [self.q16_1 resignFirstResponder];
    [self.q16_2 resignFirstResponder];
    [self.q17 resignFirstResponder];
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
    
    //get the coversheet for the current partner from the database if it exists
    self.sharedUser = [User sharedUser];
    
    Partner *curPartner = [self.sharedUser sharedPartner];
    
    DataAccess *db = [[DataAccess alloc] init];
    
    self.savedCoverSheet = [[CoverSheet alloc] init];
    self.savedCoverSheet = [db getCoverSheetForPartner:curPartner];
    
    if (self.savedCoverSheet.coverSheetId < 0) { //no cover sheet found
        self.hasCoverSheet = false;
        self.selectedCountry = @"None";
    }else {
        self.hasCoverSheet = true;
        self.q1.text = self.savedCoverSheet.q1;
        self.q2.text = self.savedCoverSheet.q2;
        self.q3.text = self.savedCoverSheet.q3;
        self.q4.text = self.savedCoverSheet.q4;
        self.q5.text = self.savedCoverSheet.q5;
        self.q6.text = self.savedCoverSheet.q6;
        self.q7.text = self.savedCoverSheet.q7;
        self.q8.text = self.savedCoverSheet.q8;
        self.q9.text = self.savedCoverSheet.q9;
        self.q10.text = self.savedCoverSheet.q10;
        self.q11.selectedSegmentIndex = [self segmentIndexForString:self.savedCoverSheet.q11];
        self.q12_1.text = self.savedCoverSheet.q12_1;
        self.q12_2.text = self.savedCoverSheet.q12_2;
        self.q13_1.text = self.savedCoverSheet.q13_1;
        self.q13_2.text = self.savedCoverSheet.q13_2;
        self.q14.text = self.savedCoverSheet.q14;
        self.q15.text = self.savedCoverSheet.q15;
        self.q16_1.text = self.savedCoverSheet.q16_1;
        self.q16_2.text = self.savedCoverSheet.q16_2;
        self.q17.selectedSegmentIndex = [self segmentIndexForString:self.savedCoverSheet.q17];
    }
    
    self.regionArray = [[NSArray alloc] initWithObjects:@"Country", nil];
    
    
    self.locations = [[NSArray alloc] initWithObjects:
                 @"Afghanistan", @"Albania", @"Algeria", @"Andorra", @"Angola", @"Antigua and Barbuda", @"Argentina", @"Armenia", @"Aruba", @"Azerbaijan", @"Bahamas", @"Bahrain", @"Bangladesh", @"Barbados", @"Bassas da India", @"Belarus", @"Belize", @"Benin", @"Bermuda", @"Bhutan", @"Bolivia", @"Bosnia and Herzegovina", @"Botswana", @"Brasil", @"Brunei", @"Bulgaria", @"Burkina Faso", @"Burma", @"Burundi", @"Cambodia", @"Cameroon", @"Cape Verde", @"Cayman Islands", @"Central African Republic", @"Chad", @"Chile", @"China", @"Colombia", @"Comoros", @"Congo, Democratic Republic of the", @"Congo, Republic of the", @"Costa Rica", @"Cote d'Ivoire", @"Croatia", @"Cuba", @"Cyprus", @"Dhekelia", @"Dijibouti", @"Dominica", @"Dominican Republic", @"Ecuador", @"Egypt", @"El Salvador", @"Equatorial Guinea", @"Eritrea", @"Ethiopia", @"Fiji", @"French Guiana", @"French Polynesia", @"Gabon", @"The Gambia", @"Ghana", @"Georgia", @"Ghana", @"Guam", @"Guatemala", @"Guinea", @"Guinea Bissau", @"Guyana", @"Haiti", @"Honduras", @"India", @"Indonesia", @"Iran", @"Iraq", @"Jamaica", @"Jordan", @"Kazakhstan", @"Kenya", @"Kiribati", @"Kuwait", @"Kyrgyzstan", @"Laos", @"Lesotho", @"Liberia", @"Libya", @"Lithuania", @"Macau", @"Macedonia", @"Madagascar", @"Malawi", @"Malaysia", @"Mali", @"Marshall Islands", @"Martinique", @"Mauritania", @"Mauritius", @"Mayotte", @"Mexico", @"Micronesia", @"Mongolia", @"Moldova", @"Morocco", @"Mozambique", @"Namibia", @"Nepal", @"New Zealand", @"Nicaragua", @"Niger", @"Nigeria", @"Oman", @"Pakistan", @"Palau", @"Panama", @"Papua New Guinea", @"Paraguay", @"Peru", @"Philippines", @"Poland", @"Qatar", @"Romania", @"Russia", @"Rwanda", @"Saint Lucia", @"Samoa", @"Saudi Arabia", @"Senegal", @"Serbia and Montenegro", @"Sierra Leone", @"Singapore", @"Slovakia", @"Slovenia", @"Solomon Islands", @"Somalia", @"South Africa",  @"Sri Lanka",  @"Sudan",  @"Suriname",  @"Swaziland",  @"Syria",  @"Tajikistan",  @"Tanzania",  @"Thailand",  @"Timor-Leste",  @"Togo",  @"Tokelau",  @"Tonga",  @"Trinidad and Tobago",  @"Tunisia",  @"Turkey",  @"Turkmenistan",  @"Turks and Caicos Islands",  @"Tuvalu",  @"Uganda",  @"Ukraine",  @"United Arab Emirates",  @"United Kingdom",  @"United States", @"Uruguay",  @"Uzbekistan",  @"Vanuatu", @"Venezuala", @"Vietnam", @"Virgin Islands", @"Western Sahara", @"Yemen", @"Zambia", @"Zimbabwe", nil];
  
    
}

- (IBAction)saveChanges:(id)sender{
    NSLog(@"Saving changes to cover sheet");
    
    CoverSheet *curCoverSheet =[[CoverSheet alloc] init];
    
    curCoverSheet.partnerId = [[self.sharedUser sharedPartner] partnerId];
    
    curCoverSheet.q1 = self.q1.text;
    curCoverSheet.q2 = self.q2.text;
    curCoverSheet.q3 = self.q3.text;
    curCoverSheet.q4 = self.q4.text;
    curCoverSheet.q5 = self.q5.text;
    curCoverSheet.q6 = self.q6.text;
    curCoverSheet.q7 = self.q7.text;
    curCoverSheet.q8 = self.q8.text;
    curCoverSheet.q9 = self.q9.text;
    curCoverSheet.q10 = self.q10.text;
    curCoverSheet.q11 = [self stringForSegmentIndex:self.q11.selectedSegmentIndex];
    curCoverSheet.q12_1 = self.q12_1.text;
    curCoverSheet.q12_2 = self.q12_2.text;
    curCoverSheet.q13_1 = self.q13_1.text;
    curCoverSheet.q13_2 = self.q13_2.text;
    curCoverSheet.q14 = self.q14.text;
    curCoverSheet.q15 = self.q15.text;
    curCoverSheet.q16_1 = self.q16_1.text;
    curCoverSheet.q16_2 = self.q16_2.text;
    curCoverSheet.q17 = [self stringForSegmentIndex:self.q17.selectedSegmentIndex];
    
    DataAccess *db = [[DataAccess alloc] init];
    
    if (!self.hasCoverSheet){
        [db insertCoverSheet:curCoverSheet];
    }else{
        curCoverSheet.coverSheetId = self.savedCoverSheet.coverSheetId;
        [db updateCoverSheet:curCoverSheet];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

//return the correct segment (YES or NO) for the given string
-(NSInteger)segmentIndexForString:(NSString *)string{
    if([[string lowercaseString] characterAtIndex:0] == 'y'){
        return 0;
    }else{
        return 1;
    }
}

//return YES or NO depending on segment index
-(NSString *)stringForSegmentIndex:(NSInteger)segIndex{
    if(segIndex == 0){
        return @"YES";
    }else{
        return @"NO";
    }
}

//dismisses the keyboard when the return/done button is pressed for TextFields.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//dismisses the keyboard when the return/done button is pressed for TextViews.
- (BOOL)textViewShouldReturn:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}

/**Keyboard dismissed when background is clicked or when return is hit**/
/**Does not work
    Maybe need a gesture recognizer for this functionality**/
/**TableView methods**/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return [self.regionArray count];
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
    cell.detailTextLabel.text = self.selectedCountry;
	
	return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:nil
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    
    [self.actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    self.pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Done"]];
    closeButton.momentary = YES;
    closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
    closeButton.tintColor = [UIColor colorWithRed:34.0/255.0 green:97.0/255.0 blue:221.0/255.0 alpha:1];
    [closeButton addTarget:self action:@selector(pickerDoneClicked) forControlEvents:UIControlEventValueChanged];
    
    [self.actionSheet addSubview:self.pickerView];
    [self.actionSheet addSubview:closeButton];
    [self.actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    [self.actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
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
    return [self.locations count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.locations objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedCountry = [self.locations objectAtIndex:row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**Keyboard dismissed when background is clicked or when return is hit**/
- (IBAction)textfieldReturn:(id)sender{
    [sender resignFirstResponder];
}
- (IBAction)textviewReturn:(id)sender{
    [sender resignFirstResponder];
}











//DISMISSING KEYBOARD


//FROM TUTORIAL: www.cocoawithlove.com/2008/10/sliding-uitextfields-around-to-avoid.html

//Animate upwards when the text field is selected
//Get the rects of the text field being edited and the view that we're going to scroll. We convert everything to window coordinates, since they're not necessarily in the same coordinate space.
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFieldRect =
    [self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    //So now we have the bounds, we need to calculate the fraction between the top and bottom of the middle section for the text field's midline:
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    
    //Clamp this fraction so that the top section is all "0.0" and the bottom section is all "1.0".
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    
    //Now take this fraction and convert it into an amount to scroll by multiplying by the keyboard height for the current screen orientation. Notice the calls to floor so that we only scroll by whole pixel amounts.
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    
    //Finally, apply the animation. Note the use of setAnimationBeginsFromCurrentState: — this will allow a smooth transition to new text field if the user taps on another.
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}


//ANIMATE BACK AGAIN:  The return animation is far simpler since we've saved the amount to animate.
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}




//SAME CODE AS ABOVE, BUT FOR TEXTVIEW
//FROM TUTORIAL: www.cocoawithlove.com/2008/10/sliding-uitextfields-around-to-avoid.html

//Animate upwards when the text field is selected
//Get the rects of the text field being edited and the view that we're going to scroll. We convert everything to window coordinates, since they're not necessarily in the same coordinate space.
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    CGRect textFieldRect =
    [self.view.window convertRect:textView.bounds fromView:textView];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    
    //So now we have the bounds, we need to calculate the fraction between the top and bottom of the middle section for the text field's midline:
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    
    //Clamp this fraction so that the top section is all "0.0" and the bottom section is all "1.0".
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }

    //Now take this fraction and convert it into an amount to scroll by multiplying by the keyboard height for the current screen orientation. Notice the calls to floor so that we only scroll by whole pixel amounts.
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    
    //Finally, apply the animation. Note the use of setAnimationBeginsFromCurrentState: — this will allow a smooth transition to new text field if the user taps on another.
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

//ANIMATE BACK AGAIN:  The return animation is far simpler since we've saved the amount to animate.






@end
