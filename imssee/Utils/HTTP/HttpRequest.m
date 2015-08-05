//
//  HttpRequest.m
//  Homels
//
//  Created by 鑫易 on 14/12/24.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

#import "HttpRequest.h"

#define URL_PATH(Request_HTTP,Sub_URL) [NSString stringWithFormat:@"%@%@",Request_HTTP,Sub_URL]

@implementation HttpRequest

/**
 *  @desc 单例生成HttpRequest对象
 */
+(HttpRequest *)sharedInstance
{
    static HttpRequest *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

/**
 *  @desc 穗社区新闻
 */
- (void)communityNewsListWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:URL_PATH(Request_HTTP, SuiSheQu_URL)
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (success) {
                  success(responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (failure) {
                  failure(error,@"请求失败");
              }
          }];
}

/**
 *  @desc 我的社区新闻
 */
- (void)MyCommunityNewsListWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:URL_PATH(Request_HTTP, MyCommunity_URL)
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (success) {
                  success(responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (failure) {
                  failure(error,@"请求失败");
              }
          }];
}

/**
 *  @desc 个人发表列表
 */
- (void)personalPublishNewsListWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST: URL_PATH(Request_HTTP, PersonPublishNewsList_URL)
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (success) {
                  success(responseObject);
                  NSLog(@"%@",responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (failure) {
                  failure(error,@"请求失败");
              }
          }];
}

/**
 *  @desc 个人发表news删除
 */
- (void)deletePersonalPublishNewsWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:URL_PATH(Request_HTTP, PersonPublishNewsDelete_URL)
      parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if (success) {
                 NSLog(@"%@",responseObject[@"result"]);
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (failure) {
                 failure(error,@"请求失败");
             }
         }];
}

/**
 *  @desc 个人发表news撤回
 */
- (void)reCallPersonalPublishNewsWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:URL_PATH(Request_HTTP, PersonPublishNewsCancel_URL)
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (success) {
                  NSString *data =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                  NSLog(@"%@",data);
                  success(data);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (failure) {
                  failure(error,@"请求失败");
                 
              }
          }];
    
}

/**
 *  @desc 城市新闻列表
 */
- (void)cityNewsListWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST: URL_PATH(Request_HTTP, CityNewsList_URL)
      parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if (success) {
                 success(responseObject);
                 NSLog(@"%@",responseObject);
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (failure) {
                 failure(error,@"请求失败");
             }
         }];
}

/**
 *  @desc 国际新闻列表
 */
- (void)internationalNewsListWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST: URL_PATH(Request_HTTP, InternationalNewsList_URL)
      parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if (success) {
                 success(responseObject);
                 NSLog(@"%@",responseObject);
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (failure) {
                 failure(error,@"请求失败");
             }
         }];
}


/**
 *  @desc 个人发表编辑
 */
- (void)publishNewsWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:URL_PATH(Request_HTTP, PublishNews_URL)
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (success) {
                  success(responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (failure) {
                  failure(error,@"请求失败");
              }
          }];
}

/**
 *  @desc 上传图片(一张张的上传)
 */
- (void)uploadImageWithImage:(UIImage *)image completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure
{
    __block AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://192.168.1.100:8080/mobile"]];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30.0;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:@"upload.jspx" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imageData = UIImagePNGRepresentation(image);
        [formData appendPartWithFileData:imageData name:@"upfile" fileName:@"avatar.png" mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
        manager = nil;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error,@"图片上传失败");
        }
    }];
}

/**
 *  @desc 物管数据:物管介绍，收费标准
 */
- (void)wuGuanWebDataWithIndex:(NSInteger)index Params:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure
{
    NSString *url = nil;
    if (index == 0) {
        url = WuGuanChargeStandardList_URL;
    }else{
        url = WuGuanIntroduceList_URL;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST: URL_PATH(Request_HTTP, url)
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (success) {
                  success(responseObject);
                  NSLog(@"%@",responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (failure) {
                  failure(error,@"请求失败");
              }
          }];
}

/**
 *  @desc 物管数据:常用电话，物管人员
 */
- (void)wuGuanDataWithIndex:(NSInteger)index Params:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure
{
    NSString *url = nil;
    if (index == 0) {
        url = WuGuanCommonUsePhoneList_URL;
    }else{
        url = WuGuanPeopleInfoList_URL;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST: URL_PATH(Request_HTTP, url)
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (success) {
                  success(responseObject);
                  NSLog(@"%@",responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (failure) {
                  failure(error,@"请求失败");
              }
          }];
}

/**
 *  @desc 物管保存编辑
 */
- (void)wuGuanMessageSaveWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:URL_PATH(Request_HTTP, WuGuanMessageSave_URL)
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (success) {
                  success(responseObject);
                  NSLog(@"%@",responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (failure) {
                  failure(error,@"请求失败");
              }
          }];
}


/**
 *  @desc 业主委员会：成员
 */
- (void)yeZhuWeiPersonalDataWithIndex:(NSInteger)index Params:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST: URL_PATH(Request_HTTP, YeZhuWeiOwnerUserList_URL)
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (success) {
                  success(responseObject);
                  NSLog(@"%@",responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (failure) {
                  failure(error,@"请求失败");
              }
          }];
}

/**
 *  @desc 业主委员会：介绍
 */
- (void)yeZhuWeiIntrduceDataWithIndex:(NSInteger)index Params:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST: URL_PATH(Request_HTTP, YeZhuWeiIntroduceList_URL)
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (success) {
                  success(responseObject);
                  NSLog(@"%@",responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (failure) {
                  failure(error,@"请求失败");
              }
          }];
}

/**
 *  @desc 居委、街道：常用电话
 */
- (void)juWeiPhoneDataWithIndex:(NSInteger)index Params:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST: URL_PATH(Request_HTTP, JuWeiCommonUsePhoneList_URL)
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (success) {
                  success(responseObject);
                  NSLog(@"%@",responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (failure) {
                  failure(error,@"请求失败");
              }
          }];
}

/**
 *  @desc 居委/街道：介绍，办事指南
 */
- (void)juWeiIntrduceDataWithIndex:(NSInteger)index Params:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure
{
    NSString *url = nil;
    if (index == 0) {
        url = JuWeiIntroduceList_URL;
    }else{
        url = JuWeiGuideList_URL;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST: URL_PATH(Request_HTTP, url)
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (success) {
                  success(responseObject);
                  NSLog(@"%@",responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (failure) {
                  failure(error,@"请求失败");
              }
          }];
}

/**
 *  @desc 获取个人信息
 */
- (void)userInfoDataWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:URL_PATH(Request_HTTP, UserInfo_URL)
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (success) {
                  success(responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (failure) {
                  failure(error,@"请求失败");
              }
          }];
}

/**
 *  @desc 获取评论列表
 */
- (void)commentListDataWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:URL_PATH(Request_HTTP, CommentList_URL)
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (success) {
                  success(responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (failure) {
                  failure(error,@"请求失败");
              }
          }];
}

/**
 *  @desc 发表评论
 */
- (void)submitCommentWithParams:(NSDictionary *)params completionBlock:(void(^)(id result))success failureBlock:(void(^)(NSError *error, NSString *responseStr))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:URL_PATH(Request_HTTP, CommentSave_URL)
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (success) {
                  success(responseObject);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (failure) {
                  failure(error,@"请求失败");
              }
          }];
}

@end
