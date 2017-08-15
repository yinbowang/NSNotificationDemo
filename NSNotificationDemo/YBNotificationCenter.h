//
//  YBNotificationCenter.h
//  NSNotificationDemo
//
//  Created by wyb on 2017/8/14.
//  Copyright © 2017年 中天易观. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YBNotification.h"

NS_ASSUME_NONNULL_BEGIN

@interface YBNotificationCenter : NSObject

+ (YBNotificationCenter *)defaultCenter;

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSString *)aName object:(nullable id)anObject;

- (void)postNotification:(YBNotification *)notification;
- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject;
- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;

- (void)removeObserver:(id)observer;
- (void)removeObserver:(id)observer name:(nullable NSString *)aName object:(nullable id)anObject;

- (id <NSObject>)addObserverForName:(nullable NSString *)name object:(nullable id)obj queue:(nullable NSOperationQueue *)queue usingBlock:(void (^)(YBNotification *note))block;

@end

NS_ASSUME_NONNULL_END
