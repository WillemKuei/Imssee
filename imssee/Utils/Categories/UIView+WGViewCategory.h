//
//  UIView+WGViewCategory.h
//  Homels
//
//  Created by 鑫易 on 14/12/24.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WGViewCategory)

@property(nonatomic, copy) void(^tapAction)(UITapGestureRecognizer*);

- (void)removeHandlerForEvent;

@end
