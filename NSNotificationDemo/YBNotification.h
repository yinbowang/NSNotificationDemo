//
//  YBNotification.h
//  NSNotificationDemo
//
//  Created by wyb on 2017/8/14.
//  Copyright © 2017年 中天易观. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YBNotification : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,strong,readonly) id object;

@property(nonatomic,readonly,copy)NSDictionary *userInfo;

- (instancetype)initWithName:(NSNotificationName)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo;

+ (instancetype)notificationWithName:(NSNotificationName)aName object:(nullable id)anObject;
+ (instancetype)notificationWithName:(NSNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;

@end


NS_ASSUME_NONNULL_END
