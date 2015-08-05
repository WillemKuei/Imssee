//
//  NewsMenuListView.h
//  imssee
//
//  Created by 鑫易 on 15/2/2.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewsMenuDelegate;
@interface NewsMenuListView : UIView
{
    UIScrollView *_menuScro;
}

@property (nonatomic, strong) NSArray *menus;
@property (nonatomic) NSUInteger selectedIndex;
@property (nonatomic) SEL action;
@property (nonatomic, assign) id<NewsMenuDelegate>delegate;
@property (nonatomic, strong) UIScrollView *menuScro;
@property (nonatomic, assign) CGFloat menuItemWidth;

- (instancetype)initWithFrame:(CGRect)frame menus:(NSArray *)menus delegate:(id<NewsMenuDelegate>)delegate;

@end

@protocol NewsMenuDelegate <NSObject>

@optional
- (void)menuItemClick:(NewsMenuListView *)itemSuperView didSelectedIndex:(NSUInteger)selectedIndex;

@end