//
//  DropdownBox.m
//  imssee
//
//  Created by 鑫易 on 14/12/31.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

#import "WGDropdownBox.h"
#import "TableViewWithBlock.h"
#import "UITableView+DelegateBlocks.h"
#import "UITableView+DataSourceBlocks.h"

#define kBoxDuration 0.3

@implementation WGDropdownBox

@synthesize WGDropdownBoxRows = _WGDropdownBoxRows;
@synthesize WGDropdownBoxTableViewCell = _WGDropdownBoxTableViewCell;
@synthesize WGDropdownBoxDidSelected = _WGDropdownBoxDidSelected;

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addTarget:self action:@selector(loadWGDropdownBox) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self addTarget:self action:@selector(loadWGDropdownBox) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)initWGDropdownBoxRows:(WGDropdownBoxRows)WGDropdownBoxRows tableViewCell:(WGDropdownBoxTableViewCell)WGDropdownBoxTableViewCell didSelectedTableView:(WGDropdownBoxDidSelected)WGDropdownBoxDidSelected
{
    if (WGDropdownBoxRows) {
        self.WGDropdownBoxRows = WGDropdownBoxRows;
    }
    if (WGDropdownBoxTableViewCell) {
        self.WGDropdownBoxTableViewCell = WGDropdownBoxTableViewCell;
    }
    if (WGDropdownBoxDidSelected) {
        self.WGDropdownBoxDidSelected = WGDropdownBoxDidSelected;
    }
}

- (void)loadWGDropdownBox
{
    if (self.tableView == nil) {
        CGFloat origin_x = self.frame.origin.x;
        CGFloat origin_y = self.frame.origin.y + self.frame.size.height + 2;
        CGFloat width = self.frame.size.width;
        CGFloat height = 0;
        TableViewWithBlock *tableView = [[TableViewWithBlock alloc] initWithFrame:CGRectMake(origin_x, origin_y, width, height) style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor orangeColor];
        [tableView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [tableView.layer setBorderWidth:2];
//        [tableView onHeightForRowAtIndexPath:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
//            return 30;
//        }];
        [tableView initTableViewDataSourceAndDelegate:^NSInteger(UITableView *tableView, NSInteger section) {
            if (self.WGDropdownBoxRows) {
                return self.WGDropdownBoxRows(tableView,section);
            }
            return 0;
        } setCellForIndexPathBlock:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            if (self.WGDropdownBoxTableViewCell) {
                return self.WGDropdownBoxTableViewCell(tableView, indexPath);
            }
            return nil;
        } setDidSelectRowBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
            if (self.WGDropdownBoxDidSelected) {
                self.WGDropdownBoxDidSelected(tableView,indexPath);
            }
        }];
        
        UIView *superView = self.superview;
        self.tableView = tableView;
        [superView addSubview:self.tableView];
        
        __weak WGDropdownBox *blockSelf = self;
        superView.tapAction = ^(UITapGestureRecognizer *tap){
            if (blockSelf.opened) {
                blockSelf.opened = NO;
                [blockSelf expandOrCloseDropdownBox:blockSelf.opened];
            }
        };
    }
    
    self.opened = !_opened;
    [self expandOrCloseDropdownBox:self.opened];
}

- (void)expandOrCloseDropdownBox:(BOOL)opened
{
    __block CGRect rect = self.tableView.frame;
    __block BOOL isOpened = opened;
    __block TableViewWithBlock *tableView = self.tableView;
    [UIView animateWithDuration:kBoxDuration
                     animations:^{
                         rect.size.height += (isOpened?100:-100);
                         tableView.frame = rect;
                     } completion:^(BOOL finished) {
                         rect.size.height = (isOpened?100:0);
                         tableView.frame = rect;
                     }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
