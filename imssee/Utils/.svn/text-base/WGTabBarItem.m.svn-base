//
//  WGTabBarItem.m
//  imssee
//
//  Created by imsseeios3 on 15/2/6.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "WGTabBarItem.h"

@implementation WGTabBarItem

- (void)setBadgeValue:(NSString *)badgeValue
{
    if (_badgeValue != badgeValue) {
        _badgeValue = badgeValue;
        [_badgeImage setBadgeValue:_badgeValue];
    }
}

- (void)setHint:(BOOL)hint
{
    _hint = hint;
    _badgeImage.hidden = !_hint;
}

- (void)showSHBadgeImage:(BadgeStyle)badgeStyle
{
    SHBadgeImage *badgeImage = [[SHBadgeImage alloc] initWithSuperView:self badgeStyle:badgeStyle];
    badgeImage.hidden = YES;
    self.badgeImage = badgeImage;
    [self addSubview:self.badgeImage];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
