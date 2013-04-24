//
//  AddressAnnotation.h
//  WCE
//
//  Created by Sushruth Chandrasekar on 2/26/13.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
 
@interface AddressAnnotation : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    NSString *subtitle;
    NSString *title;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)c withSubtitle:(NSString *)_subtitle withTitle:(NSString *)_title;

@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *title;

@end
