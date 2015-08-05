//
//  CommunityNewsViewController.h
//  imssee
//
//  Created by 鑫易 on 15/2/2.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "SHViewController.h"

/**
 *  CommunityNewsViewController
 */
@class SHPageViewController;
@interface CommunityNewsViewController : SHViewController

@property (nonatomic, strong) SHPageViewController *pageViewController;

@end


/**
 *  CommunityNewsListView
 */
@protocol CommunityNewsListDataSource;
@protocol CommunityNewsListDelegate;
@interface CommunityNewsListView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *listView;
@property (nonatomic, assign) id<CommunityNewsListDataSource>dataSource;
@property (nonatomic, assign) id<CommunityNewsListDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame dataSourceOrDelegate:(id)sender;

- (void)reloadListData;

@end

/**
 *  CommunityNewsListDataSource
 */
@protocol CommunityNewsListDataSource <NSObject>

@required
- (NSInteger)comTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)comTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (CGFloat)comTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

/**
 *  CommunityNewsListDelegate
 */
@protocol CommunityNewsListDelegate <NSObject>

@optional
- (void)comTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
