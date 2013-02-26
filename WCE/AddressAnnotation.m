//
//  AddressAnnotation.m
//  WCE
//
//  Created by Sushruth Chandrasekar on 2/26/13.
//  Copyright (c) 2013  Brian Beckerle. All rights reserved.
//

#import "AddressAnnotation.h"

@implementation AddressAnnotation
@synthesize coordinate;

- (NSString *)subtitle
{
    return nil;
}

- (NSString *)title
{
    return nil;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)c
{
    coordinate = c;
    
    return self;
}

@end
