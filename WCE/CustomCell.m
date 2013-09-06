//
//  CustomCell.m
//  WCE
//
//  Created by  Brian Beckerle on 9/2/13.
//

#import "CustomCell.h"

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

/*-(void)setupBackground{
    UIImage *bg = [UIImage imageNamed:@"cell-bg.png"];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:bg];
    self.backgroundView = backgroundView;
    
   // UIImage *highlight = [[UIImage imageNamed:"cell-bg-highlighted.png"]];
    //UIImageView *highlightImageView = [[UIImageView alloc] initWithImage:highlight];
    //self.selectedBackgroundView = highlightImageView;
}*/

-(void)addMainLabel{
    self.mainTextLabel = [[UILabel alloc] init];
    self.mainTextLabel.font = [UIFont boldSystemFontOfSize:16];
    self.mainTextLabel.textColor = [UIColor whiteColor];
    self.mainTextLabel.shadowColor = [UIColor colorWithWhite:0.30 alpha:1.0];
    self.mainTextLabel.backgroundColor = [UIColor clearColor];
    //self.mainTextLabel.highlightedTextColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.mainTextLabel];
}

/*- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    CGSize shadowOffset = highlighted ? CGSizeZero : CGSizeMake(0, 1);
    self.mainTextLabel.shadowOffset = shadowOffset;
    self.subTextLabel.shadowOffset = shadowOffset;
}*/

- (void)layoutSubviews {
    [super layoutSubviews];
    
    const CGFloat HorizontalMargin = 10;
    const CGFloat VerticalMargin = 4;
    
    CGFloat x = HorizontalMargin;
    CGFloat y = VerticalMargin;
    CGSize textSize = [self.mainTextLabel.text sizeWithFont:self.mainTextLabel.font];
    CGFloat width = textSize.width;
    CGFloat height = self.contentView.frame.size.height - (2 * VerticalMargin);
    self.mainTextLabel.frame = CGRectMake(x, y, width, height);
    
   /* x += width + HorizontalMargin;
    textSize = [self.subTextLabel.text sizeWithFont:self.subTextLabel.font];
    width = textSize.width;
    self.subTextLabel.frame = CGRectMake(x, y, width, height);*/
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}



@end
