//
//  MessageListCell.h
//  imssee
//
//  Created by 鑫易 on 15/2/5.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    HotNews = 0,
    Community = 1,
    Notification = 2,
    NoneMark = 3
}MarkImageStyle;

@class SHBadgeImage;
@interface MessageListCell : UITableViewCell
{
    SHBadgeImage *_badgeImage;
}

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UILabel *contentLab;
@property (strong, nonatomic) UILabel *timeLab;
@property (strong, nonatomic) UILabel *authorLab;
@property (strong, nonatomic) NSString *badgeValue;
@property (nonatomic) MarkImageStyle markImageStyle;

@end

