//
//  SubMenuListView.h
//  imssee
//
//  Created by imsseeios3 on 15/2/11.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubMenuListViewDataSource, SubMenuListViewDelegate;
@interface SubMenuListView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, assign) id<SubMenuListViewDataSource>menuDataSource;

@property (nonatomic, assign) id<SubMenuListViewDelegate>menuDelegate;

- (instancetype)initSubMenuListViewWithFrame:(CGRect)frame style:(UITableViewStyle)style;

- (void)reloadMenuData;

@end



@protocol SubMenuListViewDataSource <NSObject>

@required
- (NSInteger)subMenuListView:(SubMenuListView *)listView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)subMenuListView:(SubMenuListView *)listView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol SubMenuListViewDelegate <NSObject>

@optional
- (void)subMenuListView:(SubMenuListView *)listView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
