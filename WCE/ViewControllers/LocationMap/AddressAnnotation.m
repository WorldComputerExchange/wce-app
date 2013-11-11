//
//  AddressAnnotation.m
//  WCE
//
//  Created by Sushruth Chandrasekar on 2/26/13.
//

#import "AddressAnnotation.h"

@implementation AddressAnnotation
@synthesize coordinate, subtitle, title;

- (NSString *)subtitle
{
    return subtitle;
}

- (NSString *)title
{
    return title;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)c withSubtitle:(NSString *)_subtitle withTitle:(NSString *)_title
{
    coordinate = c;
    subtitle = _subtitle;
    title = _title;
    
    return self;
}
 
@end
