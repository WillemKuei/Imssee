//
//  NewsMenuListView.m
//  imssee
//
//  Created by 鑫易 on 15/2/2.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "NewsMenuListView.h"
#define MenuItem_Tag 2000

@implementation NewsMenuListView

@synthesize menuScro = _menuScro;

- (instancetype)initWithFrame:(CGRect)frame menus:(NSArray *)menus delegate:(id<NewsMenuDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.menus = menus;
        self.userInteractionEnabled = YES;
        self.selectedIndex = MenuItem_Tag;
        self.delegate = delegate;
        [self loadMenuList];
    }
    return self;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex + MenuItem_Tag;
    UIButton *selItem = (UIButton *)[_menuScro viewWithTag:_selectedIndex];
    selItem.selected = YES;
}

#define MenuItem_Width_Min 80.0
#define MenuItem_Height 44.0

- (void)loadMenuList
{
    _menuScro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 3, self.frame.size.width, MenuItem_Height)];
    _menuScro.showsHorizontalScrollIndicator = NO;
    _menuScro.showsVerticalScrollIndicator = NO;
    CGFloat menuItem_width = self.frame.size.width/self.menus.count;
    if (menuItem_width <= 80.0f) {
        menuItem_width = MenuItem_Width_Min;
    }
    self.menuItemWidth = menuItem_width;
    [_menuScro setContentSize:CGSizeMake(menuItem_width * self.menus.count, MenuItem_Height)];
    for (int i = 0; i < self.menus.count; i++) {
        UIButton *itemBtn = [self menuItem:i menuItemWidth:menuItem_width];
        [_menuScro addSubview:itemBtn];
    }
    [self addSubview:_menuScro];
}

- (UIButton *)menuItem:(NSUInteger)index menuItemWidth:(CGFloat)menuItemWidth
{
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    itemBtn.tag = index + MenuItem_Tag;
    [itemBtn setBackgroundColor:[UIColor whiteColor]];
    [itemBtn setFrame:CGRectMake(menuItemWidth * index, 0, menuItemWidth, MenuItem_Height)];
    itemBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [itemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [itemBtn setTitleColor:PinkColor forState:UIControlStateSelected];
    [itemBtn setTitle:self.menus[index] forState:UIControlStateNormal];
    [itemBtn addTarget:self action:@selector(menuItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (index < self.menus.count - 1) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(menuItemWidth - 1.5, 0, 1.5, MenuItem_Height)];
        lineView.backgroundColor = [UIColor colorWithRed:207.f/255.f green:207.f/255.f blue:207.f/255.f alpha:1];
        [itemBtn addSubview:lineView];
        lineView = nil;
    }
    
    return itemBtn;
}

- (void)menuItemClick:(UIButton *)sender
{
    [self.delegate menuItemClick:self didSelectedIndex:sender.tag - MenuItem_Tag];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
