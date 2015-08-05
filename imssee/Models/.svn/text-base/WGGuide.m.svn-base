//
//  WGGuide.m
//  imssee
//
//  Created by app001.cn on 15-2-14.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "WGGuide.h"

@implementation WGGuide
- (id)initWithDictionary:(NSDictionary *)params
{
    self = [super init];
    if (self)
    {
        self.guideContext = [NSString stringWithFormat:@"%@",params[@"guideContext"]];
        self.guideId = [[self checkIsNotNull:params[@"guideId"]] longValue];
        self.guideName = [NSString stringWithFormat:@"%@",params[@"guideName"]];
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
