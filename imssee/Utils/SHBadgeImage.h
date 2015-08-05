//
//  SHBadgeImage.h
//  imssee
//
//  Created by imsseeios3 on 15/2/5.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, BadgeStyle) {
    PointBadge = 0,
    NumberBadge = 1
};

@interface SHBadgeImage : UIImageView
{
    BadgeStyle _badgeStyle;
}

@property (nonatomic, strong) UILabel *badgeLab;
@property (nonatomic, copy) NSString *badgeValue;
@property (nonatomic, strong) UIView *superView;

- (instancetype)initSHBadgeImage:(CGRect)frame;

- (instancetype)initWithSuperView:(UIView *)superView badgeStyle:(BadgeStyle)badgeStyle;

@end
