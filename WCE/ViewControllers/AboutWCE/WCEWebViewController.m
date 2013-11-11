//
//  WCEWebViewController.m
//  WCE
//
//

#import "WCEWebViewController.h"

@interface WCEWebViewController ()

@end

@implementation WCEWebViewController

@synthesize spinner;

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    webView.delegate = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.worldcomputerexchange.org/"]];
    [webView loadRequest:request];
    
    spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(145, 190, 20,20)];
    [spinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [spinner setHidesWhenStopped:YES];
    
    [webView addSubview:spinner];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [spinner startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [spinner stopAnimating];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
