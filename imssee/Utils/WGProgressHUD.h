//
//  WGProgressHUD.h
//  Homels
//
//  Created by 鑫易 on 14/12/24.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

/**
 *  @desc 本类主要封装MBProgressHUD的显示和处理
 */
#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface WGProgressHUD : NSObject<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}
//单例
+ (WGProgressHUD *)sharedInstance;

#pragma mark Master Show/Dismiss Method
- (void)dismiss;

/***********类别Method************/
#pragma mark Show Method
/**
 *  @desc 显示文字提示
 *
 *  @param view
 *  @param status 文字
 */
+ (void)showHUDAddedTo:(UIView *)view status:(NSString *)status;

/**
 *  @desc 显示具体描述的提示
 *
 *  @param view
 *  @param status
 *  @param detailStatus
 */
+ (void)showHUDAddedTo:(UIView *)view status:(NSString *)status detailStatus:(NSString *)detailStatus;

/**
 *  @desc 根据HUDModel显示不同的HUD
 *
 *  @param view
 *  @param status
 *  @param HUDModel
 */
+ (void)showHUDAddedTo:(UIView *)view status:(NSString *)status HUDModel:(MBProgressHUDMode)HUDModel;

/**
 *  @desc 显示自定义的View
 *
 *  @param view
 *  @param status
 *  @param customView 一个自定义的View 例如有图片的ImageView
 */
+ (void)showHUDAddedTo:(UIView *)view status:(NSString *)status customView:(UIView *)customView;

/**
 *  @desc 成功状态
 *
 *  @param view
 *  @param status
 */
+ (void)showSuccessWith:(UIView *)view status:(NSString *)status;

/**
 *  @desc 错误/失败状态
 *
 *  @param view
 *  @param status
 */
+ (void)showErrorWith:(UIView *)view status:(NSString *)status;

+ (void)showTipsWith:(UIView *)view status:(NSString *)status;

#pragma mark Dismiss Method
+ (void)dismissHUD;

@end
