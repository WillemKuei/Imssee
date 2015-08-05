//
//  WGTabBar.h
//  imssee
//
//  Created by 鑫易 on 15/1/29.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHBadgeImage.h"
#import "WGTabBarItem.h"

@protocol WGTabBarDelegate;
@interface WGTabBar : UIView
{
    NSArray *_items;
}

@property (nonatomic) NSUInteger selectedIndex;
@property (nonatomic) NSUInteger itemsCount;
@property (nonatomic, copy) NSString *selectedTitle;
@property (nonatomic, assign) id<WGTabBarDelegate>delegate;
@property (nonatomic, copy) NSString *badgeValue;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) WGTabBarItem *selectedItem;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items;

- (void)settingTabBarImage:(NSArray *)images selectedImage:(NSArray *)selectedImages;

@end


@protocol WGTabBarDelegate <NSObject>

@optional
- (void)WGTabBar:(WGTabBar *)wgTabBar didSelectedItem:(id)selectedItem;

@end


