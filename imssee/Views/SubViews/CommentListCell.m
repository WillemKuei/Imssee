//
//  CommentListCell.m
//  imssee
//
//  Created by imsseeios3 on 15/3/2.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "CommentListCell.h"
#import "CommentModel.h"

@implementation CommentListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellWithCommentModel:(CommentModel *)commentModel
{
    self.iconImage.layer.masksToBounds = YES;
    self.iconImage.layer.cornerRadius = 60/2;
    UserInfo *userInfo = commentModel.userInfo;
    NSString *iconPath = [NSString stringWithFormat:@"%@%@",Request_HTTP,userInfo.icon];
    [self.iconImage setImageWithURL:[NSURL URLWithString:iconPath] placeholderImage:[UIImage imageNamed:@"icon_text"]];
    
    self.userLab.text = userInfo.nickName;
    self.contextLab.text = commentModel.context;
    self.timeLab.text = commentModel.createTime;
}

- (void)drawRect:(CGRect)rect
{
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //指定直线的样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    //直线宽度
    CGContextSetLineWidth(context, 0.5);
    //设置颜色
    CGContextSetRGBStrokeColor(context, 0.f/255.f, 0.f/255.f, 0.f/255.f, 1.0);
    //开始绘制
    CGContextBeginPath(context);
    //画虚线
    CGFloat lengths[] = {10,5};
    CGContextSetLineDash(context, 0, lengths, 2);
    //画笔移动到的点
    CGContextMoveToPoint(context, 0, self.frame.size.height - 1);
    //下一点
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height - 1);
    //绘制完成
    CGContextStrokePath(context);
}

@end
