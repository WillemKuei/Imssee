//
//  UserInfo.m
//  imssee
//
//  Created by imsseeios3 on 15/2/28.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "UserInfo.h"

#define kHSUserBirthday @"birthday"
#define kHSUserSchool @"school"
#define kHSUserSex @"sex"
#define kHSUserIcon @"icon"
#define kHSUserImages @"images"
#define kHSUserLevelName @"levelName"
#define kHSUserWorkingtime @"workingtime"
#define kHSUserEdu @"edu"
#define kHSUserLeve @"leve"
#define kHSUserMemberid @"memberid"
#define kHSUserCommunity @"community"
#define kHSUserScId @"scId"
#define kHSUserIntr @"intr"
#define kHSUserMemberName @"memberName"
#define kHSUserIsMaster @"isMaster"
#define kHSUserNicName @"nicName"
#define kHSUserTell @"tell"
#define kHSUserAge @"age"
#define kHSUserUserName @"userName"

@implementation UserInfo

+ (instancetype)shareInstance:(NSDictionary *)params
{
    static dispatch_once_t onceToken;
    static UserInfo *singleton = nil;
    dispatch_once(&onceToken, ^{
        singleton = [[UserInfo alloc] initUserInfoWithParams:params];
    });
    return singleton;
}

- (instancetype)initUserInfoWithParams:(NSDictionary *)params
{
    self = [super init];
    if (self) {
        [self fillUserData:params];
    }
    return self;
}

- (void)fillUserData:(NSDictionary *)params
{
    self.birthDay = params[kHSUserBirthday];
    self.school = params[kHSUserSchool];
    self.sex = [[self checkIsNotNull:params[kHSUserSex]] integerValue];
    self.icon = params[kHSUserIcon];
    self.images = params[kHSUserImages];
    self.levelName = params[kHSUserLevelName];
    self.workingTime = params[kHSUserWorkingtime];
    self.education = params[kHSUserEdu];
    self.level = [[self checkIsNotNull:params[kHSUserLeve]] longValue];
    self.memberId = [[self checkIsNotNull:params[kHSUserMemberid]] longValue];
    self.community = [self checkIsNotNull:params[kHSUserCommunity]];
    self.scId = [[self checkIsNotNull:params[kHSUserScId]] longValue];
    self.intr = params[kHSUserIntr];
    self.memberName = params[kHSUserMemberName];
    self.isMaster = [[self checkIsNotNull:params[kHSUserIsMaster]] integerValue];
    self.nickName = params[kHSUserNicName];
    self.tell = params[kHSUserTell];
    self.age = [[self checkIsNotNull:params[kHSUserAge]] integerValue];
    self.userName = params[kHSUserUserName];
}

- (id)checkIsNotNull:(id)sender
{
    id returnData = [GlobalFunction checkIsNotNull:sender]?sender:nil;
    return returnData;
}

@end
