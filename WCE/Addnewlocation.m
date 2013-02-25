//
//  Addnewlocation.m
//  WCE
//
//  Created by Sushruth Chandrasekar on 2/25/13.
//  Copyright (c) 2013  Brian Beckerle. All rights reserved.
//

#import "Addnewlocation.h"

@interface UIScrollView ()

@end

@implementation UseScrollViewViewController

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
	return imageView;
}


@end


- (void)viewDidLoad {
	[super viewDidLoad];
	UIImageView *tempImageView =
    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Beer-Sign-On-Wall.jpg"]];
	self.imageView = tempImageView;
	[tempImageView release];
}

- (void)viewDidLoad {
    
    ...
    
	scrollView.contentSize =
    CGSizeMake(imageView.frame.size.width, imageView.frame.size.height);
	scrollView.maximumZoomScale = 4.0;
	scrollView.minimumZoomScale = 0.75;
	scrollView.clipsToBounds = YES;
	scrollView.delegate = self;
	[scrollView addSubview:imageView];
}

