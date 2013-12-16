//
//  WCEContentViewController.h
//  WCE
//
//  Created by Peter on 4/30/13.
//

#import <UIKit/UIKit.h>

@interface WCEContentViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
