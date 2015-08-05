//
//  NewsModel.h
//  imssee
//
//  Created by app001.cn on 14-12-26.
//  Copyright (c) 2014年 鑫易. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, assign) int age;

- (instancetype)initNewsModel;

- (id)initNewsModel_ID;

@end
