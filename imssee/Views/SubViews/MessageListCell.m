//
//  MessageListCell.m
//  imssee
//
//  Created by 鑫易 on 15/2/5.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "MessageListCell.h"
#import "SHBadgeImage.h"

@implementation MessageListCell

- (void)awakeFromNib {
    // Initialization code
    [self loadContentView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    if (_badgeValue != badgeValue) {
        _badgeValue = badgeValue;
        [_badgeImage setBadgeValue:_badgeValue];
    }
}

- (void)setMarkImageStyle:(MarkImageStyle)markImageStyle
{
    _markImageStyle = markImageStyle;
    if (_markImageStyle == NoneMark) {
        return;
    }
    [self loadMarkImage];
}

#define Margin 8
#define IconImage_Width 50
#define IconImage_Height 50
#define Badge_Width 20
#define Badge_Height 20
#define RightLab_Width 70
#define RightLab_Heigh 21
#define Content_Height 20

- (void)loadContentView
{
    //badge
    _badgeImage = [[SHBadgeImage alloc] initSHBadgeImage:CGRectMake(self.iconImage.frame.origin.x + IconImage_Width + Margin, Margin, Badge_Width, Badge_Height)];
    [self addSubview:_badgeImage];
    //添加背景阴影
    [GlobalFunction radiusImageView:self.iconImage radius:20.f];
    [self setBadgeValue:@"0"];
    [self setMarkImageStyle:NoneMark];
    
    CGFloat screenWidth = SCREEN_WIDTH;
    //timeLab
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth - Margin - RightLab_Width, Margin, RightLab_Width, RightLab_Heigh)];
    timeLab.textAlignment = NSTextAlignmentRight;
    timeLab.font = [UIFont systemFontOfSize:14.f];
    timeLab.textColor = GrayColor;
    timeLab.text = @"AM00:00";
    self.timeLab = timeLab;
    [self addSubview:self.timeLab];
    //authorLab
    UILabel *authorLab = [[UILabel alloc] initWithFrame:CGRectMake(timeLab.frame.origin.x, timeLab.frame.origin.y + RightLab_Heigh, RightLab_Width, RightLab_Heigh)];
    authorLab.textAlignment = NSTextAlignmentRight;
    authorLab.font = timeLab.font;
    authorLab.textColor = GrayColor;
    authorLab.text = @"";
    self.authorLab = authorLab;
    [self addSubview:self.authorLab];
    //titleLab
    CGFloat contentWidth = screenWidth - _badgeImage.frame.origin.x + Badge_Width - RightLab_Width - Margin * 5;
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(_badgeImage.frame.origin.x + Badge_Width, Margin, contentWidth, Content_Height)];
    titleLab.font = [UIFont systemFontOfSize:16.f];
    titleLab.text = @"";
    self.titleLab = titleLab;
    [self addSubview:self.titleLab];
    //contentLab
    UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(titleLab.frame.origin.x, titleLab.frame.origin.y + Content_Height, contentWidth, Content_Height)];
    contentLab.font = [UIFont systemFontOfSize:14.f];
    contentLab.text = @"";
    contentLab.textColor = GrayColor;
    self.contentLab = contentLab;
    [self addSubview:self.contentLab];
    
}

- (void)loadMarkImage
{
    UIImageView *markImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IconImage_Width/2, IconImage_Height/2)];
    NSString *markName = nil;
    switch (self.markImageStyle) {
        case Community:
            markName = @"community";
            break;
        case HotNews:
            markName = @"hotNews";
            break;
        case Notification:
            markName = @"notification";
            break;
            
        default:
            break;
    }
    markImage.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:markName ofType:@"png"]];
    [self.iconImage addSubview:markImage];
}

@end
