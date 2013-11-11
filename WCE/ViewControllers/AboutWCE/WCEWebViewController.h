//
//  WCEWebViewController.h
//  WCE
//
//

#import <UIKit/UIKit.h>

@interface WCEWebViewController : UIViewController <UIWebViewDelegate>
{
    IBOutlet UIWebView *webView;
}

@property (nonatomic, retain) UIActivityIndicatorView *spinner;

@end
