//
//  WGProgressHUD.m
//  Homels
//
//  Created by 鑫易 on 14/12/24.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

#import "WGProgressHUD.h"

@implementation WGProgressHUD

//单例
+ (WGProgressHUD *)sharedInstance
{
    static dispatch_once_t once;
    static WGProgressHUD *WGProgressHUD = nil;
    dispatch_once(&once, ^{
        WGProgressHUD = [[self alloc] init];
    });
    return WGProgressHUD;
}

#pragma mark Master Show/Dismiss Method
/**
 *  @desc 隐藏HUD
 */
- (void)dismiss{
    [HUD hide:YES];
}

- (void)showLabel:(NSString *)status view:(UIView *)view
{
    HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.delegate = self;
    HUD.labelText = status;
}

- (void)showDetailsLabel:(UIView *)view labelText:(NSString *)labelText detailsLabelText:(NSString *)detailsLabelText
{
    HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.delegate = self;
    HUD.labelText = labelText;
    HUD.detailsLabelText = detailsLabelText;
    HUD.square = YES;   //是否正方
}

- (void)showDeterminate:(UIView *)view labelText:(NSString *)labelText HUDMode:(MBProgressHUDMode)HUDModel
{
    HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = HUDModel;
    HUD.delegate = self;
    HUD.labelText = labelText;
}

- (void)showCustomViewTo:(UIView *)view labelText:(NSString *)labelText customView:(UIView *)customView
{
    HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = customView;
    HUD.delegate = self;
    HUD.labelText = labelText;
    [HUD show:YES];
}

- (void)showSuccess:(UIView *)view labelText:(NSString *)labelText
{
    sleep(1);
    UIImage *image = [UIImage imageNamed:@"Checkmark.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    if (!HUD) {
        HUD = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:HUD];
    }
    HUD.customView = imageView;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = labelText;
    [HUD show:YES];
    [HUD hide:YES afterDelay:0.5];
    
    image = nil;
    imageView = nil;
}

- (void)showError:(UIView *)view labelText:(NSString *)labelText
{
    sleep(1);
    UIImage *image = [UIImage imageNamed:@"Error.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    if (!HUD) {
        HUD = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:HUD];
    }
    HUD.customView = imageView;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = labelText;
    [HUD show:YES];
    [HUD hide:YES afterDelay:0.5];
    
    image = nil;
    imageView = nil;
}

- (void)showTips:(UIView *)view tipsText:(NSString *)tipsText
{
    HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = tipsText;
    HUD.delegate = self;
    [HUD show:YES];
    [HUD hide:YES afterDelay:0.5];
}

#pragma mark Show Method
+ (void)showHUDAddedTo:(UIView *)view status:(NSString *)status
{
    [[self sharedInstance] showLabel:status view:view];
}

+ (void)showHUDAddedTo:(UIView *)view status:(NSString *)status detailStatus:(NSString *)detailStatus
{
    [[self sharedInstance] showDetailsLabel:view labelText:status detailsLabelText:detailStatus];
}

+ (void)showHUDAddedTo:(UIView *)view status:(NSString *)status HUDModel:(MBProgressHUDMode)HUDModel
{
    [[self sharedInstance] showDeterminate:view labelText:status HUDMode:HUDModel];
}

+ (void)showHUDAddedTo:(UIView *)view status:(NSString *)status customView:(UIView *)customView
{
    [[self sharedInstance] showCustomViewTo:view labelText:status customView:customView];
}

+ (void)showSuccessWith:(UIView *)view status:(NSString *)status
{
    [[self sharedInstance] showSuccess:view labelText:status];
}

+ (void)showErrorWith:(UIView *)view status:(NSString *)status
{
    [[self sharedInstance] showError:view labelText:status];
}

+ (void)showTipsWith:(UIView *)view status:(NSString *)tips
{
    [[self sharedInstance] showTips:view tipsText:tips];
}

#pragma mark Dismiss Method
+ (void)dismissHUD
{
    [[self sharedInstance] dismiss];
}

#pragma mark - Execution code
- (void)myTask
{
    // Do something usefull in here instead of sleeping ...
    sleep(3);
}

#pragma mark MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [HUD removeFromSuperview];
#if __has_feature(objc_arc)
    HUD = nil;
#else
    [HUD release];
    HUD = nil;
#endif
}

@end
