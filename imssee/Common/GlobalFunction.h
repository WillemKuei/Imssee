//
//  GlobalFunction.h
//  imssee
//
//  Created by app001.cn on 14-12-31.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalFunction : NSObject
{
    
}

//检查是否iphone5
+(bool)checkIsIPhone5State;

//异步
+(void)dispatchAction:(void(^)(void))proccessingActionBlock withBackAction:(void(^)(void))backActionBlock;

//xib实例化对象
+(id)getNibFromNibName:(NSString*)nibName;

//获取时间戳
+(NSString*)getTimestamp;

//注册推送
+(void)registerPushInfo;

//直接跳转连接
+(void)openUrl:(NSString*)url;

//trim字符串
+(NSString*)trimValueBy:(NSString*)text;

//检测是否空
+(bool)checkIsNotNull:(NSString*)text;

+ (id)checkDataIsNotNull:(id)sender;

//获取安全字符串,（因为接口获取空的时候赋值到UIlabel的text时候会报错）
+(NSString*)getSaveString:(NSString*)text;

//安全赋值 （text参数空也不怕）
+(void)giveValueToLabel:(UILabel*)label withText:(NSString*)text;

//获取安全浮点
+(float)getSaveFloat:(NSString*)text;

//复制到粘贴板
+(void)pasteString:(NSString*)text;

//r g b a 获取颜色
+(UIColor*)getColorFromR:(float)r G:(float)g B:(float)b A:(float)a;

//r g b 获取颜色
+(UIColor*)getColorFromR:(float)r G:(float)g B:(float)b ;

//列表的indexpath获取实体
+(id)findEtyFromIndexPath:(NSIndexPath*)path fromList:(NSArray*)list;

//检查 s1 和 s2 是否相同
+(bool)checkSaveIsEqualToString:(NSString*)s1 withCompared:(NSString*)s2;

//直接Alert
+(void)alertDirect:(NSString*)alertString;

//动画
+(void)proccessAnimation:(void(^)(void))animationBlock withDuration:(float)duration;

+ (NSString *)urlEncode:(NSString *)unencodeString;

+(NSArray*)getDataFromJson:(id)json;
//获取安全int
+(int)getSaveInt:(NSString*)text;
+ (NSString *)URLEncodedStringWithString:(NSString*)text;
+ (NSString*)URLDecodedStringWithString:(NSString*)text;
+(NSString*)utf8Convert:(NSString*)text;
//打电话
+(void)callphone:(NSString *)num;



//获取手机系统版本
+(NSString *)currentSystem;

//获取系统当前语言
+(NSString *)getCurrentLanguage;

/**
 *  @desc 将图片修剪为需要的尺寸
 *
 *  @param image 需要修剪的图片
 *  @param size  需要的尺寸
 *
 *  @return 修剪后的图片
 */
+(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;

//公共参数部分
+ (NSString *)commonUrlPath;

//写入Plist文件
+ (BOOL)writeToFile:(id)obj withPath:(NSString *)path;

/**
 *  @desc 获取Document目录
 */
+ (NSString *)documentFilePath;

/**
 *  @desc 获取文件路径
 */
+ (NSString *)getFileFullPath:(NSString *)path;

/**
 @desc 返回类的属性列表
 @param 类对应的class
 @return NSArray 属性列表
 */
+ (NSArray *)propertiesName:(Class)cls;

/******************************************************
 ** 出国志项目
 ******************************************************/
/**
 *  @desc 将“/”将的文字改变字体(此方法只能改变字体大小，颜色)
 *
 *  @param string 需要改变的文字
 *
 *  @return
 */
+ (NSMutableAttributedString *)editAttributedString:(NSString *)string fontValue:(id)font textColorValue:(id)textColor;

/**
 *  @desc 计算文字高度
 *
 *  @param text
 *  @param font
 *  @param width
 *
 *  @return labelSize
 */
+ (CGFloat)caculateTextSizeWithText:(NSString *)text textFont:(id)font size:(CGSize)size;

/**
 *  @desc 将聊天泡泡背景图做处理
 *
 *  @param originalImage
 *
 *  @return newImage
 */
+ (UIImage *)resizableImageWithImage:(UIImage *)originalImage;

/**
 *  @desc 给keyBoardiglk增加toolbar
 *
 *  @param target 响应目标
 *  @param finisheSel 完成操作
 *  @param cancelSel  取消操作
 *
 *  @return toolBar
 */
+ (UIToolbar *)addToolbarInkeyBoardWithTarget:(id)target finisheSel:(SEL)finisheSel cancelSel:(SEL)cancelSel;

/**
 *  @desc 设置头像
 *
 *  @param urlPath   头像地址
 *  @param imageview 当前头像
 */
+ (void)resetHeaderImage:(NSString *)urlPath headerImageView:(UIImageView *)imageview;

/**
 *  @desc 截屏
 *
 *  @return 当前截屏图像
 */
+ (UIImage *)screenCapture;



/**
 *  @desc 检测当前目录是否存在该文件
 *
 *  @param filePath 文件目录
 *
 *  @return
 */
+ (BOOL)checkFileExistsAtPath:(NSString *)filePath;

/**
 *  @desc 数据缓存到cache
 *
 *  @param obj      需要缓存的数据
 *  @param filePath 路径
 *
 *  @return
 */
+ (BOOL)saveCacheToFile:(id)obj filePath:(NSString *)filePath;

/**
 *  @desc 计算时间间隔
 *
 *  @param currentTime
 *  @param compareDate
 *
 *  @return
 */
+ (NSString *)compareCurrentTime:(NSDate *)currentTime compareDate:(NSDate *)compareDate;

///**
// *  @desc 二维码图片
// *
// *  @return
// */
//+ (UIImage *)publicShareImage;

/**
 *  @desc 滚动视图内容截图
 *
 *  @return contentImg
 */
+ (UIImage *)contentViewCapture:(UIScrollView *)contentView;

/**
 *  @desc HeaderView 截图
 *
 *  @return headerImg
 */
+ (UIImage *)headerViewCapture:(CGSize)size;

/**
 *  @desc 拼接图片
 *
 *  @param imageOne
 *  @param imageTwo
 *
 *  @return 拼接后的图片resultImage
 */
+ (UIImage *)addImageFirst:(UIImage *)imageOne toImageSecond:(UIImage *)imageTwo;

/**
 *  @desc 下载头像
 *
 *  @param filePath 保存路径
 *  @param iconUrl  下载地址
 */
+ (void)downloadUserHeaderImageToFile:(NSString *)filePath iconUrl:(NSString *)iconUrl;

/**
 *  @desc 设置字体
 *
 *  @param string
 *  @param range
 *  @param textColor
 *
 *  @return
 */
+ (id)editAttributedString:(NSString *)string range:(NSRange)range textColor:(id)textColor;

/******************************************************
 ** 社缘项目
 ******************************************************/
/**
 *  @desc 给图片添加圆角和阴影
 *
 *  @param imageView 需要改变的imageView
 */
+ (void)radiusImageView:(UIImageView *)imageView radius:(float)radius;

/**
 *  @desc 计算字符宽度
 *
 *  @param string
 *  @param rectSize
 *  @param fontSize
 *
 *  @return
 */
+ (CGFloat)getWidthOfString:(NSString *)string withSize:(CGSize)rectSize fontSize:(UIFont *)fontSize;

@end
