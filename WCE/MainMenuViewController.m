//
//  MainMenuViewController.m
//  WCE
//
//
/**Info, Forms, Phrases, Misc Menu**/

#import "MainMenuViewController.h"
#import "CustomCell.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

@synthesize sharedLocation;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    sharedLocation = [Location sharedLocation];
    
    [mainMenuTableView registerClass:[CustomCell class]
              forCellReuseIdentifier:@"customCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

/**Set up the table**/
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"customCell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    NSString *name; 
    if (indexPath.row == 0){
        name = @"Info";
    }else if (indexPath.row == 1){
        name = @"Forms";
    }else if (indexPath.row == 2){
        name = @"Phrases";
    }else {
        name = @"Misc";
    }
    
    cell.mainTextLabel.text = name;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
	return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    // cell background image view
    UIImageView *background;
    UIImageView *selectedBackground;
    // first cell check
    if (indexPath.row == 0) {
        background = [[UIImageView alloc] initWithImage:
                      [UIImage imageNamed:@"top-cell-bg.png"]];
        selectedBackground = [[UIImageView alloc] initWithImage:
                              [UIImage imageNamed:@"top-cell-bg-selected.png"]];
        // last cell check
    } else if (indexPath.row ==
               [tableView numberOfRowsInSection:indexPath.section] - 1) {
        background = [[UIImageView alloc] initWithImage:
                      [UIImage imageNamed:@"bottom-cell-bg.png"]];
        selectedBackground = [[UIImageView alloc] initWithImage:
                              [UIImage imageNamed:@"bottom-cell-bg-selected.png"]];
        // middle cells*/
    } else {
        background = [[UIImageView alloc] initWithImage:
                      [UIImage imageNamed:@"middle-cell-bg.png"]];
        selectedBackground = [[UIImageView alloc] initWithImage:
                              [UIImage imageNamed:@"middle-cell-bg-selected.png"]];
    }
    background.alpha = 0.70; //make background semitransparent
    // set background view
    
    [cell setSelectedBackgroundView:selectedBackground];  
    [cell setBackgroundView:background];   
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        [self performSegueWithIdentifier:@"pushInfo" sender:self];
    }else if(indexPath.row == 1){
        [self performSegueWithIdentifier:@"pushForms" sender:self];
    }else if(indexPath.row == 2){
        NSLog(@"Current Language is : %@", sharedLocation.language);
        if ([sharedLocation.language isEqualToString:@"Arabic"]){
            [self performSegueWithIdentifier:@"pushArabic" sender:self];
        }else if ([sharedLocation.language isEqualToString:@"French"]){
            [self performSegueWithIdentifier:@"pushFrench" sender:self];
        }else if ([sharedLocation.language isEqualToString:@"Spanish"]){
            [self performSegueWithIdentifier:@"pushSpanish" sender:self];
        }else{
            [self performSegueWithIdentifier:@"pushSpanish" sender:self];
        }
    }else{
        [self performSegueWithIdentifier:@"pushMisc" sender:self];
    }
}

@end
