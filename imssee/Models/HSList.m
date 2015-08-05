//
//  HSList.m
//
//  Created by   on 14-12-23
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "HSList.h"
#import "HSUser.h"


NSString *const kHSListCreatTime = @"creatTime";
NSString *const kHSListContext = @"context";
NSString *const kHSListTitle = @"title";
NSString *const kHSListTypeName = @"typeName";
NSString *const kHSListCommunityId = @"communityId";
NSString *const kHSListServiceId = @"serviceId";
NSString *const kHSListLikeNumber = @"likeNumber";
NSString *const kHSListIsNews = @"isNews";
NSString *const kHSListCommentNumber = @"commentNumber";
NSString *const kHSListLatitude = @"latitude";
NSString *const kHSListBrowseNumber = @"browseNumber";
NSString *const kHSListActivityId = @"activityId";
NSString *const kHSListType = @"type";
NSString *const kHSListState = @"state";
NSString *const kHSListIsTop = @"isTop";
NSString *const kHSListUser = @"user";
NSString *const kHSListLongitude = @"longitude";
NSString *const kHSListImagePath = @"imagePath";
NSString *const kHSListAddrss = @"addrss";
NSString *const kHSListColumnNo = @"columnNo";
NSString *const kHSListNewsId = @"newsId";
NSString *const kHSListPublishState = @"publishState";
NSString *const kHSListCommunityName = @"communityName";
NSString *const kHSListTitleContext = @"titleContext";




@interface HSList ()


@end

@implementation HSList

@synthesize creatTime = _creatTime;
@synthesize context = _context;
@synthesize title = _title;
@synthesize typeName = _typeName;
@synthesize communityId = _communityId;
@synthesize serviceId = _serviceId;
@synthesize likeNumber = _likeNumber;
@synthesize isNews = _isNews;
@synthesize commentNumber = _commentNumber;
@synthesize latitude = _latitude;
@synthesize browseNumber = _browseNumber;
@synthesize activityId = _activityId;
@synthesize type = _type;
@synthesize state = _state;
@synthesize isTop = _isTop;
@synthesize user = _user;
@synthesize longitude = _longitude;
@synthesize imagePath = _imagePath;
@synthesize addrss = _addrss;
@synthesize columnNo = _columnNo;
@synthesize newsId = _newsId;
@synthesize publishState = _publishState;
@synthesize communityName = _communityName;
@synthesize titleContext = _titleContext;


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
        
            self.creatTime = [NSString stringWithFormat:@"%@",dict[kHSListCreatTime]];
            self.context = [NSString stringWithFormat:@"%@",dict[kHSListContext]];
            self.title = [NSString stringWithFormat:@"%@",dict[kHSListTitle]];
            self.typeName = dict[kHSListTypeName];
        self.communityId = [[self checkIsNotNull:dict[kHSListCommunityId]] doubleValue];
            self.serviceId = dict[kHSListServiceId];
            self.likeNumber = dict[kHSListLikeNumber];
            self.isNews = [[self checkIsNotNull:dict[kHSListIsNews]] doubleValue];
            self.commentNumber = [[self checkIsNotNull:dict[kHSListCommentNumber]] doubleValue];
            self.latitude = [[self checkIsNotNull:dict[kHSListLatitude]] doubleValue];
            self.browseNumber = [[self checkIsNotNull:dict[kHSListBrowseNumber]] doubleValue];
            self.activityId = dict[kHSListActivityId];
            self.type = [NSString stringWithFormat:@"%@",dict[kHSListType]];
            self.state = [[self checkIsNotNull:dict[kHSListState]] doubleValue];
            self.isTop = [[self checkIsNotNull:dict[kHSListIsTop]] doubleValue];
            self.user = [[HSUser alloc ]initWithDictionary:[dict objectForKey:kHSListUser]];
            self.longitude = [[self checkIsNotNull:dict[kHSListLongitude]] doubleValue];
            self.imagePath = [NSString stringWithFormat:@"%@",dict[kHSListImagePath]];
            self.addrss = [NSString stringWithFormat:@"%@",dict[kHSListAddrss]];
        
            self.columnNo = [NSString stringWithFormat:@"%@",dict[kHSListColumnNo]];
            self.newsId = [[self checkIsNotNull:dict[kHSListNewsId]] longValue];
            self.communityName = [NSString stringWithFormat:@"%@",dict[kHSListCommunityName]];
            self.titleContext = [NSString stringWithFormat:@"%@",dict[kHSListTitleContext]];
            self.publishState = [[self checkIsNotNull:dict[kHSListPublishState]] doubleValue];
        
            //修改2015-02-09
        self.authorName = dict[@"authorName"];
        self.isComment = [[self checkIsNotNull:dict[@"isComment"]] integerValue];
            }
    
    return self;
    
}

- (id)checkIsNotNull:(id)sender
{
    id returnData = [GlobalFunction checkIsNotNull:sender]?sender:nil;
    return returnData;
}

#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.creatTime = [aDecoder decodeObjectForKey:kHSListCreatTime];
    self.context = [aDecoder decodeObjectForKey:kHSListContext];
    self.title = [aDecoder decodeObjectForKey:kHSListTitle];
    self.typeName = [aDecoder decodeObjectForKey:kHSListTypeName];
    self.communityId = [aDecoder decodeDoubleForKey:kHSListCommunityId];
    self.serviceId = [aDecoder decodeObjectForKey:kHSListServiceId];
    self.likeNumber = [aDecoder decodeObjectForKey:kHSListLikeNumber];
    self.isNews = [aDecoder decodeDoubleForKey:kHSListIsNews];
    self.commentNumber = [aDecoder decodeDoubleForKey:kHSListCommentNumber];
    self.latitude = [aDecoder decodeDoubleForKey:kHSListLatitude];
    self.browseNumber = [aDecoder decodeDoubleForKey:kHSListBrowseNumber];
    self.activityId = [aDecoder decodeObjectForKey:kHSListActivityId];
    self.type = [aDecoder decodeObjectForKey:kHSListType];
    self.state = [aDecoder decodeDoubleForKey:kHSListState];
    self.isTop = [aDecoder decodeDoubleForKey:kHSListIsTop];
    self.user = [aDecoder decodeObjectForKey:kHSListUser];
    self.longitude = [aDecoder decodeDoubleForKey:kHSListLongitude];
    self.imagePath = [aDecoder decodeObjectForKey:kHSListImagePath];
    self.addrss = [aDecoder decodeObjectForKey:kHSListAddrss];
    self.columnNo = [aDecoder decodeObjectForKey:kHSListColumnNo];
    self.newsId = [aDecoder decodeDoubleForKey:kHSListNewsId];
    self.publishState = [aDecoder decodeDoubleForKey:kHSListPublishState];
    self.communityName = [aDecoder decodeObjectForKey:kHSListCommunityName];
    self.titleContext = [aDecoder decodeObjectForKey:kHSListTitleContext];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_creatTime forKey:kHSListCreatTime];
    [aCoder encodeObject:_context forKey:kHSListContext];
    [aCoder encodeObject:_title forKey:kHSListTitle];
    [aCoder encodeObject:_typeName forKey:kHSListTypeName];
    [aCoder encodeDouble:_communityId forKey:kHSListCommunityId];
    [aCoder encodeObject:_serviceId forKey:kHSListServiceId];
    [aCoder encodeObject:_likeNumber forKey:kHSListLikeNumber];
    [aCoder encodeDouble:_isNews forKey:kHSListIsNews];
    [aCoder encodeDouble:_commentNumber forKey:kHSListCommentNumber];
    [aCoder encodeDouble:_latitude forKey:kHSListLatitude];
    [aCoder encodeDouble:_browseNumber forKey:kHSListBrowseNumber];
    [aCoder encodeObject:_activityId forKey:kHSListActivityId];
    [aCoder encodeObject:_type forKey:kHSListType];
    [aCoder encodeDouble:_state forKey:kHSListState];
    [aCoder encodeDouble:_isTop forKey:kHSListIsTop];
    [aCoder encodeObject:_user forKey:kHSListUser];
    [aCoder encodeDouble:_longitude forKey:kHSListLongitude];
    [aCoder encodeObject:_imagePath forKey:kHSListImagePath];
    [aCoder encodeObject:_addrss forKey:kHSListAddrss];
    [aCoder encodeObject:_columnNo forKey:kHSListColumnNo];
    [aCoder encodeDouble:_newsId forKey:kHSListNewsId];
    [aCoder encodeDouble:_publishState forKey:kHSListPublishState];
    [aCoder encodeObject:_communityName forKey:kHSListCommunityName];
    [aCoder encodeObject:_titleContext forKey:kHSListTitleContext];

}

- (id)copyWithZone:(NSZone *)zone
{
    HSList *copy = [[HSList alloc] init];
    
    if (copy) {

        copy.creatTime = [self.creatTime copyWithZone:zone];
        copy.context = [self.context copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.typeName = [self.typeName copyWithZone:zone];
        copy.communityId = self.communityId;
        copy.serviceId = [self.serviceId copyWithZone:zone];
        copy.likeNumber = [self.likeNumber copyWithZone:zone];
        copy.isNews = self.isNews;
        copy.commentNumber = self.commentNumber;
        copy.latitude = self.latitude;
        copy.browseNumber = self.browseNumber;
        copy.activityId = [self.activityId copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.state = self.state;
        copy.isTop = self.isTop;
        copy.user = [self.user copyWithZone:zone];
        copy.longitude = self.longitude;
        copy.imagePath = [self.imagePath copyWithZone:zone];
        copy.addrss = [self.addrss copyWithZone:zone];
        copy.columnNo = [self.columnNo copyWithZone:zone];
        copy.newsId = self.newsId;
        copy.publishState = self.publishState;
        copy.communityName = self.communityName;
        copy.titleContext = self.titleContext;

    }
    
    return copy;
}


@end
