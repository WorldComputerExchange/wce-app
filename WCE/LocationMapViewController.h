//
//  LocationMapViewController.h
//  WCE
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface LocationMapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic) NSMutableArray *previouslyGeocodedLocations;
@property (strong, nonatomic) CLGeocoder *geocoder;

@end	
