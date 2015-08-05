//
//  CommunityNewsCell.m
//  imssee
//
//  Created by 鑫易 on 15/2/3.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "CommunityNewsCell.h"
#import "HSList.h"

@implementation CommunityNewsCell

- (void)awakeFromNib {
    // Initialization code
    [self loadContentView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#define Lab_Height 21.0
- (void)loadContentView
{
    //描绘image的阴影背景
    //[GlobalFunction radiusImageView:self.image radius:20.f];
    
    //描绘markLab
    CALayer *layer_mark = self.markLab.layer;
    layer_mark.borderColor = GrayColor.CGColor;
    layer_mark.borderWidth = 1.0f;
    layer_mark.cornerRadius = 5.0f;
    layer_mark.masksToBounds = YES;
    self.markLab.textColor = GrayColor;
    
    //加载描述内容
    //标题
    CGRect contentRect = self.describeView.bounds;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contentRect.size.width, Lab_Height)];
    title.font = [UIFont systemFontOfSize:16.f];
    title.text = @"";
    self.titleLab = title;
    [self.describeView addSubview:self.titleLab];
    
    //内容
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(0, Lab_Height, contentRect.size.width, Lab_Height)];
    content.font = [UIFont systemFontOfSize:14.f];
    content.textColor = GrayColor;
    content.text = @"";
    self.contentLab = content;
    [self.describeView addSubview:self.contentLab];
    //时间
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(0, Lab_Height * 2, 80, Lab_Height)];
    time.font = [UIFont systemFontOfSize:13.f];
    time.textColor = GrayColor;
    time.text = @"2015-02-07";
    self.timeLab = time;
    [self.describeView addSubview:self.timeLab];
    /*
    //评论图标
    UIImageView *commentImg = [[UIImageView alloc] initWithFrame:CGRectMake(88, Lab_Height * 2, 24, 24)];
    commentImg.image = [UIImage imageNamed:@"liuyan.png"];
    [self.describeView addSubview:commentImg];
    //评论数
    UILabel *comment = [[UILabel alloc] initWithFrame:CGRectMake(88 + 24 + 8, Lab_Height * 2, 30, Lab_Height)];
    comment.font = [UIFont systemFontOfSize:13.f];
    comment.textColor = PinkColor;
    comment.text = @"99+";
    self.commentCountLab = comment;
    [self.describeView addSubview:self.commentCountLab];
     */
}

- (void)reloadCmmunityData:(HSList *)listModel
{
    self.listModel = listModel;
    //图片
    NSString *imagePath = listModel.imagePath;
    imagePath = (NSString *)[[imagePath componentsSeparatedByString:@","] lastObject];
    NSString *imageURL = [NSString stringWithFormat:@"%@%@",ImagePath_IP,imagePath];
    [self.image setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"icon_text.png"]];
    //标题
    self.titleLab.text = listModel.title;
    //内容
    self.contentLab.text = listModel.context;
    //mark
    self.imgNewsMarkLab.text = listModel.type;
    //time
    self.timeLab.text = listModel.creatTime;
    
    //加载评论数和作者
    NSString *authorName = [GlobalFunction checkIsNotNull:listModel.authorName]?listModel.authorName:@"作者";
    UILabel *authorLab = [[UILabel alloc] initWithFrame:CGRectMake(self.timeLab.frame.origin.x + self.timeLab.frame.size.width, self.timeLab.frame.origin.y, 60, 20)];
    authorLab.textColor = self.timeLab.textColor;
    authorLab.textAlignment = NSTextAlignmentCenter;
    authorLab.font = self.titleLab.font;
    authorLab.text = authorName;
    [self.describeView addSubview:authorLab];
    
    NSString *comCount = [NSString stringWithFormat:@"评论数：%.f",listModel.commentNumber];
    UILabel *comCountLab = [[UILabel alloc] initWithFrame:CGRectMake(authorLab.frame.origin.x + authorLab.frame.size.width, authorLab.frame.origin.y, 80, 20)];
    comCountLab.textColor = self.timeLab.textColor;
    comCountLab.font = self.titleLab.font;
    comCountLab.text = comCount;
    [self.describeView addSubview:comCountLab];
    
    authorName = nil;
    authorLab = nil;
    comCount = nil;
    comCountLab = nil;
}

@end
