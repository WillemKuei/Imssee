//
//  UIImage+Utility.h
//  imssee
//
//  Created by 鑫易 on 15/2/4.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    UIImageRoundedCornerTopLeft = 1,
    UIImageRoundedCornerTopRight = 1 << 1,
    UIImageRoundedCornerBottomRight = 1 << 2,
    UIImageRoundedCornerBottomLeft = 1 << 3
} UIImageRoundedCorner;

@interface UIImage (Utility)

- (UIImage *)roundedRectWithImageView:(UIImageView *)imageView radius:(float)radius cornerMask:(UIImageRoundedCorner)cornerMask;

@end
