//
//  SHPageViewController.h
//  imssee
//
//  Created by 鑫易 on 15/1/30.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "SHViewController.h"
typedef enum {
    HotNewsList = 0,
    CommunityNewsList = 1
}CurrentChapter;

@interface SHPageViewController : SHViewController

@property (nonatomic) CurrentChapter currentChapter;

@end

