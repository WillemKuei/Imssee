//
//  HSResult.m
//
//  Created by   on 14-12-23
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "HSResult.h"
#import "HSList.h"


NSString *const kHSResultType = @"type";
NSString *const kHSResultTypeValue = @"typeValue";
NSString *const kHSResultList = @"list";


@interface HSResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HSResult

@synthesize type = _type;
@synthesize typeValue = _typeValue;
@synthesize list = _list;


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
            self.type = [self objectOrNilForKey:kHSResultType fromDictionary:dict];
            self.typeValue = [self objectOrNilForKey:kHSResultTypeValue fromDictionary:dict];
    NSObject *receivedHSList = [dict objectForKey:kHSResultList];
    NSMutableArray *parsedHSList = [NSMutableArray array];
    if ([receivedHSList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHSList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHSList addObject:[HSList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHSList isKindOfClass:[NSDictionary class]]) {
       [parsedHSList addObject:[HSList modelObjectWithDictionary:(NSDictionary *)receivedHSList]];
    }

    self.list = [NSArray arrayWithArray:parsedHSList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.type forKey:kHSResultType];
    [mutableDict setValue:self.typeValue forKey:kHSResultTypeValue];
    NSMutableArray *tempArrayForList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.list) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForList] forKey:kHSResultList];

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

    self.type = [aDecoder decodeObjectForKey:kHSResultType];
    self.typeValue = [aDecoder decodeObjectForKey:kHSResultTypeValue];
    self.list = [aDecoder decodeObjectForKey:kHSResultList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_type forKey:kHSResultType];
    [aCoder encodeObject:_typeValue forKey:kHSResultTypeValue];
    [aCoder encodeObject:_list forKey:kHSResultList];
}

- (id)copyWithZone:(NSZone *)zone
{
    HSResult *copy = [[HSResult alloc] init];
    
    if (copy) {

        copy.type = [self.type copyWithZone:zone];
        copy.typeValue = [self.typeValue copyWithZone:zone];
        copy.list = [self.list copyWithZone:zone];
    }
    
    return copy;
}


@end
