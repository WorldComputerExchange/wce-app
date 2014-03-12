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

- (void)viewWillAppear:(BOOL)animated
{
	[[self navigationItem] setTitle:@"Map"];
	
	for(Location *loc in _previouslyGeocodedLocations) {
		[self.mapView removeAnnotation:[loc annotation]];
    }
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
	
	if(annotation != self.mapView.userLocation) // prevent "Current Location" pin from automatically showing up
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
}

- (void)geocodeNewLocations
{
	// Geocode the addresses
	if(![self geocoder])
		[self setGeocoder:[[CLGeocoder alloc] init]]; // initialize the geocoder
	
	NSMutableArray *locs = [[User sharedUser] savedLocations];
	
	if([locs count] > 0)
	{
		[self addAnnotationWithArray:locs atIndex:0]; // start the looping process
	}	
}

- (void)addAnnotationWithArray:(NSMutableArray *)array atIndex:(int)index
{
	Location *thisLocation = (Location *)[array objectAtIndex:index];

    //if this locations address has not been specified go to the next location
    if (![thisLocation address] || [[thisLocation address] isEqualToString:@"NA"]){
        if(index < [array count] - 1)
			[self addAnnotationWithArray:array atIndex:(index + 1)];
		else
			_previouslyGeocodedLocations = [array copy];
            return;/// keep a record of which ones we've already geocoded
    }
    
    NSMutableString *geocodingString = [NSMutableString stringWithString:[thisLocation address]];
    
    if(![[thisLocation city] isEqualToString:@"NA"] && [thisLocation city]){
        [geocodingString appendString:@", "];
        [geocodingString appendString:[thisLocation city]];
    }
	
	if(![[thisLocation zip] isEqualToString:@"NA"] && [thisLocation zip])
	{
		[geocodingString appendString:@", "];
		[geocodingString appendString:[thisLocation zip]];
	}
	
	if(![[thisLocation country] isEqualToString:@"NA"] && [thisLocation country])
	{
		[geocodingString appendString:@", "];
		[geocodingString appendString:[thisLocation country]];
	}
	
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
				
				[self.mapView addAnnotation:annot];
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
		[self.mapView addAnnotation:[thisLocation annotation]];
		
		//// exit procedure
		if(index < [array count] - 1) {
			[self addAnnotationWithArray:array atIndex:(index + 1)];
		}else{
			_previouslyGeocodedLocations = [array copy]; /// keep a record of which ones we've already geocoded
        }
	}
}

@end
