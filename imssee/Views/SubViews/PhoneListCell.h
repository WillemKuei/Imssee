//
//  PhoneListCell.h
//  imssee
//
//  Created by app001.cn on 15-2-11.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLable;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;

@property (weak, nonatomic) IBOutlet UILabel *sectionLable;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@end
