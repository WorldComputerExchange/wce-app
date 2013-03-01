//
//  AddLocationViewController.m
//  WCE
//
//

#import "AddLocationViewController.h"

@interface AddLocationViewController ()

@end

@implementation AddLocationViewController

@synthesize locations, actionSheet, dropDownTableView, dataArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated{
    //make navigation bar hidden bc it is put in in storyboard
    NSLog(@"IS this being called?");
    [self.navigationController setNavigationBarHidden:YES];
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                              delegate:nil
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    locations = [[NSArray alloc] initWithObjects:@"Libya", @"Boston", @"Chicago", @"Cairo", @"The Vatican", nil];
    
    
    //dropDownTableView.title = NSLocalizedString(@"Fruits", @"Fruits");
    dataArray = [[NSMutableArray alloc] init];
    [dataArray addObject:@"City"];
    [dataArray addObject:@"Country"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
