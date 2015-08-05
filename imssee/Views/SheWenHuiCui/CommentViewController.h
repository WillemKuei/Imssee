//
//  CommentViewController.h
//  imssee
//
//  Created by imsseeios3 on 15/3/2.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "SHViewController.h"

@interface CommentViewController : SHViewController

@property (nonatomic, copy) NSString *newsId;

@property (nonatomic, copy) NSString *title;

@end


@interface TitleView : UIView

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *commentNumberLab;

- (instancetype)initTitleViewWithFrame:(CGRect)frame;

@end
