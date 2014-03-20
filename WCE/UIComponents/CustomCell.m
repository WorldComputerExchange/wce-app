//
//  CustomCell.m
//  WCE
//
//  Created by  Brian Beckerle on 9/2/13.
//

#import "CustomCell.h"
#import "BLMacros.h"

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addMainLabel];
        //[self setupBackground];
        
    }
    return self;
}

-(void)addMainLabel{
    self.mainTextLabel = [[UILabel alloc] init];
    self.mainTextLabel.font = [UIFont boldSystemFontOfSize:16];
    self.mainTextLabel.textColor = [UIColor whiteColor];
    self.mainTextLabel.shadowColor = [UIColor colorWithWhite:0.30 alpha:1.0];
    self.mainTextLabel.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.mainTextLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    const CGFloat HorizontalMargin = 10;
    const CGFloat VerticalMargin = 4;
    
    CGFloat x = HorizontalMargin;
    CGFloat y = VerticalMargin;
    CGSize textSize = [self.mainTextLabel.text sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:17]}];
    CGFloat width = textSize.width;
    CGFloat height = self.contentView.frame.size.height - (2 * VerticalMargin);
    self.mainTextLabel.frame = CGRectMake(x, y, width, height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}



@end
