//
//  LocationMapViewController.m
//  WCE
//
//

#import "LocationMapViewController.h"

@interface ViewController: UIViewController <AGSMapViewLayerDelegate>

@end

@implementation LocationMapViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    AGSTiledMapServiceLayer *tiledLayer =
    [AGSTiledMapServiceLayer
     tiledMapServiceLayerWithURL:[NSURL URLWithString:@"http://server.arcgisonline.com/ArcGIS/rest/services/ESRI_StreetMap_World_2D/MapServer"]];
    [self.mapView addMapLayer:tiledLayer withName:@"Tiled Layer"];
    
}

- (void)mapView:(AGSMapView *) mapView failedLoadingLayerForLayerView:(UIView *) layerView baseLayer:(BOOL) baseLayer withError:(NSError *) error {
    
    //Inspect the error and then either ...
    //A. Remove the layer if it's not essential
    if(!baseLayer)
        [self.mapView removeMapLayerWithName:layerView.name];
    
    //B. Or, try resubmitting the layer, with different URL or credentials perhaps
    AGSTiledMapServiceLayer* tiledLyr = (AGSTiledMapServiceLayer*)laverView.agsLayer;
    [tiledLyr resubmitWithURL:url credential:cred];
    
}
- (void)viewDidLoad {
    ...
    
    self.mapView.layerDelegate = self;
    
}
@end
