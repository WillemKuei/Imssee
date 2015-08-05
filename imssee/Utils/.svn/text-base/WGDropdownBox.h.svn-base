//
//  DropdownBox.h
//  imssee
//
//  Created by 鑫易 on 14/12/31.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

/**
 *  @desc 主要用于封装下拉框
 */

#import <UIKit/UIKit.h>

typedef NSInteger(^WGDropdownBoxRows)(UITableView *tableView, NSInteger sections);
typedef UITableViewCell *(^WGDropdownBoxTableViewCell)(UITableView *tableView, NSIndexPath *indexPath);
typedef void (^WGDropdownBoxDidSelected)(UITableView *tableView, NSIndexPath *indexPath);

@class TableViewWithBlock;

@interface WGDropdownBox : UIButton
{
    WGDropdownBoxRows _WGDropdownBoxRows;
    WGDropdownBoxTableViewCell _WGDropdownBoxTableViewCell;
    WGDropdownBoxDidSelected _WGDropdownBoxDidSelected;
}

@property (nonatomic, strong) TableViewWithBlock        *tableView;
@property (nonatomic, strong) NSArray                   *dataSource;
@property (nonatomic, strong) NSArray                   *values;
@property (nonatomic, strong) NSString                  *boxTitle;
@property (nonatomic, strong) NSString                  *boxValue;
@property (nonatomic, assign) NSInteger                 selectedIndex;
@property (nonatomic, copy)   WGDropdownBoxRows         WGDropdownBoxRows;
@property (nonatomic, copy)   WGDropdownBoxTableViewCell WGDropdownBoxTableViewCell;
@property (nonatomic, copy)   WGDropdownBoxDidSelected WGDropdownBoxDidSelected;
@property (nonatomic, getter=isOpened) BOOL opened;

- (void)initWGDropdownBoxRows:(WGDropdownBoxRows)WGDropdownBoxRows
                tableViewCell:(WGDropdownBoxTableViewCell)WGDropdownBoxTableViewCell
         didSelectedTableView:(WGDropdownBoxDidSelected)WGDropdownBoxDidSelected;

@end
