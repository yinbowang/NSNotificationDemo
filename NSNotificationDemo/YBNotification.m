//
//  YBNotification.m
//  NSNotificationDemo
//
//  Created by wyb on 2017/8/14.
//  Copyright © 2017年 中天易观. All rights reserved.
//

#import "YBNotification.h"

@implementation YBNotification

- (instancetype)initWithName:(NSNotificationName)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo
{
    
    self = [super init];
    
    if (self) {
        
        _name = name;
        _object = object;
        _userInfo = userInfo;
        
    }
    return self;
}

+ (instancetype)notificationWithName:(NSNotificationName)aName object:(nullable id)anObject
{
    return [self notificationWithName:aName object:anObject userInfo:nil];
}

+ (instancetype)notificationWithName:(NSNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo
{
    return [[self alloc]initWithName:aName object:anObject userInfo:aUserInfo];
}




@end
