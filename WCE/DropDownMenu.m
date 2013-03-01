//
//  DropDownMenu.m
//  WCE
//
//  Created by Sushruth Chandrasekar on 3/1/13.
//  Copyright (c) 2013  Brian Beckerle. All rights reserved.
//

#import "DropDownMenu.h"

@implementation DropDownMenu

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Fruits", @"Fruits");
        
        
        dataArray = [[NSMutableArray alloc] initWithObjects:
                     @"Country",
                     @"City",
                
                     nil];
    }
    return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
 
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    return cell;
}



@end
