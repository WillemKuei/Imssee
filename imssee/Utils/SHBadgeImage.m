//
//  SHBadgeImage.m
//  imssee
//
//  Created by imsseeios3 on 15/2/5.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "SHBadgeImage.h"

@implementation SHBadgeImage

- (instancetype)initSHBadgeImage:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"point.png"];
        [self loadBadge];
    }
    return self;
}

- (instancetype)initWithSuperView:(UIView *)superView badgeStyle:(BadgeStyle)badgeStyle
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.superView = superView;
        _badgeStyle = badgeStyle;
        [self drawSHBadgeImage];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    if (_badgeValue != badgeValue) {
        _badgeValue = badgeValue;
        if ([_badgeValue integerValue] == 0) {
            self.hidden = YES;
            return;
        }
        self.hidden = NO;
        self.badgeLab.text = _badgeValue;
    }
}

- (void)drawSHBadgeImage
{
    CGRect bounds = self.superView.bounds;
    float width = _badgeStyle == NumberBadge?18:10;
    float height = width;
    float margin = (iPhone5?12:(iPhone6?22:24));
    self.frame = CGRectMake(bounds.size.width - width - margin, 2, width, height);
    self.backgroundColor = PinkColor;
    self.layer.cornerRadius = width/2;
    self.layer.masksToBounds = YES;
    if (_badgeStyle == NumberBadge) {
        [self loadBadge];
    }
    
}

- (void)loadBadge
{
    CGRect bounds = self.bounds;
    UILabel *badgeLab = [[UILabel alloc] initWithFrame:bounds];
    badgeLab.font = [UIFont systemFontOfSize:10.f];
    badgeLab.textAlignment = NSTextAlignmentCenter;
    badgeLab.textColor = [UIColor whiteColor];
    self.badgeLab = badgeLab;
    [self addSubview:self.badgeLab];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}*/

@end
