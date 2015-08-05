//
//  WGCustomizedAlert.h
//  imssee
//
//  Created by 鑫易 on 15/1/15.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

/**
 *  @desc 自定义的UIAlerView
 */

#import <Foundation/Foundation.h>
@protocol WGCustomizedAlertDelegate;

@interface WGCustomizedAlert : NSObject

@property(nonatomic, strong)UIView * view;
@property(nonatomic, copy) void(^dismissEnd)(void);
@property(nonatomic, assign) id<WGCustomizedAlertDelegate>delegate;

- (id)initCustomizedAlertWithUIView:(UIView *)superview;

- (void)showAlertAnimation;

- (void)dismissAlertAnimation;

- (void)showAlertWithParentView:(UIView *)parentView;

- (void)showAlertWithParentView:(UIView*)parentView withOffSetTop:(float)offsetY;

- (void)showAlertWithParentView:(UIView*)parentView withOffSetTop:(float)offsetY withBanBackClickDismiss:(BOOL)ban;

- (void)canDismiss:(BOOL)dismiss;

@end

@protocol WGCustomizedAlertDelegate <NSObject>

@optional
- (void)showCustomizedAlertIsOverWithUIView:(UIView *)view;

- (void)dismissCustomizedAlertIsOverWithUiView:(UIView *)view;

@end
