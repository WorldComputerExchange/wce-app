//
//  CustomNavigationBar.m
//  WCE
//
//  Created by  Brian Beckerle on 9/12/13.
//

#import "CustomNavigationBar.h"

@implementation CustomNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self customize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self customize];
    }
    return self;
}

-(void)customize{
    UIImage *navBarBg = [UIImage imageNamed:@"navBar-bg.png"];
    [self setBackgroundImage:navBarBg forBarMetrics:UIBarMetricsDefault];
}

@end
