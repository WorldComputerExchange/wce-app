//
//  LocationViewController.h
//  WCE
//
//  Created by  Brian Beckerle on 2/13/13.
//  Copyright (c) 2013  Brian Beckerle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    IBOutlet UIPickerView *locationPicker;
    NSMutableArray *locationArray;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end
