//
//  LocationViewController.h
//  WCE
//
//

#import <UIKit/UIKit.h>

@interface LocationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *locationTableView;
    NSMutableArray *locationArray;
}

@property (nonatomic, retain) NSMutableArray *locationArray;
@property (nonatomic,retain) UITableView* locationTableView;

@end
