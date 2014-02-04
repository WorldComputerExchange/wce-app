//
//  InfoViewController.h
//  WCE
//
//  Created by  Brian Beckerle on 9/11/13.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property IBOutlet UITableView *infoTableView;

@end
