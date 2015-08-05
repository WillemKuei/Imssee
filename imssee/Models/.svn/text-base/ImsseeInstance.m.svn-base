//
//  imsseeInstance.m
//  imssee
//
//  Created by imsseeios3 on 15/2/28.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "imsseeInstance.h"

@implementation ImsseeInstance

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static ImsseeInstance *sigleton;
    dispatch_once(&onceToken, ^{
        sigleton = [[ImsseeInstance alloc] init];
    });
    return sigleton;
}

@end
