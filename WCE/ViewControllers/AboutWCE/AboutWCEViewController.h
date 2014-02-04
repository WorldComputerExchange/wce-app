//
//  AboutWCEViewController.h
//  WCE
//
//  Created by Peter on 3/21/13.
//
/**
 This class is unnecessary, only reason for existing is to set the background image to the button with a
 stretchable image, this can be done by creating a category on UIButton so this view can be managed
 entirely in storyboard
 **/
#import <UIKit/UIKit.h>

@interface AboutWCEViewController : UITableViewController{
    IBOutlet UIButton *website;
}

@property IBOutlet UITableView *aboutWCETableView;
@end
