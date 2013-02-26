//
//  AddressAnnotation.h
//  WCE
//
//  Created by Sushruth Chandrasekar on 2/26/13.
//  Copyright (c) 2013  Brian Beckerle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
 
@interface AddressAnnotation : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)c;

@end
