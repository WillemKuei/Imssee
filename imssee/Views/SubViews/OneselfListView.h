//
//  OneselfListView.h
//  imssee
//
//  Created by app001.cn on 14-12-26.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneselfListView : UIView

@property(nonatomic, assign) id delegate;

@end

@protocol OneselfListViewDelegate

@optional

- (void)OneselfListView:(UIView *)OneselfListView didClickedEditBtn:(UIButton *)editBtn;

@end