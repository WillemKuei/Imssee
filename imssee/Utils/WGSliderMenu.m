//
//  WGSliderMenu.m
//  Homels
//
//  Created by 鑫易 on 14/12/24.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

#import "WGSliderMenu.h"

#define SliderView_TAG 1111
#define Item_TAG 1000

@implementation WGSliderMenu

- (id)initWithWGSliderMenuWithFrame:(CGRect)frame menuItems:(NSArray *)menuItems delegate:(id<WGSliderMenuDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        if (menuItems.count > 0) {
            self.itemCount = [menuItems count];
            self.items = menuItems;
            self.delegate = delegate;
            _itemWidth = frame.size.width/self.itemCount;
            _itemHeight = frame.size.height;
            self.selectedIndex = 0;
            self.backgroundColor = [UIColor whiteColor];
            
            [self drawSlider];
            [self drawMenuItems];
        }
    }
    return self;
}

//绘制items
- (void)drawMenuItems
{
    for (int i = 0; i < self.itemCount; i++)
    {
        UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(_itemWidth*i, 0, _itemWidth, _itemHeight)];
        itemView.layer.borderWidth = 1.f;
        itemView.layer.borderColor = [UIColor grayColor].CGColor;
        itemView.layer.masksToBounds = YES;
        itemView.layer.cornerRadius = 3.f;
        itemView.userInteractionEnabled = YES;
        itemView.tag = i;
        //title
        UILabel *itemLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _itemWidth, _itemHeight)];
        itemLab.textAlignment = NSTextAlignmentCenter;
        itemLab.textColor = (i == 0?[UIColor whiteColor]:[UIColor blackColor]);
        itemLab.text = _items[i];
        itemLab.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.35];
        itemLab.shadowOffset = CGSizeMake(0, -1.0);
        itemLab.userInteractionEnabled = YES;
        itemLab.tag = Item_TAG + i;
        [itemView addSubview:itemLab];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sliderMenuSelected:)];
        [itemView addGestureRecognizer:tap];
        [self addSubview:itemView];
    }
}

//绘制移动背景图
- (void)drawSlider
{
    UIView * sliderView = [[UIView alloc] initWithFrame:CGRectMake(_itemWidth * self.selectedIndex, 0, _itemWidth, _itemHeight)];
    sliderView.tag = SliderView_TAG;
    sliderView.backgroundColor = [UIColor orangeColor];
    [self addSubview:sliderView];
}

//点击手势响应
- (void)sliderMenuSelected:(UITapGestureRecognizer *)tap
{
    [self moveItemToIndex:tap.view.tag];
    if (self.delegate) {
        [self.delegate sliderMenuSelectedItemIndex:tap.view.tag];
    }
}

//封装滑块
-(void)moveItemToIndex:(NSUInteger)toIndex{
    self.selectedIndex = toIndex;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    UIView * sliderImageView = (UIView * )[self viewWithTag:SliderView_TAG];
    sliderImageView.frame = CGRectMake(_itemWidth*toIndex, 0, _itemWidth, _itemHeight);
    [UIView commitAnimations];
    
}

//重写setSelectedIndex
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    for (int i=0; i<_itemCount; i++) {
        UILabel * label = (UILabel *)[[self viewWithTag:i] viewWithTag:Item_TAG + i];
        
        if (i == selectedIndex) {
            label.textColor = [UIColor whiteColor];
        }else{
            label.textColor = [UIColor blackColor];
        }
    }
}

@end
