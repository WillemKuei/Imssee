//
//  CDVMyPlguin.h
//  test
//
//  Created by 1 on 14-4-9.
//
//

#import <Foundation/Foundation.h>

#import "CDVPlugin.h"

@interface CDVMyPlugin : CDVPlugin

@property (nonatomic, copy) NSString* callbackID;

// Instance Method

- (void) print:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

@end
