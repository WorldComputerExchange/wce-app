//
//  WCEContentViewController.h
//  WCE
//
//  Created by Peter on 4/30/13.
//

/**Content Screen displaying WCE Content Graphic
    Choose Location
        >Home
            >Info
                >Content     **/

#import <UIKit/UIKit.h>

@interface WCEContentViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
