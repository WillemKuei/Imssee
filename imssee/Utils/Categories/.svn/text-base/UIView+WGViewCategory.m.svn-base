//
//  UIView+WGViewCategory.m
//  Homels
//
//  Created by 鑫易 on 14/12/24.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

#import "UIView+WGViewCategory.h"
#import <objc/runtime.h>

#define WGTapAction @"WGTapAction"

@implementation UIView (WGViewCategory)

static char OperationKey;

@dynamic tapAction;

- (void)removeHandlerForEvent
{
    NSMutableDictionary *operations = (NSMutableDictionary *)objc_getAssociatedObject(self, &OperationKey);
    
    if (operations == nil)
    {
        operations = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &OperationKey, operations, OBJC_ASSOCIATION_RETAIN);
    }
    [operations removeObjectForKey:WGTapAction];
}

- (void)setTapAction:(void (^)(UITapGestureRecognizer *))tapAction
{
    NSMutableDictionary *operations = (NSMutableDictionary *)objc_getAssociatedObject(self, &OperationKey);
    if (operations == nil)
    {
        operations = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &OperationKey, operations, OBJC_ASSOCIATION_RETAIN);
    }
    [operations setObject:tapAction forKey:WGTapAction];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOperation:)];
    [self addGestureRecognizer:tap];
    tap = nil;
}

- (void)tapOperation:(UITapGestureRecognizer *)tap
{
    NSMutableDictionary *operations = (NSMutableDictionary*)objc_getAssociatedObject(self, &OperationKey);
    if (operations == nil)
    {
        return;
    }
    
    void(^block)(id sender) = [operations objectForKey:WGTapAction];
    __block UITapGestureRecognizer *blockTap = tap;
    if (block) {
        block(blockTap);
    }
}

@end
