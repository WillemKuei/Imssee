//
//  CommentModel.h
//  imssee
//
//  Created by imsseeios3 on 15/3/2.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserInfo;
@interface CommentModel : NSObject

@property (nonatomic, assign) long commentId;
@property (nonatomic, copy) NSString *context;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, assign) long memberId;
@property (nonatomic, assign) long newsId;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) UserInfo *userInfo;

- (instancetype)initCommentModelWithParams:(NSDictionary *)params;

@end
