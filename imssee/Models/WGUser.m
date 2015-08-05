//
//  WGUser.m
//  imssee
//
//  Created by app001.cn on 15-2-12.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "WGUser.h"

@implementation WGUser
- (id)initWithDictionary:(NSDictionary *)params
{
    self = [super init];
    if (self)
    {
        self.phoneNumber = [NSString stringWithFormat:@"%@",params[@"phoneNumber"]];
        self.photo = [NSString stringWithFormat:@"%@",params[@"photo"]];
        self.pmId = [[self checkIsNotNull:params[@"pmId"]] longValue];
        self.position = [NSString stringWithFormat:@"%@",params[@"position"]];
        self.remark = [NSString stringWithFormat:@"%@",params[@"remark"]];
        self.sequemce = [[self checkIsNotNull:params[@"sequemce"]] longValue];
        self.userId = [[self checkIsNotNull:params[@"userId"]] longValue];
        self.userName = [NSString stringWithFormat:@"%@",params[@"userName"]];
        self.ownerId = [[self checkIsNotNull:params[@"ownerId"]] longValue];
    }
    return self;
}

- (id)checkIsNotNull:(id)sender
{
    id returnData = [GlobalFunction checkIsNotNull:sender]?sender:nil;
    return returnData;
}

@end
