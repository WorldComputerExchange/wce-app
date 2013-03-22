//
//  CoverSheetViewController.h
//  WCE
//
//  Created by Sushruth Chandrasekar on 3/21/13.
//  Copyright (c) 2013  Brian Beckerle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface CoverSheetViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>
{
    IBOutlet UITableView *ChooseCountry;
    NSMutableArray *regionArray;
    UIActionSheet *actionSheet;
    NSMutableArray *locations;
    
    UIPickerView *pickerView;
	UIButton *chooseFromMap;
	UIView *footerView;
    Location *sharedLocation;
}

@property (nonatomic, retain) NSMutableArray *regionArray;
@property (nonatomic,retain) UITableView* locationTableView;
@property (nonatomic, copy) NSArray *locations;
@property (nonatomic, copy) UIActionSheet *actionSheet;
@property (nonatomic, retain) UIButton *chooseFromMap;
@property (nonatomic, retain) UIView *footerView;
@property (nonatomic, retain) Location *sharedLocation;

@end
