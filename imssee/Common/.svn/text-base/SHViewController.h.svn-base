//
//  SHViewController.h
//  imssee
//
//  Created by 鑫易 on 15/1/29.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SettingPageViewFrame CGRect frame = self.view.frame;\
self.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height - SHPageView_HeaderHeight);
#define SettingTabBarItemViewFrame CGRect frame = self.view.frame;\
self.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height - 49);

@class WGTabBarItem, WGNavigationBarItem;
@protocol CommonSelectedRowDelegate;
@interface SHViewController : UIViewController
{
    UILabel *_titleLab;
}

@property (nonatomic, strong) WGTabBarItem *wgTabBarItem;

@property (nonatomic, assign) id<CommonSelectedRowDelegate>delegate;

//@property (nonatomic, readonly, strong) WGNavigationBarItem *WGNavigationBarItem;

@property (nonatomic, copy) NSString *navTitle;

#pragma mark 设置LeftBarButtonItem/RightBarButtonItem
/**
 *  @desc 设置LeftBarButtonItem，使用方法：自定义好UIButton，调用此方法
 *
 *  @param WGItem 自定义的UIButton
 */
- (void)settingWGLeftBarButtonItem:(UIButton *)WGItem;

/**
 *  @desc 设置RightBarButtonItem，使用方法：自定义好UIButton，调用此方法
 *
 *  @param WGItem 自定义的UIButton
 */
- (void)settingWGRightBarButtonItem:(UIButton *)WGItem;

/**
 *  @desc 设置titleView，使用方法：自定义好subView，调用此方法
 *
 *  @param titleView
 */
- (void)settingTitleView:(UIView *)titleView;

@end


/**
 *  @desc 公共的点击cell的代理，主要用于SHPageViewController点击cell切换页面使用
 */
@protocol CommonSelectedRowDelegate <NSObject>

@optional
- (void)tableView:(UITableView *)tableView didSelectedRowAtIndexPath:(NSIndexPath *)indexPath viewController:(UIViewController *)superviewController dataSource:(NSArray *)dataSource;

- (void)tableView:(UITableView *)tableView extendBtnClickAtIndexPath:(NSIndexPath *)indexPath viewController:(UIViewController *)superviewController;

@end


/**
 *  @desc 自定义类别
 */
@interface SHViewController (WGNavigationBarItem)

@property (nonatomic, strong) UIImageView *WGNavigationBar;

@property (nonatomic, strong) UIButton *WGLeftBarButtonItem;

@property (nonatomic, strong) UIButton *WGRightBarButtonItem;

@property (nonatomic, strong) UIView *WGTitleView;

@end