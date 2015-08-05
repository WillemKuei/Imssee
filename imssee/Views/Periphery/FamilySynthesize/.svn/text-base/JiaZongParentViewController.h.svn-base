//
//  JiaZongParentViewController.h
//  imssee
//
//  Created by imsseeios3 on 15/2/27.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "SHViewController.h"

@interface JiaZongParentViewController : SHViewController

@end

/**
 *  @desc 底部菜单
 */
@protocol ButtomMenuDelegate;
@interface ButtomMenuView : UIView
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) id<ButtomMenuDelegate>delegate;

- (instancetype)initWithItems:(NSArray *)items delegate:(id<ButtomMenuDelegate>)delegate;

@end

/**
 *  @desc ButtomMenuItem
 */
@interface ButtomMenuItem : UIButton
@property (nonatomic, strong) NSArray *subItems;

@end

/**
 *  @desc MenuListCell
 */
@interface MenuListCell : UITableViewCell

@end

/**
 *  @desc ButtomMenuDelegate
 */
@protocol ButtomMenuDelegate <NSObject>

@optional
/**
 *  @desc 单击
 *
 *  @param menuItem
 */
- (void)buttomMenuClick:(UIButton *)menuItem;

/**
 *  @desc 长按
 *
 *  @param menuItem
 */
- (void)longPressButtomMenu:(UIButton *)menuItem;

@end

