//
//  LocationMapViewController.m
//  WCE
//
//

#import "LocationMapViewController.h"
#import "AddressAnnotation.h"

@interface LocationMapViewController()

@end

@implementation LocationMapViewController
@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Created variable c to store coordinate data
    CLLocationCoordinate2D c;
    c.latitude = 45.0;
    c.longitude = -77.0;
    
    AddressAnnotation *addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:c];
    [mapView addAnnotation:addAnnotation];
}

@end
