//
//  UIHelper.m
//  tp_self_help
//
//  Created by cloudpower on 13-7-23.
//  Copyright (c) 2013年 cloudpower. All rights reserved.
//

#import "UIHelper.h"

@implementation UIHelper


/**************************************************************
 ** 功能:     弹出alert提示
 ** 参数:     nsstring
 ** 返回:     无
 **************************************************************/
+ (void)alertWithTitle:(NSString*)title{
    UIAlertView *view = [[UIAlertView alloc] init];
    view.title = @"温馨提示";
    view.message=title;
    [view addButtonWithTitle:@"确定"];
    [view show];
    [view release];
}

/**************************************************************
 ** 功能:     弹出alert提示
 ** 参数:     nsstring（标题）、nsstring（内容）
 ** 返回:     无
 **************************************************************/
+ (void)alertWithTitle:(NSString*)title andMSG:(NSString*)msg{
    UIAlertView *view = [[UIAlertView alloc] init];
    view.title = title;
    view.message = msg;
    [view addButtonWithTitle:@"确定"];
    [view show];
    [view release];
}
/**************************************************************
 ** 功能:     弹出alert提示
 ** 参数:     nsstring（标题）、nsstring（内容）
 ** 返回:     无
 **************************************************************/
+ (void)alertWithTitle:(NSString*)title andMSG:(NSString*)msg delegate:(id)sender andTag:(NSInteger)tag{
    UIAlertView *view = [[UIAlertView alloc] init];
    view.title = title;
    view.message = msg;
    view.tag=tag;
    view.delegate=sender;
    [view addButtonWithTitle:@"取消"];
    [view addButtonWithTitle:@"确定"];
    [view show];
    [view release];
}

/**************************************************************
 ** 功能:     弹出alert提示
 ** 参数:     nsstring（标题）、nsstring（输入框内容）、代理对象
 ** 返回:     无
 **************************************************************/
+ (void)alertWithTitle:(NSString*)title textFContent:(NSString*)text delegate:(id)sender andTag:(NSInteger)tag{
    UIAlertView *view = [[UIAlertView alloc] init];
    view.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[view textFieldAtIndex:0] setText:text];
    [[view textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [[view textFieldAtIndex:0] setTag:TAG_TEXT_FIELD_PHONE_NUM];
    [[view textFieldAtIndex:0] setDelegate:sender];
    view.title = title;
    [view addButtonWithTitle:@"取消"];
    [view addButtonWithTitle:@"拨打"];
    view.delegate = sender;
    view.tag = tag;
    [view show];
    [view release];
}

/**************************************************************
 ** 功能:     弹出拨打电话前的alert提示
 ** 参数:     nsstring（提示内容内容）、代理对象
 ** 返回:     无
 **************************************************************/
+ (void)alertWithMsg:(NSString*)msg delegate:(id)sender andTag:(NSInteger)tag{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:sender cancelButtonTitle:@"取消" otherButtonTitles:@"拨打", nil];
    view.tag = tag;
    [view show];
    [view release];
}


/**************************************************************
 ** 功能:     加loading view
 ** 参数:     cgrect(loadingview的frame)、id（加在此对象上）
 ** 返回:     无
 **************************************************************/
+ (void)addLoadingViewTo:(UIView*)targetV withFrame:(CGRect)frame andText:(NSString*)text{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithFrame:frame];
    [targetV addSubview:hud];
    [hud release];
    hud.labelText = text;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
}


/**************************************************************
 ** 功能:     定制navigation bar
 ** 参数:     uiimage（背景图片）、nsstring（标题）、id（目标对象）、响应方法
 ** 返回:     uiview
 **************************************************************/
+ (UIView*)headerViewWithImage:(UIImage*)img title:(NSString*)title target:(id)sender backAction:(SEL)backAction{
    CGFloat screen_width = SCREEN_WIDTH;
    UIImageView *view = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, FOR_SIT_IOS7_HEIGHT)] autorelease];
    view.userInteractionEnabled = YES;
    [view setImage:img];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [button addTarget:sender action:backAction forControlEvents:UIControlEventTouchUpInside];
    UILabel *label = [[[UILabel alloc] init] autorelease];
    //CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:20]];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    if (IOS_VERSION>=7.0) {
        [button setFrame:CGRectMake(5, 25, 33, 33)];
        [label setFrame:CGRectMake((screen_width - size.width)/2, 25, size.width, (44 - 10))];
    }
    //不兼容ios6以下系统
//    else
//    {
//        [button setFrame:CGRectMake(5, 5, 33, 33)];
//         [label setFrame:CGRectMake((320 - size.width)/2, 5, size.width, (44 - 10))];
//    }
    [view addSubview:button];

    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:20];
    label.text = title;
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];
    
    return view;
}

/**************************************************************
 ** 功能:     首页导航栏
 ** 参数:     img ,title ,target, leftItemAction, rightItemAction
 ** 返回:     uiview
 **************************************************************/
+ (UIView *)headerViewWithImage:(UIImage *)img title:(NSString *)title target:(id)sender leftItemAction:(SEL)leftItemAction rightItemAction:(SEL)rightItemAction
{
    CGFloat screen_width = SCREEN_WIDTH;
    UIImageView *view = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, FOR_SIT_IOS7_HEIGHT)] autorelease];
    view.userInteractionEnabled = YES;
    [view setImage:img];
    //title
    UILabel *label = [[[UILabel alloc] init] autorelease];
    //CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:20]];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    [label setFrame:CGRectMake((screen_width - size.width)/2, 25, size.width, (44 - 10))];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:20];
    label.text = title;
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];
    //backBtn
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
    [backBtn addTarget:sender action:leftItemAction forControlEvents:UIControlEventTouchUpInside];
    [backBtn setFrame:CGRectMake(5, 25, 33, 33)];
    [view addSubview:backBtn];
    //settingBtn
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [settingBtn addTarget:sender action:rightItemAction forControlEvents:UIControlEventTouchUpInside];
    [settingBtn setFrame:CGRectMake(screen_width - 5 - 33, 25, 33, 33)];
    [view addSubview:settingBtn];
    
    return view;
}

/**************************************************************
 ** 功能:     首页导航栏
 ** 参数:     img ,title ,target, leftItemAction, rightItemAction
 ** 返回:     uiview
 **************************************************************/
//+ (UIView *)headerViewWithImage:(UIImage *)img title:(NSString *)title target:(id)sender leftItem:(SEL)leftItem rightItem:(SEL)rightItem
//{
//    
//}

/**************************************************************
 ** 功能:     颜色十六进制编码转换成UIColor
 ** 参数:     十六进制字符串
 ** 返回:     UIColor
 **************************************************************/
+ (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //red
    NSString *rString = [cString substringWithRange:range];
    
    //green
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //bluee
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    //Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:1.0f];
}


@end
