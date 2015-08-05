//
//  AppMacro.h
//  Homels
//
//  Created by 鑫易 on 14/12/23.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

/**
 *  该类主要用于整理App所用到的所有宏，包括公用的颜色、Frame、动画时间等等
 */

#ifndef Homels_AppMacro_h
#define Homels_AppMacro_h

#define iPhone4Retina   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5         ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define FOR_SIT_IOS7_HEIGHT   (IOS_VERSION>=7.0 ? 64:44)

#define NAV_BAR_HEIGHT      10
#define STATUS_BAR_HEIGHT   10
#define OPTION_TEXTFONT     14.f
#define OPTION_MAXWIDTH     200
#define FootView_Height 44

#define SHPageView_HeaderHeight 108

#define kDebugDataDuration 0.5//debug状态获取数据停留时间
#define kIntroImgStayDuration 5.5//首页等待界面停留时间
#define kGlobalCurrentVerson @"v2.0.0"// 当前程序版本号
#define kBundleIdentifier @"com.shineease.chuguozhi"        //bundle ID 按实际进行修改

#define MyTarget(userid) [NSString stringWithFormat:@"%@/%@/%@_MyMessageList.xml",NSHomeDirectory(),@"Documents",userid]

#define R_UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]    //颜色编码转换成RGB颜色，注：rgbValue要加括号
#define BLUE_COLOR [UIColor colorWithRed:108.f/255.f green:167.f/255.f blue:225.f/255.f alpha:1]
#define WRONG_COLOR [UIColor colorWithRed:217.f/255.f green:96.f/255.f blue:101.f/255.f alpha:1]
#define RIGHT_COLOR [UIColor colorWithRed:162.f/255.f green:189.f/255.f blue:85.f/255.f alpha:1]
#define TabBar_BackGroundColor [UIColor colorWithRed:249.f/255.f green:249.f/255.f blue:249.f/255.f alpha:1.0f]
#define GrayColor [UIColor colorWithRed:130.f/255.f green:130.f/255.f blue:130.f/255.f alpha:1.0f]
#define PinkColor [UIColor colorWithRed:255.f/255.f green:102.f/255.f blue:153.f/255.f alpha:1.0f]
#define CLEAR_COLOR [UIColor clearColor]
#define WHITE_COLOR [UIColor whiteColor]
#define CUSTOM_BGCOLOR [UIColor colorWithRed:31.f/255.f green:37.f/255.f blue:61.f/255.f alpha:1]
#define GREEN_COLOR [UIColor colorWithRed:2.f/255.f green:155.f/255.f blue:80.f/255.f alpha:1]
#define GOLDEN_COLOR [UIColor colorWithRed:251.f/255.f green:216.f/255.f blue:96.f/255.f alpha:1]
#define LIGHT_GRAY_COLOR [UIColor colorWithRed:200.f/255.f green:200.f/255.f blue:200.f/255.f alpha:1]

#define Release(obj) if(obj){obj=nil;}

#define RoundImg(radius,image) image.layer.cornerRadius = radius;\
image.layer.masksToBounds = YES;\
image.layer.borderWidth = 2.f;\
image.layer.borderColor = WRONG_COLOR.CGColor;

#define PAUSE(timer) [timer setFireDate:[NSDate distantFuture]]     //暂停
#define START(timer) [timer setFireDate:[NSDate date]]              //开始
#define INVALIDATE(timer) [timer invalidate];timer = nil             //永久停止定时器

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif
// ALog always displays output regardless of the DEBUG setting
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

//UMAnalycls
#define BeginLogPageView [MobClick beginLogPageView:NSStringFromClass([self class])]
#define EndLogPageView [MobClick endLogPageView:NSStringFromClass([self class])]

//UIHelper
#define TAG_TEXT_FIELD_PHONE_NUM        1000

#define kDuration 0.7   // 动画持续时间(秒)

#endif
