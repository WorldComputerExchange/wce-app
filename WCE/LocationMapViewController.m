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


static NSArray *_previouslyGeocodedLocations;


@implementation LocationMapViewController
@synthesize mapView;

- (void)viewWillAppear:(BOOL)animated
{
	[[self navigationItem] setTitle:@"Map"];
	
	for(Location *loc in _previouslyGeocodedLocations)
		[mapView removeAnnotation:[loc annotation]];
}

- (void)viewDidAppear:(BOOL)animated
{
	[self geocodeNewLocations];
}

- (id)init
{
    self = [super init];
    if (self)
	{
        NSLog(@"init");
		_previouslyGeocodedLocations = [[NSArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];   
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
		[self addAnnotationWithArray:locs atIndex:0]; // start the looping process
	}	
}

- (void)addAnnotationWithArray:(NSMutableArray *)array atIndex:(int)index
{
	//NSLog(@"geocoding location with address: %@", [(Location *)[array objectAtIndex:index] address]);
	
	Location *thisLocation = (Location *)[array objectAtIndex:index];
	
	NSMutableString *geocodingString = [NSMutableString stringWithString:[thisLocation address]];
	[geocodingString appendString:@", "];
	[geocodingString appendString:[thisLocation city]];
	
	if(![[thisLocation zip] isEqualToString:@"NA"])
	{
		[geocodingString appendString:@", "];
		[geocodingString appendString:[thisLocation zip]];
	}
	
	if(![[thisLocation country] isEqualToString:@"NA"])
	{
		[geocodingString appendString:@", "];
		[geocodingString appendString:[thisLocation country]];
	}
	/*else
	{
		//// exit procedure
		if(index < [array count] - 1)
			[self addAnnotationWithArray:array atIndex:(index + 1)];
		else
			_previouslyGeocodedLocations = [array copy]; /// keep a record of which ones we've already geocoded
	}*/
	
	NSLog(@"index of thing: %i", [_previouslyGeocodedLocations indexOfObject:thisLocation]);
	if([_previouslyGeocodedLocations indexOfObject:thisLocation] == NSNotFound || [_previouslyGeocodedLocations count] == 0)
	{
		NSLog(@"using geocoder");
		[[self geocoder] geocodeAddressString:geocodingString completionHandler:^(NSArray *placemarks, NSError *error) {
			if([placemarks count] > 0)
			{
				CLPlacemark *placemark = [placemarks objectAtIndex:0];
				CLLocationCoordinate2D coord = [[placemark location] coordinate];
				
				//NSLog(@"found location for %@ with latitude %f and longitude %f", [thisLocation name], coord.latitude, coord.longitude);
				
				AddressAnnotation *annot;
				if([[thisLocation name] length] > 1)
					annot = [[AddressAnnotation alloc] initWithCoordinate:coord withSubtitle:[thisLocation country] withTitle:[thisLocation name]];
				else
					annot = [[AddressAnnotation alloc] initWithCoordinate:coord withSubtitle:[thisLocation country] withTitle:@"Untitled"];
				
				[mapView addAnnotation:annot];
				[[[[User sharedUser] savedLocations] objectAtIndex:index] setAnnotation:annot]; // save the annotation to be used later
				
				//// exit procedure
				if(index < [array count] - 1)
					[self addAnnotationWithArray:array atIndex:(index + 1)];
				else
					_previouslyGeocodedLocations = [array copy]; /// keep a record of which ones we've already geocoded
			}
			else
			{
				NSLog(@"**** couldn't find location for %@ ****", [thisLocation name]);
			}
		}];
	}
	else
	{
		[mapView addAnnotation:[thisLocation annotation]];
		
		//// exit procedure
		if(index < [array count] - 1)
			[self addAnnotationWithArray:array atIndex:(index + 1)];
		else
			_previouslyGeocodedLocations = [array copy]; /// keep a record of which ones we've already geocoded
	}
}

@end
