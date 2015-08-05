//
//  WGIntrduce.m
//  imssee
//
//  Created by app001.cn on 15-2-12.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "WGIntrduce.h"

@implementation WGIntrduce
- (id)initWithDictionary:(NSDictionary *)params
{
    self = [super init];
    if (self)
    {
        self.intro = [NSString stringWithFormat:@"%@",params[@"intro"]];
        self.pmId = [[self checkIsNotNull:params[@"pmId"]] longValue];
        self.sheyuanId = [[self checkIsNotNull:params[@"pmId"]] longValue];
        self.pmName = [NSString stringWithFormat:@"%@",params[@"pmName"]];
        self.remark = [NSString stringWithFormat:@"%@",params[@"remark"]];

        self.ownerId = [[self checkIsNotNull:params[@"ownerId"]] longValue];
        self.ownerName = [NSString stringWithFormat:@"%@",params[@"ownerName"]];
        
        self.streetId = [[self checkIsNotNull:params[@"streetId"]]longValue];
        self.streetName = [NSString stringWithFormat:@"%@",params[@"streetName"]];
    }
    return self;
}

- (id)checkIsNotNull:(id)sender
{
    id returnData = [GlobalFunction checkIsNotNull:sender]?sender:nil;
    return returnData;
}

@end
