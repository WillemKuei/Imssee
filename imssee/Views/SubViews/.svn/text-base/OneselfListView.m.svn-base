//
//  OneselfListView.m
//  imssee
//
//  Created by app001.cn on 14-12-26.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

#import "OneselfListView.h"

@implementation OneselfListView
{
    UIView *_editBarView;;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initEditBarView];
    }
    return self;
}

-(void)initEditBarView{
    float rectW = self.bounds.size.width;
    _editBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, rectW, 40)];
    _editBarView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *titleLable = [[UILabel alloc]init];
    titleLable.bounds = CGRectMake(0, 0, 100, 30);
    titleLable.center = CGPointMake(rectW/2, _editBarView.frame.size.height/2);
    titleLable.text = @"社闻荟萃";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.backgroundColor = [UIColor whiteColor];
    [_editBarView addSubview:titleLable];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    editBtn.bounds = CGRectMake(0, 0, 50, 30);
    float pointX = rectW - editBtn.bounds.size.width/2 -10;
    float pointY = _editBarView.frame.size.height/2;
    editBtn.center = CGPointMake(pointX, pointY);
    [editBtn addTarget:self action:@selector(editBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    [editBtn setTitle:@"edit" forState:UIControlStateNormal];
    editBtn.backgroundColor = [UIColor orangeColor];
    [_editBarView addSubview:editBtn];
    
    [self addSubview:_editBarView];
}

//点击编辑按钮
-(void)editBtnCliked:(UIButton *)btn{
    NSLog(@"editBtnCliked OneselfListView");
    if ([_delegate respondsToSelector:@selector(OneselfListView:didClickedEditBtn:)]) {
        [_delegate OneselfListView:self didClickedEditBtn:btn];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
