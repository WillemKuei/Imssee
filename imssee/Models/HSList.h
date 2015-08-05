//
//  HSList.h
//
//  Created by   on 14-12-23
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HSUser;

@interface HSList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *creatTime;
@property (nonatomic, strong) NSString *context;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) id typeName;
@property (nonatomic, assign) double communityId;
@property (nonatomic, assign) id serviceId;
@property (nonatomic, assign) id likeNumber;
@property (nonatomic, assign) double isNews;
@property (nonatomic, assign) double commentNumber;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double browseNumber;
@property (nonatomic, assign) id activityId;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) double state;
@property (nonatomic, assign) double isTop;
@property (nonatomic, strong) HSUser *user;
@property (nonatomic, assign) double longitude;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSString *addrss;
@property (nonatomic, strong) NSString *columnNo;
@property (nonatomic, assign) long newsId;
@property (nonatomic, assign) double publishState;
@property (nonatomic, strong) NSString *communityName;
@property (nonatomic, strong) NSString *titleContext;

//修改2015-02-09
@property (nonatomic, copy) NSString *authorName;
@property (nonatomic, assign) NSInteger isComment;



+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
