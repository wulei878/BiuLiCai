//
//  XGSingletonObject.m
//  XGCG
//
//  Created by Owen on 15/4/26.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGSingletonObject.h"

static NSMutableDictionary *sharedInstances = nil;

@implementation XGSingletonObject
+ (instancetype)sharedInstance
{
    @synchronized(self) {
        if (!sharedInstances) {
            sharedInstances = [NSMutableDictionary dictionary];
        }
        id sharedInstance = [sharedInstances objectForKey:NSStringFromClass(self)];
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
            [sharedInstances setValue:sharedInstance forKey:NSStringFromClass(self)];
        }
    }
    return [sharedInstances objectForKey:NSStringFromClass(self)];
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    @synchronized(self) {
        if (!sharedInstances) {
            sharedInstances = [NSMutableDictionary dictionary];
        }
        id sharedInstance = [sharedInstances objectForKey:NSStringFromClass(self)];
        if (!sharedInstance) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    return nil;
}

@end
