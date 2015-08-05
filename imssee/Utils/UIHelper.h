/******************************************************
 *标题:         uiView
 *创建人:        闫燕
 *创建日期:      13-7-23
 *功能及说明:    相关uiview的封装－－均未类方法
 *
 *修改记录列表:
 *修改记录:
 *修改日期:
 *修改者:
 *修改内容简述:
 *********************************************************/
#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface UIHelper : NSObject


/**************************************************************
 ** 功能:     弹出alert提示
 ** 参数:     nsstring
 ** 返回:     无
 **************************************************************/
+ (void)alertWithTitle:(NSString*)title;

/**************************************************************
 ** 功能:     弹出alert提示
 ** 参数:     nsstring（标题）、nsstring（内容）
 ** 返回:     无
 **************************************************************/
+ (void)alertWithTitle:(NSString*)title andMSG:(NSString*)msg;


/**************************************************************
 ** 功能:     弹出alert提示
 ** 参数:     nsstring（标题）、nsstring（内容）,tag(标签)
 ** 返回:     无
 **************************************************************/
+ (void)alertWithTitle:(NSString*)title andMSG:(NSString*)msg delegate:(id)sender andTag:(NSInteger)tag;

/**************************************************************
 ** 功能:     弹出alert提示
 ** 参数:     nsstring（标题）、nsstring（输入框内容）、代理对象
 ** 返回:     无
 **************************************************************/
+ (void)alertWithTitle:(NSString*)title textFContent:(NSString*)text delegate:(id)sender andTag:(NSInteger)tag;

/**************************************************************
 ** 功能:     弹出拨打电话前的alert提示
 ** 参数:     nsstring（提示内容内容）、代理对象
 ** 返回:     无
 **************************************************************/
+ (void)alertWithMsg:(NSString*)msg delegate:(id)sender andTag:(NSInteger)tag;

/**************************************************************
 ** 功能:     加loading view
 ** 参数:     cgrect(loadingview的frame)、id（加在此对象上）
 ** 返回:     无
 **************************************************************/
+ (void)addLoadingViewTo:(UIView*)targetV withFrame:(CGRect)frame andText:(NSString*)text;


/**************************************************************
 ** 功能:     定制navigation bar
 ** 参数:     uiimage（背景图片）、nsstring（标题）、id（目标对象）、响应方法
 ** 返回:     uiview
 **************************************************************/
+ (UIView*)headerViewWithImage:(UIImage*)img title:(NSString*)title target:(id)sender backAction:(SEL)backAction;

/**************************************************************
 ** 功能:     首页导航栏
 ** 参数:     img ,title ,target, leftItemAction, rightItemAction
 ** 返回:     uiview
 **************************************************************/
+ (UIView *)headerViewWithImage:(UIImage *)img title:(NSString *)title target:(id)sender leftItemAction:(SEL)leftItemAction rightItemAction:(SEL)rightItemAction;

/**************************************************************
 ** 功能:     颜色十六进制编码转换成UIColor
 ** 参数:     十六进制字符串
 ** 返回:     UIColor
 **************************************************************/
+ (UIColor *)colorWithHexString:(NSString *)color;

@end
