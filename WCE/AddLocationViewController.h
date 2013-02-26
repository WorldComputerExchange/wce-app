//
//  AddLocationViewController.h
//  WCE
//
//

#import <UIKit/UIKit.h>

@interface AddLocationViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSArray *locations;
    UIActionSheet *actionSheet;
}

@property (nonatomic, copy) NSArray *locations;
@property (nonatomic, copy) UIActionSheet *actionSheet;

@end