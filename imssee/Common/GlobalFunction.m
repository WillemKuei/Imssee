//
//  GlobalFunction.m
//  imssee
//
//  Created by app001.cn on 14-12-31.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

#import "GlobalFunction.h"
#import "UIImage+Utility.h"
#import <objc/runtime.h>

@implementation GlobalFunction

//检查是否iphone5
+(bool)checkIsIPhone5State{
    float screenHeight=[UIScreen mainScreen].bounds.size.height;
    if(screenHeight>=568){
        return YES;
    }else{
        return false;
    }
    
}

//异步
+(void)dispatchAction:(void(^)(void))proccessingActionBlock withBackAction:(void(^)(void))backActionBlock{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if(proccessingActionBlock){
            proccessingActionBlock();
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if(backActionBlock){
                backActionBlock();
            }
        });
    });
}

//异步（模拟接口获取数据专用）
+(void)DebugDispatchAction:(void(^)(void))proccessingActionBlock withBackAction:(void(^)(void))backActionBlock{
    [GlobalFunction dispatchAction:^{
        [NSThread sleepForTimeInterval:kDebugDataDuration];
        proccessingActionBlock();
    } withBackAction:^{
        backActionBlock();
    }];
}

//xib实例化对象
+(id)getNibFromNibName:(NSString*)nibName{
    NSArray*nibs=[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    id resultObj=[nibs objectAtIndex:0];
    return resultObj;
}

//注册推送
+(void)registerPushInfo{
    [[UIApplication sharedApplication]
     registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
}

//直接跳转连接
+(void)openUrl:(NSString*)url{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

//trim字符串
+(NSString*)trimValueBy:(NSString*)text{
    NSString*returnValue=[text   stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return returnValue;
    
}

//获取安全字符串,（因为接口获取空的时候赋值到UIlabel的text时候会报错）
+(NSString*)getSaveString:(NSString*)text{
    if([GlobalFunction checkIsNotNull:text]){
        return text;
    }
    else{
        return @"";
    }
}

//检测是否空
+(bool)checkIsNotNull:(NSString*)text{
    if([text class]==[NSNull class] || text==nil){
        return NO;
    }else {
        
        return YES;
    }
}

+ (id)checkDataIsNotNull:(id)sender
{
    id returnData = [GlobalFunction checkIsNotNull:sender]?sender:nil;
    return returnData;
}

//安全赋值 （text参数空也不怕）
+(void)giveValueToLabel:(UILabel*)label withText:(NSString*)text{
    if([GlobalFunction checkIsNotNull:text]){
        label.text=text;
    }
    else {
        label.text=@"";
    }
}

//获取安全int
+(int)getSaveInt:(NSString*)text{
    if([GlobalFunction checkIsNotNull:text]){
        return [text intValue];
    }
    else {
        return 0;
    }
}
//获取安全浮点
+(float)getSaveFloat:(NSString*)text{
    if([GlobalFunction checkIsNotNull:text]){
        return [text floatValue];
    }
    else {
        return 0;
    }
    
    
}


//复制到粘贴板
+(void)pasteString:(NSString*)text{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = text;
}


//r g b a 获取颜色
+(UIColor*)getColorFromR:(float)r G:(float)g B:(float)b A:(float)a{
    UIColor*resultColor=[UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a];
    return resultColor;
}
//r g b 获取颜色
+(UIColor*)getColorFromR:(float)r G:(float)g B:(float)b{
    return [GlobalFunction getColorFromR:r G:g B:b A:255];
}
//列表的indexpath获取实体
+(id)findEtyFromIndexPath:(NSIndexPath*)path fromList:(NSArray*)list{
    NSInteger row=path.row;
    return [list objectAtIndex:row];
}
//检查 s1 和 s2 是否相同
+(bool)checkSaveIsEqualToString:(NSString*)s1 withCompared:(NSString*)s2{
    if(  [GlobalFunction checkIsNotNull:s1] && [GlobalFunction checkIsNotNull:s2]){
        if([s1 isEqualToString:s2]){
            return YES;
        }else {
            return false;
        }
    }
    else {
        return false;
    }
}
//直接Alert
+(void)alertDirect:(NSString*)alertString{
    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:alertString delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil];
    [alert show];
}
+(NSArray*)getDataFromJson:(id)json{
    id data=[json valueForKeyPath:@"data"];
    if([@"" isEqualToString:(NSString*)data]){
        return nil;
    }
    else
    {
        return data;
        
    }
}
+(void)proccessAnimation:(void(^)(void))animationBlock withDuration:(float)duration{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    animationBlock();
    [UIView commitAnimations];
}

+ (NSString *)urlEncode:(NSString *)unencodeString
{
    //    return (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)unencodeString, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 ));
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)unencodeString, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
}


+ (NSString *)URLEncodedStringWithString:(NSString*)text{
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)text,
                                                                                             NULL,
                                                                                             CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                             kCFStringEncodingUTF8);
    return result;
}


+ (NSString*)URLDecodedStringWithString:(NSString*)text{
    
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                             (CFStringRef)text,
                                                                                                             CFSTR(""),
                                                                                                             kCFStringEncodingUTF8);
    return result;
}


+(NSString*)utf8Convert:(NSString*)text{
    NSString*s=[text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return s;
    
}

//打电话
+(void)callphone:(NSString *)num{
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",num]];
    [[UIApplication sharedApplication] openURL:phoneURL];
}

//获取时间戳
+(NSString*)getTimestamp{
    NSTimeInterval inteval=[[NSDate date] timeIntervalSince1970];
    int intValue=inteval;
    NSString*timeS=[NSString stringWithFormat:@"%d",intValue];
    return timeS;
}


//获取手机系统版本
+(NSString *)currentSystem
{
    NSString *systemVer = [[UIDevice currentDevice] systemVersion];
    return systemVer;
}

//获取系统当前语言
+(NSString *)getCurrentLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSLog(@"currentLanguage = %@",currentLanguage);
    return currentLanguage;
}

/**
 *  @desc 将图片修剪为需要的尺寸
 *
 *  @param image 需要修剪的图片
 *  @param size  需要的尺寸
 *
 *  @return 修剪后的图片
 */
+(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

//公共参数部分
+ (NSString *)commonUrlPath
{
    NSString *commonUrlPath = [NSString stringWithFormat:@"&vn=%@&ch=AppStore&lang=%@&pkg=%@",kGlobalCurrentVerson,[[self class] getCurrentLanguage],kBundleIdentifier];
    return commonUrlPath;
}

//写入Plist文件
+ (BOOL)writeToFile:(id)obj withPath:(NSString *)path
{
    //NSString *filePath = [[self class] getFileFullPath:path];
    NSString *filePath = [[self class] documentFilePath];
    filePath = [filePath stringByAppendingPathComponent:path];
    
    if ([obj isKindOfClass:[NSArray class]])        //写入的是数组类
    {
        return [(NSArray *)obj writeToFile:filePath atomically:YES];
    }
    else if ([obj isKindOfClass:[NSString class]])  //写入的是字符串
    {
        return [(NSString *)obj writeToFile:filePath
                                 atomically:YES
                                   encoding:NSUTF8StringEncoding
                                      error:nil];
    }
    else if ([obj isKindOfClass:[NSData class]])    //写入的是数据
    {
        return [(NSData *)obj writeToFile:filePath atomically:YES];
    }
    else if ([obj isKindOfClass:[NSDictionary class]])//写入的是字典
    {
        return [(NSDictionary *)obj writeToFile:filePath atomically:YES];
    }
    
    return NO;
}

//从本地获取数据

/**
 *  @desc 获取Document目录
 */
+ (NSString *)documentFilePath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return path;
}

/**
 *  @desc 获取文件路径
 */
+ (NSString *)getFileFullPath:(NSString *)path
{
    NSString *basePath = [[self class] documentFilePath];
    NSString *subPath = [basePath stringByAppendingPathComponent:path];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    if (![fileManager fileExistsAtPath:subPath])
    {
        [fileManager createDirectoryAtPath:subPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (!error)
        {
            DLog(@"文件路径创建错误:%@",[error description]);
        }
    }
    
    return subPath;
}

/**
 @desc 返回类的属性列表
 @param 类对应的class
 @return NSArray 属性列表
 */
+ (NSArray *)propertiesName:(Class)cls
{
    if(cls == nil) return nil;
    unsigned int outCount,i;
    objc_property_t * properties = class_copyPropertyList(cls, &outCount);
    NSMutableArray * list = [NSMutableArray arrayWithCapacity:outCount];
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        NSString * propertyName = [NSString stringWithUTF8String:property_getName(property)];
        if(propertyName && [propertyName length] != 0)
        {
            [list addObject:propertyName];
        }
    }
    return list;
}

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
+ (NSMutableAttributedString *)editAttributedString:(NSString *)string fontValue:(id)font textColorValue:(id)textColor
{
    NSRange range = NSMakeRange(0, string.length - ([string rangeOfString:@"/"]).location - 1);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    [attributedString addAttribute:NSFontAttributeName value:font range:range];
    return attributedString;
}

/**
 *  @desc 计算文字高度
 *
 *  @param text
 *  @param font
 *  @param size
 *
 *  @return labelSize
 */
+ (CGFloat)caculateTextSizeWithText:(NSString *)text textFont:(id)font size:(CGSize)size
{
    UIFont *textFont = font;
    CGSize constraintSize = size;
    CGSize labelSize = [text sizeWithFont:textFont constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
    return MAX(44, labelSize.height);
}

/**
 *  @desc 将聊天泡泡背景图做处理
 *
 *  @param originalImage
 *
 *  @return newImage
 */
+ (UIImage *)resizableImageWithImage:(UIImage *)originalImage
{
    CGFloat top = 1;
    CGFloat bottom = 10;
    CGFloat left = 14;
    CGFloat right = 1;
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImage *newImage = [originalImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    return newImage;
}

/**
 *  @desc 给keyBoardiglk增加toolbar
 *
 *  @param target 响应目标
 *  @param finisheSel 完成操作
 *  @param cancelSel  取消操作
 *
 *  @return toolBar
 */
+ (UIToolbar *)addToolbarInkeyBoardWithTarget:(id)target finisheSel:(SEL)finisheSel cancelSel:(SEL)cancelSel
{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [toolBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:target action:cancelSel];
    UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:target action:nil];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:target action:finisheSel];
    [toolBar setItems:@[cancelBtn,spaceButton,doneBtn]];
    
    return toolBar;
}



/**
 *  @desc 截屏
 *
 *  @return 当前截屏图像
 */
+ (UIImage *)screenCapture
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


/**
 *  @desc 检测当前目录是否存在该文件
 *
 *  @param filePath 文件目录
 *
 *  @return
 */
+ (BOOL)checkFileExistsAtPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {
        return NO;
    }
    
    return YES;
}

/**
 *  @desc 数据缓存到cache
 *
 *  @param obj      需要缓存的数据
 *  @param filePath 路径
 *
 *  @return
 */
+ (BOOL)saveCacheToFile:(id)obj filePath:(NSString *)filePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    cachesDirectory = [cachesDirectory stringByAppendingPathComponent:filePath];
    
    if ([obj isKindOfClass:[NSArray class]])        //写入的是数组类
    {
        return [(NSArray *)obj writeToFile:cachesDirectory atomically:YES];
    }
    else if ([obj isKindOfClass:[NSString class]])  //写入的是字符串
    {
        return [(NSString *)obj writeToFile:cachesDirectory
                                 atomically:YES
                                   encoding:NSUTF8StringEncoding
                                      error:nil];
    }
    else if ([obj isKindOfClass:[NSData class]])    //写入的是数据
    {
        return [(NSData *)obj writeToFile:cachesDirectory atomically:YES];
    }
    else if ([obj isKindOfClass:[NSDictionary class]])//写入的是字典
    {
        return [(NSDictionary *)obj writeToFile:cachesDirectory atomically:YES];
    }
    
    return NO;
}

/**
 *  @desc 计算时间间隔
 *
 *  @param currentTime
 *  @param compareDate
 *
 *  @return
 */
+ (NSString *)compareCurrentTime:(NSDate *)currentTime compareDate:(NSDate *)compareDate
{
    NSTimeInterval timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result = nil;
    if (timeInterval < 60) {
        return [NSString stringWithFormat:@"刚刚"];
    }
    else if ((temp = timeInterval/60) < 60){
        return [NSString stringWithFormat:@"%ld分前",temp];
    }
    else if ((temp = temp/60) < 24){
        return [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if ((temp = temp/24) < 30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    else if ((temp = temp/30) < 12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else
    {
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return result;
}



/**
 *  @desc 滚动视图内容截图
 *
 *  @return contentImg
 */
+ (UIImage *)contentViewCapture:(UIScrollView *)contentView
{
    UIScrollView *scrollView = contentView;
    UIGraphicsBeginImageContext(scrollView.contentSize);
    CGPoint savedContentOffSet = scrollView.contentOffset;
    CGRect savedFrame = scrollView.frame;
    scrollView.contentOffset = CGPointZero;
    scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
    [scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *contentImg = UIGraphicsGetImageFromCurrentImageContext();
    scrollView.contentOffset = savedContentOffSet;
    scrollView.frame = savedFrame;
    UIGraphicsEndImageContext();
    return contentImg;
}

/**
 *  @desc HeaderView 截图
 *
 *  @return headerImg
 */
+ (UIImage *)headerViewCapture:(CGSize)size
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *headerImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return headerImg;
}

/**
 *  @desc 拼接图片
 *
 *  @param imageOne
 *  @param imageTwo
 *
 *  @return 拼接后的图片resultImage
 */
//+ (UIImage *)addImageFirst:(UIImage *)imageOne toImageSecond:(UIImage *)imageTwo
//{
//    CGFloat width = MAX(imageOne.size.width, imageTwo.size.width);
//    //二维码图片
//    UIImage *qrcodeImg = [[self class] publicShareImage];
//    CGSize size = CGSizeMake(width, imageOne.size.height + imageTwo.size.height + qrcodeImg.size.height);
//    //背景图片
//    UIImage *bgImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg" ofType:@"png"]];
//    
//    //画图
//    UIGraphicsBeginImageContext(size);
//    [bgImg drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    [imageOne drawInRect:CGRectMake((width - imageOne.size.width)/2, -20, imageOne.size.width, imageOne.size.height)];
//    [imageTwo drawInRect:CGRectMake((width - imageTwo.size.width)/2, imageOne.size.height - 20, imageTwo.size.width, imageTwo.size.height)];
//    [qrcodeImg drawInRect:CGRectMake((width - qrcodeImg.size.width)/2, imageOne.size.height + imageTwo.size.height - 10, qrcodeImg.size.width, qrcodeImg.size.height)];
//    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return resultImage;
//}


/**
 *  @desc 设置字体
 *
 *  @param string
 *  @param range
 *  @param textColor
 *
 *  @return
 */
+ (id)editAttributedString:(NSString *)string range:(NSRange)range textColor:(id)textColor
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    
    return attributedString;
}

/******************************************************
 ** 社缘项目
 ******************************************************/
/**
 *  @desc 给图片添加圆角和阴影
 *
 *  @param imageView 需要改变的imageView
 */
+ (void)radiusImageView:(UIImageView *)imageView radius:(float)radius
{
    UIImage *img = imageView.image;
    UIImage *roundImg = [img roundedRectWithImageView:imageView radius:radius cornerMask:UIImageRoundedCornerBottomLeft|UIImageRoundedCornerBottomRight|UIImageRoundedCornerTopLeft|UIImageRoundedCornerTopRight];
    imageView.image = roundImg;
    CALayer *layer = imageView.layer;
    layer.shadowColor = [UIColor darkGrayColor].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 1;
}

/**
 *  @desc 计算字符宽度
 *
 *  @param string
 *  @param rectSize
 *  @param fontSize
 *
 *  @return
 */
+ (CGFloat)getWidthOfString:(NSString *)string withSize:(CGSize)rectSize fontSize:(UIFont *)fontSize{
    NSDictionary *attribute = @{NSFontAttributeName:fontSize};
    CGSize size = [string boundingRectWithSize:rectSize options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return size.width;
}

@end
