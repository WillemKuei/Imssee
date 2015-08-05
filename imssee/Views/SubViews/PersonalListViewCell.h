//
//  PersonalTableViewCell.h
//  imssee
//
//  Created by app001.cn on 15-2-6.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHBadgeImage.h"

@interface PersonalListViewCell : UITableViewCell
{
    CGFloat _lableWidth;
}
@property (strong, nonatomic) NSString *badgeValue;
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *titleLable;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) SHBadgeImage *badgeImage;
@property (strong, nonatomic) NSArray *sheQuImgArray;
@property (strong, nonatomic) NSArray *fenXiangImgArray;
@property (strong, nonatomic) NSString *tiXingText;
@property (strong, nonatomic) NSArray *toolsArray;
@property (assign, nonatomic) id delegae;

@end

@protocol PersonalListViewCellDelegate <NSObject>

@optional

- (void)PersonalListViewCell:(PersonalListViewCell *)cell didSelectToolsWithIndex:(NSInteger)index;
- (void)PersonalListViewCell:(PersonalListViewCell *)cell didSelectSheQuWithIndex:(NSInteger)index;
- (void)PersonalListViewCell:(PersonalListViewCell *)cell didSelectFenXiangWithIndex:(NSInteger)index;

@end
