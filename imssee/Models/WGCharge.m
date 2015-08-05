//
//  WGCharge.m
//  imssee
//
//  Created by app001.cn on 15-2-12.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "WGCharge.h"

@implementation WGCharge
- (id)initWithDictionary:(NSDictionary *)params
{
    self = [super init];
    if (self)
    {
        self.pmContext = [NSString stringWithFormat:@"%@",params[@"pmContext"]];
        self.charge_id = [[self checkIsNotNull:params[@"id"]] longValue];
        self.pmId = [[self checkIsNotNull:params[@"pmId"]] longValue];
        self.pmItem = [NSString stringWithFormat:@"%@",params[@"pmItem"]];
        self.price = [[self checkIsNotNull:params[@"price"]] doubleValue];
    }
    return self;
}

- (id)checkIsNotNull:(id)sender
{
    id returnData = [GlobalFunction checkIsNotNull:sender]?sender:nil;
    return returnData;
}

@end
