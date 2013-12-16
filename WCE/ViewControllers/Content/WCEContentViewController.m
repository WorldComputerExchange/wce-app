//
//  WCEContentViewController.m
//  WCE
//
//  Created by Peter on 4/30/13.
//

#import "WCEContentViewController.h"

@interface WCEContentViewController ()

@end

@implementation WCEContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
	[[self view] setBackgroundColor:[UIColor blackColor]];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	
	UIImage *image = [UIImage imageNamed:@"WCE Content V5.png"];
    self.imageView = [[UIImageView alloc] initWithImage:image];
	[self.imageView setFrame:(CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=image.size}];
	[self.scrollView addSubview:self.imageView];
	
	[self.scrollView setContentSize:image.size];
	NSLog(@"width: %f height: %f", [[self scrollView] frame].size.width, [[self scrollView] frame].size.height);
	
	UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
																							 action:@selector(scrollViewTwoFingerTapped:)];
	twoFingerTapRecognizer.numberOfTapsRequired = 1;
	twoFingerTapRecognizer.numberOfTouchesRequired = 2;
	
	UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
																						  action:@selector(scrollViewDoubleTapped:)];
	doubleTapRecognizer.numberOfTapsRequired = 2;
	doubleTapRecognizer.numberOfTouchesRequired = 1;
	
	[self.scrollView addGestureRecognizer:twoFingerTapRecognizer];
	[self.scrollView addGestureRecognizer:doubleTapRecognizer];
	
	[[self view] setBackgroundColor:[UIColor blackColor]];
	
	CGRect scrollViewFrame = self.scrollView.frame;
	NSLog(@"%@", [self scrollView]);
	
	CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
	CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
	CGFloat minScale = MIN(scaleWidth, scaleHeight);
	self.scrollView.minimumZoomScale = minScale;
	
	self.scrollView.maximumZoomScale = 1.0f;
	self.scrollView.zoomScale = minScale;
	
	[self centerScrollViewContents];
}

- (void)centerScrollViewContents
{
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
	
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
	
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
	
    self.imageView.frame = contentsFrame;
}

- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer
{
    CGPoint pointInView = [recognizer locationInView:self.imageView];
	
    CGFloat newZoomScale = self.scrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
	
    CGSize scrollViewSize = self.scrollView.bounds.size;
	
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
	
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);

    [self.scrollView zoomToRect:rectToZoomTo animated:YES];
}

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer
{
    // Zoom out slightly, capping at the minimum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, self.scrollView.minimumZoomScale);
    [self.scrollView setZoomScale:newZoomScale animated:YES];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
	[self centerScrollViewContents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
