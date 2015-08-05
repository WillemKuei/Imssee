//
//  HSUser.m
//
//  Created by   on 14-12-23
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "HSUser.h"


NSString *const kHSUserBirthday = @"birthday";
NSString *const kHSUserSchool = @"school";
NSString *const kHSUserSex = @"sex";
NSString *const kHSUserIcon = @"icon";
NSString *const kHSUserImages = @"images";
NSString *const kHSUserLevelName = @"levelName";
NSString *const kHSUserWorkingtime = @"workingtime";
NSString *const kHSUserEdu = @"edu";
NSString *const kHSUserLeve = @"leve";
NSString *const kHSUserMemberid = @"memberid";
NSString *const kHSUserCommunity = @"community";
NSString *const kHSUserScId = @"scId";
NSString *const kHSUserIntr = @"intr";
NSString *const kHSUserMemberName = @"memberName";
NSString *const kHSUserIsMaster = @"isMaster";
NSString *const kHSUserNicName = @"nicName";
NSString *const kHSUserTell = @"tell";
NSString *const kHSUserAge = @"age";
NSString *const kHSUserUserName = @"userName";
NSString *const kHSUserSrocialAttStauts = @"srocialAttStauts";
NSString *const kHSUserIntegral = @"integral";


@interface HSUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HSUser

@synthesize birthday = _birthday;
@synthesize school = _school;
@synthesize sex = _sex;
@synthesize icon = _icon;
@synthesize images = _images;
@synthesize levelName = _levelName;
@synthesize workingtime = _workingtime;
@synthesize edu = _edu;
@synthesize leve = _leve;
@synthesize memberid = _memberid;
@synthesize community = _community;
@synthesize scId = _scId;
@synthesize intr = _intr;
@synthesize memberName = _memberName;
@synthesize isMaster = _isMaster;
@synthesize nicName = _nicName;
@synthesize tell = _tell;
@synthesize age = _age;
@synthesize userName = _userName;
@synthesize srocialAttStauts = _srocialAttStauts;
@synthesize integral = _integral;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.birthday = [self objectOrNilForKey:kHSUserBirthday fromDictionary:dict];
            self.school = [self objectOrNilForKey:kHSUserSchool fromDictionary:dict];
            self.sex = [[self objectOrNilForKey:kHSUserSex fromDictionary:dict] doubleValue];
            self.icon = [self objectOrNilForKey:kHSUserIcon fromDictionary:dict];
            self.images = [self objectOrNilForKey:kHSUserImages fromDictionary:dict];
            self.levelName = [self objectOrNilForKey:kHSUserLevelName fromDictionary:dict];
            self.workingtime = [self objectOrNilForKey:kHSUserWorkingtime fromDictionary:dict];
            self.edu = [self objectOrNilForKey:kHSUserEdu fromDictionary:dict];
            self.leve = [[self objectOrNilForKey:kHSUserLeve fromDictionary:dict] doubleValue];
            self.memberid = [[self objectOrNilForKey:kHSUserMemberid fromDictionary:dict] longValue];
            self.community = [self objectOrNilForKey:kHSUserCommunity fromDictionary:dict];
            self.scId = [[self objectOrNilForKey:kHSUserScId fromDictionary:dict] longValue];
            self.intr = [self objectOrNilForKey:kHSUserIntr fromDictionary:dict];
            self.memberName = [self objectOrNilForKey:kHSUserMemberName fromDictionary:dict];
            self.isMaster = [[self objectOrNilForKey:kHSUserIsMaster fromDictionary:dict] doubleValue];
            self.nicName = [self objectOrNilForKey:kHSUserNicName fromDictionary:dict];
            self.tell = [self objectOrNilForKey:kHSUserTell fromDictionary:dict];
            self.age = [self objectOrNilForKey:kHSUserAge fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kHSUserUserName fromDictionary:dict];
            self.srocialAttStauts = [self objectOrNilForKey:kHSUserSrocialAttStauts fromDictionary:dict];
            self.integral = [[self objectOrNilForKey:kHSUserIntegral fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.birthday forKey:kHSUserBirthday];
    [mutableDict setValue:self.school forKey:kHSUserSchool];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sex] forKey:kHSUserSex];
    [mutableDict setValue:self.icon forKey:kHSUserIcon];
    [mutableDict setValue:self.images forKey:kHSUserImages];
    [mutableDict setValue:self.levelName forKey:kHSUserLevelName];
    [mutableDict setValue:self.workingtime forKey:kHSUserWorkingtime];
    [mutableDict setValue:self.edu forKey:kHSUserEdu];
    [mutableDict setValue:[NSNumber numberWithDouble:self.leve] forKey:kHSUserLeve];
    [mutableDict setValue:[NSNumber numberWithDouble:self.memberid] forKey:kHSUserMemberid];
    [mutableDict setValue:self.community forKey:kHSUserCommunity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.scId] forKey:kHSUserScId];
    [mutableDict setValue:self.intr forKey:kHSUserIntr];
    [mutableDict setValue:self.memberName forKey:kHSUserMemberName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isMaster] forKey:kHSUserIsMaster];
    [mutableDict setValue:self.nicName forKey:kHSUserNicName];
    [mutableDict setValue:self.tell forKey:kHSUserTell];
    [mutableDict setValue:self.age forKey:kHSUserAge];
    [mutableDict setValue:self.userName forKey:kHSUserUserName];
    [mutableDict setValue:self.srocialAttStauts forKey:kHSUserSrocialAttStauts];
    [mutableDict setValue:[NSNumber numberWithDouble:self.integral] forKey:kHSUserIntegral];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.birthday = [aDecoder decodeObjectForKey:kHSUserBirthday];
    self.school = [aDecoder decodeObjectForKey:kHSUserSchool];
    self.sex = [aDecoder decodeDoubleForKey:kHSUserSex];
    self.icon = [aDecoder decodeObjectForKey:kHSUserIcon];
    self.images = [aDecoder decodeObjectForKey:kHSUserImages];
    self.levelName = [aDecoder decodeObjectForKey:kHSUserLevelName];
    self.workingtime = [aDecoder decodeObjectForKey:kHSUserWorkingtime];
    self.edu = [aDecoder decodeObjectForKey:kHSUserEdu];
    self.leve = [aDecoder decodeDoubleForKey:kHSUserLeve];
    self.memberid = [aDecoder decodeDoubleForKey:kHSUserMemberid];
    self.community = [aDecoder decodeObjectForKey:kHSUserCommunity];
    self.scId = [aDecoder decodeDoubleForKey:kHSUserScId];
    self.intr = [aDecoder decodeObjectForKey:kHSUserIntr];
    self.memberName = [aDecoder decodeObjectForKey:kHSUserMemberName];
    self.isMaster = [aDecoder decodeDoubleForKey:kHSUserIsMaster];
    self.nicName = [aDecoder decodeObjectForKey:kHSUserNicName];
    self.tell = [aDecoder decodeObjectForKey:kHSUserTell];
    self.age = [aDecoder decodeObjectForKey:kHSUserAge];
    self.userName = [aDecoder decodeObjectForKey:kHSUserUserName];
    self.srocialAttStauts = [aDecoder decodeObjectForKey:kHSUserSrocialAttStauts];
    self.integral = [aDecoder decodeDoubleForKey:kHSUserIntegral];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_birthday forKey:kHSUserBirthday];
    [aCoder encodeObject:_school forKey:kHSUserSchool];
    [aCoder encodeDouble:_sex forKey:kHSUserSex];
    [aCoder encodeObject:_icon forKey:kHSUserIcon];
    [aCoder encodeObject:_images forKey:kHSUserImages];
    [aCoder encodeObject:_levelName forKey:kHSUserLevelName];
    [aCoder encodeObject:_workingtime forKey:kHSUserWorkingtime];
    [aCoder encodeObject:_edu forKey:kHSUserEdu];
    [aCoder encodeDouble:_leve forKey:kHSUserLeve];
    [aCoder encodeDouble:_memberid forKey:kHSUserMemberid];
    [aCoder encodeObject:_community forKey:kHSUserCommunity];
    [aCoder encodeDouble:_scId forKey:kHSUserScId];
    [aCoder encodeObject:_intr forKey:kHSUserIntr];
    [aCoder encodeObject:_memberName forKey:kHSUserMemberName];
    [aCoder encodeDouble:_isMaster forKey:kHSUserIsMaster];
    [aCoder encodeObject:_nicName forKey:kHSUserNicName];
    [aCoder encodeObject:_tell forKey:kHSUserTell];
    [aCoder encodeObject:_age forKey:kHSUserAge];
    [aCoder encodeObject:_userName forKey:kHSUserUserName];
    [aCoder encodeObject:_srocialAttStauts forKey:kHSUserSrocialAttStauts];
    [aCoder encodeDouble:_integral forKey:kHSUserIntegral];
}

- (id)copyWithZone:(NSZone *)zone
{
    HSUser *copy = [[HSUser alloc] init];
    
    if (copy) {

        copy.birthday = [self.birthday copyWithZone:zone];
        copy.school = [self.school copyWithZone:zone];
        copy.sex = self.sex;
        copy.icon = [self.icon copyWithZone:zone];
        copy.images = [self.images copyWithZone:zone];
        copy.levelName = [self.levelName copyWithZone:zone];
        copy.workingtime = [self.workingtime copyWithZone:zone];
        copy.edu = [self.edu copyWithZone:zone];
        copy.leve = self.leve;
        copy.memberid = self.memberid;
        copy.community = [self.community copyWithZone:zone];
        copy.scId = self.scId;
        copy.intr = [self.intr copyWithZone:zone];
        copy.memberName = [self.memberName copyWithZone:zone];
        copy.isMaster = self.isMaster;
        copy.nicName = [self.nicName copyWithZone:zone];
        copy.tell = [self.tell copyWithZone:zone];
        copy.age = [self.age copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.srocialAttStauts = [self.srocialAttStauts copyWithZone:zone];
        copy.integral = self.integral;
    }
    
    return copy;
}


@end
