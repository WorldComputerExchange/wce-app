//
//  OrderFormViewController.h
//  WCE
//
//  Created by Alex on 4/20/13.
//  Copyright (c) 2013  Brian Beckerle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
//#import "User.h"

//@interface OrderFormViewController : UIViewController



@interface OrderFormViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>
{
    IBOutlet UITableView *ChooseCountry;
    NSArray *regionArray;
    UIActionSheet *actionSheet;
    NSArray *locations;
    
    UIPickerView *pickerView;
}

@property (nonatomic, retain) NSArray *regionArray;
@property (nonatomic,retain) UITableView* locationTableView;
@property (nonatomic, copy) NSArray *locations;
@property (nonatomic, copy) UIActionSheet *actionSheet;



@end
