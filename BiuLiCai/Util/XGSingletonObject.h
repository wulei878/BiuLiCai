//
//  XGSingletonObject.h
//  XGCG
//
//  Created by Owen on 15/4/26.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

@protocol XGSingletonObjectProtocol <NSObject>

+ (instancetype)sharedInstance;

@end

@interface XGSingletonObject : NSObject <XGSingletonObjectProtocol>

@end

