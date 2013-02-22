//
//  LocationViewController.m
//  WCE
//
//

#import "LocationViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [locationArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [locationArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"Selected Location: %@. Index of selected location: %i", [locationArray objectAtIndex:row], row);
}

@end
