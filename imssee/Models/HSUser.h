//
//  HSUser.h
//
//  Created by   on 14-12-23
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HSUser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *school;
@property (nonatomic, assign) double sex;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *images;
@property (nonatomic, assign) id levelName;
@property (nonatomic, strong) NSString *workingtime;
@property (nonatomic, strong) NSString *edu;
@property (nonatomic, assign) double leve;
@property (nonatomic, assign) long memberid;
@property (nonatomic, assign) id community;
@property (nonatomic, assign) long scId;
@property (nonatomic, strong) NSString *intr;
@property (nonatomic, strong) NSString *memberName;
@property (nonatomic, assign) double isMaster;
@property (nonatomic, assign) id nicName;
@property (nonatomic, strong) NSString *tell;
@property (nonatomic, assign) id age;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, assign) id srocialAttStauts;
@property (nonatomic, assign) double integral;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
