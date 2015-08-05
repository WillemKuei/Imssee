//
//  CommentModel.m
//  imssee
//
//  Created by imsseeios3 on 15/3/2.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "CommentModel.h"

#define kCommentId @"commentId"
#define kContext @"context"
#define kCreateTime @"creattime"
#define kMemberId @"memberId"
#define kNewsId @"newsId"
#define kState @"state"
#define kUser @"user"

@implementation CommentModel

- (instancetype)initCommentModelWithParams:(NSDictionary *)params
{
    self = [super init];
    if (self) {
        self.commentId = [[self checkIsNotNull:params[kCommentId]] longValue];
        self.context = params[kContext];
        self.createTime = params[kCreateTime];
        self.memberId = [[self checkIsNotNull:params[kCommentId]] longValue];
        self.newsId = [[self checkIsNotNull:params[kNewsId]] longValue];
        self.state = [[self checkIsNotNull:params[kState]] longValue];
        UserInfo *userInfo = [[UserInfo alloc] initUserInfoWithParams:params[kUser]];
        self.userInfo = userInfo;
    }
    return self;
}

- (id)checkIsNotNull:(id)sender
{
    id returnData = [GlobalFunction checkIsNotNull:sender]?sender:nil;
    return returnData;
}

@end
