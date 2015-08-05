//
//  PersonalPublishList.h
//  imssee
//
//  Created by 鑫易 on 15/1/30.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@class SWTableViewCell;
@class HSList;

typedef enum {
    kCellStateCenter,
    kCellStateLeft,
    kCellStateRight
} SWCellState;

@protocol SWTableViewCellDelegate <NSObject>

@optional
- (void)swippableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index;
- (void)swippableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state;
- (void)swippableTableViewCellBeginDragging:(SWTableViewCell *)cell;
- (void)swippableTableViewCellDidPressed:(SWTableViewCell *)cell;

@end

@interface SWTableViewCell : UITableViewCell
@property (nonatomic, weak) UIScrollView *cellScrollView;

@property (nonatomic, strong) NSArray *leftUtilityButtons;
@property (nonatomic, strong) NSArray *rightUtilityButtons;
@property (nonatomic) id <SWTableViewCellDelegate> delegate;

//edit by WillemKuei 2015-02-13
@property (nonatomic, strong) HSList *HSListModel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier containingTableView:(UITableView *)containingTableView  rightUtilityButtons:(NSArray *)rightUtilityButtons;

- (void)setBackgroundColor:(UIColor *)backgroundColor;
- (void)hideUtilityButtonsAnimated:(BOOL)animated;

@end

@interface NSMutableArray (SWUtilityButtons)

- (void)addUtilityButtonWithColor:(UIColor *)color title:(NSString *)title;
- (void)addUtilityButtonWithColor:(UIColor *)color icon:(UIImage *)icon;

@end
