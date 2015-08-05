//
//  BasicPlugin.h
//  imssee
//
//  Created by 鑫易 on 15/1/13.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

/**
 *  @desc 该类主要封装Plugin
 */

#import "CDVPlugin.h"

@interface BasicPlugin : CDVPlugin

@property (nonatomic, copy) NSString * callbackID;      //javaScript返回的callbackID,在PluginResult进行数据的返回时需要用到

/******************************************************
 ** 功能:      弹出提示信息
 ** 参数:      三个字符串，依次为提示内容，提示标题，提示按钮名称
 ** 返回:         无
 ******************************************************/
- (void)alert:(CDVInvokedUrlCommand *)command;

/******************************************************
 ** 功能:      跳转页面
 ** 参数:      三个字符串，依次为提示内容，提示标题，提示按钮名称
 ** 返回:         无
 ******************************************************/
- (void)goPage:(CDVInvokedUrlCommand *)command;

/******************************************************
 ** 功能:      联网请求数据
 ** 参数:      urlString  ---  url
 **           postData   ---  post数据(此处用Dic)
 ** 返回:      resultData --- 服务器返回的数据
 ******************************************************/
- (void)request:(CDVInvokedUrlCommand *)command;

/******************************************************
 ** 功能:      返回参数在HTML5页面显示
 ** 参数:
 ** 返回:
 ******************************************************/
- (void)getTheMessage:(CDVInvokedUrlCommand *)command;

- (void) print:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

@end
