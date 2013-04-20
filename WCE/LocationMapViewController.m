//
//  LocationMapViewController.m
//  WCE
//
//

#import "LocationMapViewController.h"
#import "AddressAnnotation.h"
#import "Location.h"
#import "User.h"

@interface LocationMapViewController()


@end

@implementation LocationMapViewController
@synthesize mapView;

- (void)viewDidAppear:(BOOL)animated
{
}

- (id)init
{
    self = [super init];
    if (self)
	{
        NSLog(@"init");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@"sdfjksdl");
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(geocodeNewLocations)
												 name:@"shouldGeocodeNewLocation"
											   object:nil];
    
    /*//Created variable c to store coordinate data
    CLLocationCoordinate2D a;
    a.latitude = 45.0;
    a.longitude = -77.0;
    
    AddressAnnotation *addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:a withSubtitle:@"Shaw Lake" withTitle:@"Canada"];
    [mapView addAnnotation:addAnnotation];
    
    CLLocationCoordinate2D b;
    b.latitude = 29.9792;
    b.longitude = 31.1342;
    
    AddressAnnotation *addAnnotation1 = [[AddressAnnotation alloc] initWithCoordinate:b withSubtitle:@"Egypt" withTitle:@"Great Pyramid of Giza"];
    [mapView addAnnotation:addAnnotation1];
    
    CLLocationCoordinate2D c;
    c.latitude = -3.1600;
    c.longitude = -60.0300;

    AddressAnnotation *addAnnotation2 = [[AddressAnnotation alloc] initWithCoordinate:c withSubtitle:@"Brazil" withTitle:@"Amazon Rainforest"];
    [mapView addAnnotation:addAnnotation2];
    
    CLLocationCoordinate2D d;
    d.latitude =  36.1517;
    d.longitude = 139.9214;

    AddressAnnotation *addAnnotation3 = [[AddressAnnotation alloc] initWithCoordinate:d withSubtitle:@"Japan" withTitle:@"Tsukuba Circuit"];
    [mapView addAnnotation:addAnnotation3];*/
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id<MKAnnotation>)annotation
{
	MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mV dequeueReusableAnnotationViewWithIdentifier:@"pinView"];
	
	if(annotation != mapView.userLocation) // prevent "Current Location" pin from automatically showing up
	{
		if (!pinView)
		{
			pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pinView"];
			pinView.pinColor = MKPinAnnotationColorRed;
			pinView.animatesDrop = YES;
			pinView.canShowCallout = YES;
			
			UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
			pinView.rightCalloutAccessoryView = rightButton;
		}
		else
		{
			pinView.annotation = annotation;
		}
		
		return pinView;
	}
	else
		return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	[[Location sharedLocation] setCountry:[[view annotation] subtitle]];
	[[Location sharedLocation] setName:[[view annotation] title]];
	
	[self performSegueWithIdentifier:@"goToInformationFromMap" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	[[[segue destinationViewController] navigationItem] setTitle:[[Location sharedLocation] name]];
//	NSLog(@"shared location is: %@", [[Location sharedLocation] name]);
}

- (void)geocodeNewLocations
{
	// Geocode the addresses
	NSLog(@"--- geocoding start ---");
	
	if(![self geocoder])
		[self setGeocoder:[[CLGeocoder alloc] init]]; // initialize the geocoder
	
	NSMutableArray *locs = [[User sharedUser] savedLocations];
	NSLog(@"saved location array has %i objects", [locs count]);
	NSLog(@"we've already geocoded %i objects", [_previouslyGeocodedLocations count]);
	
	if([locs count] > 0)
	{
		for(Location *loc in locs)
		{
			for(Location *previousLoc in _previouslyGeocodedLocations)
			{
				if(previousLoc != loc)
				{
					NSLog(@"new location found with address: %@", [loc address]);
				}
			}
		}
	}
	
	_previouslyGeocodedLocations = [locs copy];
}

@end
