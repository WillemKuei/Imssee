//
//  HttpRequest.h
//  Homels
//
//  Created by 鑫易 on 14/12/24.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

/**
 *  @desc 本类主要用于封装项目中所有请求数据的方法，数据在此处理然后返回到页面
 */
#import <Foundation/Foundation.h>

@interface HttpRequest : NSObject

/**
 *  @desc 单例生成HttpRequest对象
 */
+(HttpRequest *)sharedInstance;

/**
 *  @desc 穗社区新闻
 */
- (void)communityNewsListWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure;

/**
 *  @desc 个人发表列表
 */
- (void)personalPublishNewsListWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure;

/**
 *  @desc 个人发表news删除
 */
- (void)deletePersonalPublishNewsWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure;

/**
 *  @desc 个人发表news撤回
 */
- (void)reCallPersonalPublishNewsWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure;

/**
 *  @desc 广州新闻列表
 */
- (void)cityNewsListWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure;

/**
 *  @desc 国际新闻列表
 */
- (void)internationalNewsListWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure;


/**
 *  @desc 个人发表编辑
 */
- (void)publishNewsWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure;

/**
 *  @desc 上传图片(一张张的上传)
 */
- (void)uploadImageWithImage:(UIImage *)image completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure;

/**
 *  @desc 物管数据:常用电话，物管人员
 */
- (void)wuGuanDataWithIndex:(NSInteger)index Params:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure;

/**
 *  @desc 物管数据:物管介绍，收费标准
 */
- (void)wuGuanWebDataWithIndex:(NSInteger)index Params:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure;

/**
 *  @desc 物管保存编辑
 */
- (void)wuGuanMessageSaveWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure;

/**
 *  @desc 业主委员会：成员
 */
- (void)yeZhuWeiPersonalDataWithIndex:(NSInteger)index Params:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure;

/**
 *  @desc 业主委员会：介绍
 */
- (void)yeZhuWeiIntrduceDataWithIndex:(NSInteger)index Params:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure;

/**
 *  @desc 居委/街道：介绍
 */
- (void)juWeiIntrduceDataWithIndex:(NSInteger)index Params:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure;

/**
 *  @desc 居委、街道：常用电话
 */
- (void)juWeiPhoneDataWithIndex:(NSInteger)index Params:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure;


/**
 *  @desc 获取个人信息
 */
- (void)userInfoDataWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure;


/**
 *  @desc 获取评论列表
 */
- (void)commentListDataWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure;

/**
 *  @desc 发表评论
 */
- (void)submitCommentWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure;
@end
