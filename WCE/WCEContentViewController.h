//
//  WCEContentViewController.h
//  WCE
//
//  Created by Peter on 4/30/13.
//  Copyright (c) 2013  Brian Beckerle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCEContentViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
