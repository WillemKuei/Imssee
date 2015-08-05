//
//  PhoneList.m
//  imssee
//
//  Created by app001.cn on 15-2-12.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "PhoneList.h"

@implementation PhoneList
- (id)initWithDictionary:(NSDictionary *)params
{
    self = [super init];
    if (self)
    {
        self.deptName = [NSString stringWithFormat:@"%@",params[@"deptName"]];
        self.phoneId = [[self checkIsNotNull:params[@"phoneId"]] longValue];
        self.phoneNumber = [NSString stringWithFormat:@"%@",params[@"phoneNumber"]];
        self.pmId = [[self checkIsNotNull:params[@"pmId"]] longValue];
        self.remark = [NSString stringWithFormat:@"%@",params[@"remark"]];

        self.streetId = [[self checkIsNotNull:params[@"streetId"]] longValue];
    }
    return self;
}

- (id)checkIsNotNull:(id)sender
{
    id returnData = [GlobalFunction checkIsNotNull:sender]?sender:nil;
    return returnData;
}

@end
