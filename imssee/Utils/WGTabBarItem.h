//
//  WGTabBarItem.h
//  imssee
//
//  Created by imsseeios3 on 15/2/6.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHBadgeImage.h"

@interface WGTabBarItem : UIButton

@property (nonatomic, strong) SHBadgeImage *badgeImage;
@property (nonatomic, copy) NSString *badgeValue;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, getter=isHint) BOOL hint;         //标志是否有新消息提示

- (void)showSHBadgeImage:(BadgeStyle)badgeStyle;

@end
