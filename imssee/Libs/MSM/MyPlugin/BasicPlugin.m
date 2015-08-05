//
//  BasicPlugin.m
//  imssee
//
//  Created by 鑫易 on 15/1/13.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "BasicPlugin.h"
#import "HSList.h"
#import "UserInfo.h"
#import "CommentViewController.h"

@implementation BasicPlugin

/******************************************************
 ** 功能:      弹出提示信息
 ** 参数:      三个字符串，依次为提示内容，提示标题，提示按钮名称
 ** 返回:         无
 ******************************************************/
- (void)alert:(CDVInvokedUrlCommand *)command
{
    // 这是classid,在下面的PluginResult进行数据的返回时,将会用到它
    self.callbackID = command.callbackId;
    
    NSArray *arguments = command.arguments;
    NSInteger argc = [arguments count];
    NSString *msg = argc > 0 ? arguments[0] : nil;
    NSString *title = argc > 1 ? arguments[1] : nil;
    NSString *btnName = argc > 2 ? arguments[2] : nil;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:btnName otherButtonTitles: nil];
    [alert show];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    if (pluginResult) {
        [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackID];
    }
}

/******************************************************
 ** 功能:      跳转页面
 ** 参数:      三个字符串，依次为提示内容，提示标题，提示按钮名称
 ** 返回:         无
 ******************************************************/
- (void)goPage:(CDVInvokedUrlCommand *)command
{
    self.callbackID = command.callbackId;
    
    NSArray *arguments = command.arguments;
    NSInteger argc = [arguments count];
    NSString *pageName = argc > 0 ? arguments[0] : nil;
    
    if ([pageName isEqualToString:@"commentList"]) {
        NSString *newsId = argc>1?arguments[1]:nil;
        NSString *title = argc>2?arguments[2]:nil;
        CommentViewController *commentVC = [[CommentViewController alloc] init];
        commentVC.newsId = newsId;
        commentVC.title = title;
        [self.viewController.navigationController pushViewController:commentVC animated:YES];
        commentVC = nil;
    }
}

/******************************************************
 ** 功能:      联网请求数据
 ** 参数:      urlString  ---  url
 **           postData   ---  post数据(此处用Dic)
 ** 返回:     resultData --- 服务器返回的数据
 ******************************************************/
- (void)request:(CDVInvokedUrlCommand *)command
{
    self.callbackID = command.callbackId;
    ImsseeInstance *imsseeInstance = [ImsseeInstance shareInstance];
     NSString *userId = [NSString stringWithFormat:@"%ld",imsseeInstance.userInfo.memberId];
    
    NSArray *arguments = command.arguments;
    NSInteger argc = [arguments count];
    NSString *urlString = argc > 0 ? arguments[0]:nil;
    NSDictionary *params = argc > 1 ? arguments[1]:nil;
    DLog(@"url=%@",urlString);
    DLog(@"params=%@",params);
    if ([urlString isEqualToString:@"newsDetail_J.jspx"]) {     //请求新闻详情
        NSString *newsId = [NSString stringWithFormat:@"%ld",imsseeInstance.HSList.newsId];
        params = @{@"newsId":newsId};
    }
    
    NSMutableDictionary *dataDic = nil;
    if (params != nil) {    //加入userId到params
        dataDic = [[NSMutableDictionary alloc] initWithDictionary:params];
        [dataDic setObject:userId forKey:@"userId"];
    }
    
    __block BasicPlugin *blockSelf = self;
    __block CDVInvokedUrlCommand *blockCommand = command;
    //AFN网络请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [WGProgressHUD showHUDAddedTo:self.viewController.view status:@""];
    [manager POST:[NSString stringWithFormat:@"%@%@",Request_HTTP,urlString] parameters:dataDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"request:%@",responseObject);
        if ([responseObject[@"ec"] integerValue] != 0) {
            [blockSelf requestDataFailed:@"请求失败" callbackID:blockCommand.callbackId];
        } else {
            [blockSelf requestDataFinished:responseObject[@"result"] callbackID:blockCommand.callbackId];
        }
        
        [WGProgressHUD dismissHUD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"Error:%@",[error localizedDescription]);
        [blockSelf requestDataFailed:[error localizedDescription] callbackID:blockCommand.callbackId];
    }];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT];
    [pluginResult setKeepCallbackAsBool:YES];
    if (pluginResult) {
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    
    dataDic = nil;
    userId = nil;
}

/******************************************************
 ** 功能:      返回参数在HTML5页面显示
 ** 参数:
 ** 返回:
 ******************************************************/
- (void)getTheMessage:(CDVInvokedUrlCommand *)command
{
    self.callbackID = command.callbackId;
    //得到Javascript端发送过来的字符串
    NSString *str_js = command.arguments[0];
    //创建要返回给js的字符串
    NSString *str_re = [NSString stringWithFormat:@"我是返回的:%@",str_js];
    //创建Plugin Result
    CDVPluginResult *pluginResult = nil;
    //返回字符串给js
    if (str_js.length > 0) {
        // Call the javascript success function
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:str_re];
        [self writeJavascript: [pluginResult toSuccessCallbackString:self.callbackID]];
    } else {
        // Call the javascript error function
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"返回的错误！"] ;
        [self writeJavascript: [pluginResult toErrorCallbackString:self.callbackID]];
    }
}

/**
 *  @desc 请求成功
 *
 *  @param responseObject 请求数据
 *  @param callbackId
 */
- (void)requestDataFinished:(id)responseObject callbackID:(NSString *)callbackId
{
    CDVPluginResult *pluginResult = nil;
    if ([responseObject isKindOfClass:[NSString class]]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:responseObject];
    } else if([responseObject isKindOfClass:[NSDictionary class]]) {
    NSDictionary *dic = [self transformCreateTimeFrom:responseObject];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dic];
    [self writeJavascript:[pluginResult toSuccessCallbackString:callbackId]];
    }
}

/**
 *  @desc 请求失败
 *
 *  @param responseObject 请求数据
 *  @param callbackId
 */
- (void)requestDataFailed:(NSString *)error callbackID:(NSString *)callbackId
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error];
    [self writeJavascript:[pluginResult toErrorCallbackString:callbackId]];
}

/**
 *  将时间戳转换成普通日期
 */
- (NSDictionary *)transformCreateTimeFrom:(id)responseObject
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
    if (dic[@"creatTime"]) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dic[@"creatTime"] longValue]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd HH:mm"];
        NSString *createTime = [formatter stringFromDate:date];
        [dic setObject:createTime forKey:@"creatTime"];
        
        date = nil;
        formatter = nil;
    }
    return dic;
}

-(void)print:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
    // 这是classid,在下面的PluginResult进行数据的返回时,将会用到它
    self.callbackID = [arguments pop];
    
    NSLog(@"Arguments:%@",arguments);
    
    // 得到Javascript端发送过来的字符串
    NSString *stringObtainedFromJavascript = [arguments objectAtIndex:0];
    
    // 创建我们要返回给js端的字符串
    NSMutableString *stringToReturn = [NSMutableString stringWithString: @"我是返回的:"];
    
    [stringToReturn appendString: stringObtainedFromJavascript];
    
    // Create Plugin Result
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: stringToReturn];
    
    NSLog(@ "%@",stringToReturn);
    
    // 检查发送过来的字符串是否等于"HelloWorld",如果不等,就以PluginResult的Error形式返回
    if ([stringObtainedFromJavascript isEqualToString:@"WillemKuei"] == YES){
        // Call the javascript success function
        [self writeJavascript: [pluginResult toSuccessCallbackString:self.callbackID]];
    } else{
        // Call the javascript error function
        [self writeJavascript: [pluginResult toErrorCallbackString:self.callbackID]];
    }
}

@end
