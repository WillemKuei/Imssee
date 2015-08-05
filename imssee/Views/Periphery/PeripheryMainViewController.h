//
//  PeripheryMainViewController.h
//  imssee
//
//  Created by 鑫易 on 15/1/29.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "SHViewController.h"
#import "SubMenuListView.h"

@interface PeripheryMainViewController : SHViewController<SubMenuListViewDataSource,SubMenuListViewDelegate>
{
    __block SubMenuListView *_listView;
    __weak IBOutlet UIScrollView *_contentView;
}

@end


@interface PluginItem : UIView
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *titleLab;

- (instancetype)initPluginItemWithframe:(CGRect)frame params:(NSDictionary *)params;

@end
