//
//  WGSliderMenu.h
//  Homels
//
//  Created by 鑫易 on 14/12/24.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WGSliderMenuDelegate <NSObject>

@optional
- (void)sliderMenuSelectedItemIndex:(NSUInteger)selectedIndex;

@end

@interface WGSliderMenu : UIView
{
    CGFloat _itemWidth;
    CGFloat _itemHeight;
}

@property (nonatomic) NSUInteger selectedIndex;
@property (nonatomic) NSUInteger itemCount;
@property (nonatomic,strong) NSArray *items;
@property (nonatomic, assign) id<WGSliderMenuDelegate>delegate;

- (id)initWithWGSliderMenuWithFrame:(CGRect)frame menuItems:(NSArray *)menuItems delegate:(id<WGSliderMenuDelegate>)delegate;

@end
