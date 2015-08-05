//
//  WGTabBar.m
//  imssee
//
//  Created by 鑫易 on 15/1/29.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "WGTabBar.h"

@class WGTabBarItem;
@implementation WGTabBar

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        if (items > 0) {
            self.selectedTitle = items[0];
            [self setBackgroundColor: TabBar_BackGroundColor];
            [self loadTabBarItems:frame items:items];
        } else {
            self.selectedTitle = @"";
        }
    }
    return self;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    UIButton *selItemBtn = _items[selectedIndex];
    selItemBtn.selected = YES;
    _selectedIndex = selectedIndex;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    if (_badgeValue != badgeValue) {
        _badgeValue = badgeValue;
    }
}

#pragma mark Private Methods
#define ItemHeight 40
#define ItemWidth 40
/**
 *  @desc 创建Items
 *
 *  @param frame frame
 *  @param items items
 */
- (void)loadTabBarItems:(CGRect)frame items:(NSArray *)items
{
    self.itemsCount = items.count;
    CGFloat itemWidth = frame.size.width/self.itemsCount;
    NSMutableArray *itemsTmep = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < self.itemsCount; i++)
    {
        NSString *title = items[i];
        WGTabBarItem *itemBtn = [[WGTabBarItem alloc] init];
        [itemBtn setFrame:CGRectMake(itemWidth * i, 0, itemWidth, ItemHeight)];
        [itemBtn setTitle:title forState:UIControlStateNormal];
        itemBtn.tag = i;
        [itemBtn setTitleColor:GrayColor forState:UIControlStateNormal];
        [itemBtn setTitleColor:PinkColor forState:UIControlStateSelected];
        itemBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [self addSubview:itemBtn];
        
        //设置偏移量
        [itemBtn setImageEdgeInsets:UIEdgeInsetsMake(0, (itemWidth - ItemWidth)/2, frame.size.height - ItemHeight, (itemWidth - ItemWidth)/2)];
        [itemBtn setTitleEdgeInsets:UIEdgeInsetsMake(ItemHeight, -38, 0, 0)];
        
        //添加点击事件
        [itemBtn addTarget:self action:@selector(tabBarItemClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [itemsTmep addObject:itemBtn];
        
        [itemBtn showSHBadgeImage:i == 0?NumberBadge:PointBadge];
    }
    _items = [itemsTmep copy];
}

/**
 *  @desc 设置默认图片，选中图片
 *
 *  @param images         默认图片
 *  @param selectedImages 选中图片
 */
- (void)settingTabBarImage:(NSArray *)images selectedImage:(NSArray *)selectedImages
{
    for (int i = 0; i < self.itemsCount; i++)
    {
        UIButton *itemBtn = _items[i];
        [itemBtn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [itemBtn setImage:[UIImage imageNamed:selectedImages[i]] forState:UIControlStateSelected];
    }
}

/**
 *  @desc itemBtn 点击
 *
 *  @param sender
 */
- (void)tabBarItemClick:(id)sender
{
    UIButton *selBtn = (UIButton *)sender;
    if (self.selectedIndex != (selBtn.tag)) {
        UIButton *curBtn = _items[self.selectedIndex];
        curBtn.selected = NO;
        selBtn.selected = YES;
        self.selectedIndex = ((UIButton *)sender).tag;
        if (self.delegate) {
            [self.delegate WGTabBar:self didSelectedItem:sender];
        }
    } else {
        return;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

