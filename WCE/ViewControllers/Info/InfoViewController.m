//
//  InfoViewController.m
//  WCE
//
//  Created by  Brian Beckerle on 9/11/13.
//

#import "InfoViewController.h"
#import "CustomCell.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:
                                 [UIImage imageNamed:@"Default.png"]];
    
    [self.infoTableView registerClass:[CustomCell class]
              forCellReuseIdentifier:@"customCell"];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return 4;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        [self performSegueWithIdentifier:@"pushAboutWCE" sender:self];
    }else if(indexPath.row == 1){
        [self performSegueWithIdentifier:@"pushHistory" sender:self];
    }else if(indexPath.row == 2){
        [self performSegueWithIdentifier:@"pushContent" sender:self];
    }else{
        [self performSegueWithIdentifier:@"pushCosts" sender:self];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"customCell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	//get the relevant location from the array
    NSString *name;
    if (indexPath.row == 0){
        name = @"About WCE";
    }else if (indexPath.row == 1){
        name = @"History";
	}else if (indexPath.row == 2){
        name = @"Content";
    }else {
        name = @"Costs";
    }
    
    cell.mainTextLabel.text = name;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
	return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
