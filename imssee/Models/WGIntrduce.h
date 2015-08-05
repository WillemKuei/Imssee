//
//  WGIntrduce.h
//  imssee
//
//  Created by app001.cn on 15-2-12.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGIntrduce : NSObject
@property (nonatomic, copy) NSString * intro;
@property (nonatomic, assign) long  pmId;               //居委
@property (nonatomic, copy) NSString * pmName;
@property (nonatomic, copy) NSString * remark;
@property (nonatomic, assign) long  sheyuanId;

@property (nonatomic,assign) long ownerId;              //物管
@property (nonatomic,copy) NSString *ownerName;

@property (nonatomic,assign) long streetId;             //街道
@property (nonatomic,copy) NSString *streetName;

- (id)initWithDictionary:(NSDictionary *)params;
@end
