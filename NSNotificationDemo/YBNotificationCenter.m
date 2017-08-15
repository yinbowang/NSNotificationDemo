//
//  YBNotificationCenter.m
//  NSNotificationDemo
//
//  Created by wyb on 2017/8/14.
//  Copyright © 2017年 中天易观. All rights reserved.
//

#import "YBNotificationCenter.h"


typedef void(^OperationBlock)(YBNotification *notification);

@interface YBObserverModel : NSObject

@property (nonatomic, strong) id observer;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, copy) NSString *notificationName;
@property (nonatomic, strong) id object;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, copy) OperationBlock block;

@end

@implementation YBObserverModel


@end

@interface YBNotificationCenter ()

@property (nonatomic, strong) NSMutableDictionary *observersDic;

@end

@implementation YBNotificationCenter

static YBNotificationCenter *instance = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return instance;
}

+ (YBNotificationCenter *)defaultCenter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _observersDic = [NSMutableDictionary dictionary];
        
    }
    return self;
}

- (void)addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSString *)aName object:(nullable id)anObject
{
    YBObserverModel *model = [YBObserverModel new];
    model.observer = observer;
    model.selector = aSelector;
    model.notificationName = aName;
    model.object = anObject;
    
    //  按照key存储监听者的数组
    NSMutableArray *modelArray = [self.observersDic objectForKey:aName];
    if (!modelArray) {
        modelArray = [NSMutableArray array];
    }
    
    [modelArray addObject:model];
    [self.observersDic setObject:modelArray forKey:aName];
    

  
    
}

- (id <NSObject>)addObserverForName:(nullable NSString *)name object:(nullable id)obj queue:(nullable NSOperationQueue *)queue usingBlock:(void (^)(YBNotification *note))block
{
    YBObserverModel *model = [YBObserverModel new];
    model.notificationName = name;
    model.object = obj;
    model.operationQueue = queue;
    model.block = block;
    
    //  按照key存储监听者的数组
    NSMutableArray *modelArray = [self.observersDic objectForKey:name];
    if (!modelArray) {
        modelArray = [NSMutableArray array];
    }
    
    [modelArray addObject:model];
    [self.observersDic setObject:modelArray forKey:name];
    
    return nil;
}


- (void)postNotification:(YBNotification *)notification
{

    NSString *name = notification.name;
    NSArray *modelArray = [self.observersDic objectForKey:name];
    for (YBObserverModel *model in modelArray) {
        
        id observer = model.observer;
        SEL selector = model.selector;
        if (model.operationQueue) {
            
           [model.operationQueue addOperationWithBlock:^{
              
               model.block(notification);
               
           }];
            
        }else{
            
             [observer performSelector:selector withObject:notification];
            
        }
        
    }
    
}
- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject
{
    [self postNotificationName:aName object:anObject userInfo:nil];
}

- (void)postNotificationName:(NSString *)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo
{
    YBNotification *notification = [[YBNotification alloc]initWithName:aName object:anObject userInfo:aUserInfo];
    [self postNotification:notification];
    
}

- (void)removeObserver:(id)observer
{
    [self removeObserver:observer name:nil object:nil];
}
- (void)removeObserver:(id)observer name:(nullable NSString *)aName object:(nullable id)anObject
{
    
    for (NSString *name in self.observersDic) {
        
        NSMutableArray *modelArray = [self.observersDic objectForKey:name];
        for (YBObserverModel *model in modelArray) {
            
            if (model.observer == observer && [model.notificationName isEqualToString: aName] && model.object == anObject) {
                
                [modelArray removeObject:model];
                
            }
            
        }
        
    }
    
    
        
   
}



@end
