//
//  DetailsViewController.h
//  imssee
//
//  Created by app001.cn on 14-12-29.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSList.h"

@interface DetailsViewController : UIViewController

@property (nonatomic,strong)HSList *receiveList;
@property (nonatomic,assign)CGFloat rectY;
@property (nonatomic,assign)CGFloat rectH;

@end
