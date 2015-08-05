//
//  CommentListCell.h
//  imssee
//
//  Created by imsseeios3 on 15/3/2.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommentModel;
@interface CommentListCell : UITableViewCell

@property (nonatomic, strong) CommentModel *commentModel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *userLab;
@property (weak, nonatomic) IBOutlet UILabel *contextLab;

- (void)configureCellWithCommentModel:(CommentModel *)commentModel;

@end
