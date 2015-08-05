//
//  SubMenuListView.m
//  imssee
//
//  Created by imsseeios3 on 15/2/11.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "SubMenuListView.h"
#import "SubMenuListCell.h"

@implementation SubMenuListView

- (instancetype)initSubMenuListViewWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self loadSubMenuListView];
    }
    return self;
}

- (void)loadSubMenuListView
{
    self.delegate = self;
    self.dataSource = self;
    self.sectionFooterHeight = 1.0f;
    self.tableFooterView = [[UIView alloc] init];
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
//    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self setSeparatorInset:UIEdgeInsetsZero];
//    } else if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self setLayoutMargins:UIEdgeInsetsZero];
//    }
}

- (void)reloadMenuData
{
    [self reloadData];
    NSArray *array = [self indexPathsForVisibleRows];
    for (int i = 0; i < array.count; i++) {
        NSIndexPath *indexPath = array[i];
        UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
        [self bouncesAnimationStart:cell];
    }
}

#define ICON_WIDTH 50.0
#define ICON_HEIGHT 50.0
- (void)bouncesAnimationStart:(UITableViewCell *)cell
{
    SubMenuListCell *menuCell = (SubMenuListCell *)cell;
    UIImageView *iconImage = menuCell.iconImage;
    for (int i = 1; i <= 3; i++) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
        [animation setFromValue:[NSValue valueWithCGSize:CGSizeMake(i==1?1.0:(ICON_WIDTH+(i==2?6:2)), i==1?1.0:(ICON_HEIGHT+(i==2?6:2)))]];
        [animation setToValue:[NSValue valueWithCGSize:CGSizeMake(ICON_WIDTH + (i==3?-(6/i):6/i), ICON_HEIGHT + (i==3?(-6/i):6/i))]];
        [animation setDuration:i==1?0.25:0.1];
        if (i != 1) {
            CFTimeInterval currentTime = [iconImage.layer convertTime:CACurrentMediaTime() fromLayer:nil];
            animation.beginTime = currentTime + (i-1)*0.2;
        }
        [iconImage.layer addAnimation:animation forKey:nil];
        
        animation = nil;
    }
    
}

#pragma mark UITableViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuDataSource subMenuListView:(SubMenuListView *)tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.menuDataSource subMenuListView:(SubMenuListView *)tableView cellForRowAtIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.menuDelegate subMenuListView:(SubMenuListView *)tableView didSelectRowAtIndexPath:indexPath];
}

@end
