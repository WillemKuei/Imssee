//
//  SuperListView.h
//  imssee
//
//  Created by app001.cn on 14-12-26.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UITableViewCell*(^tableViewBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef NSInteger(^sectionBlock)(UITableView *tableView);
typedef NSInteger(^rowsBlock)(UITableView *tableView, NSInteger section);
typedef UIView*(^headerBlock)(UITableView *tableView, NSInteger section);

@interface SuperListView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *datas;
@property(nonatomic, strong) UIImageView *ADImage;
@property(nonatomic, assign) NSInteger sections;
@property(nonatomic, assign) NSInteger rows;
@property(nonatomic, getter=isSuiSheQu) BOOL isSuiSheQu;
@property(nonatomic, copy) tableViewBlock tableBlock;
@property(nonatomic, copy) sectionBlock sectionBlock;
@property(nonatomic, copy) rowsBlock rowsBlock;
@property(nonatomic, copy) headerBlock headerBlock;

@property(nonatomic, strong) UIView *headerView;
@property(nonatomic, assign) id delegate;

-(id)initListViewWithFrame:(CGRect)frame;

//刷新listview
- (void)refreshListViewWithsections:(sectionBlock)sections rows:(rowsBlock)rows tableBlock:(tableViewBlock)tableBlock isSuiSheQu:(BOOL)isSuiSheQu;

- (void)refreshListViewWithHeaderBlock:(headerBlock)headerBlock isSuiSheQu:(BOOL)isSuiSheQu;

@end

@protocol SuperListViewDelegate

@optional

- (void)SuperListView:(UITableView *)SuperListTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
