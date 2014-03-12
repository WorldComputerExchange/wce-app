//
//  WCEWebViewController.m
//  WCE
//
//

#import "WCEWebViewController.h"

@interface WCEWebViewController ()

@end

@implementation WCEWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    webView.delegate = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.worldcomputerexchange.org/"]];
    [webView loadRequest:request];
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(145, 190, 20,20)];
    [self.spinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.spinner setHidesWhenStopped:YES];
    
    [webView addSubview:self.spinner];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.spinner startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.spinner stopAnimating];
}

@end
