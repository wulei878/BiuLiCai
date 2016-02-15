//
//  RMShareToWeiBoManager.h
//  MiMi-iOS
//
//  Created by 史良 on 14-4-25.
//  Copyright (c) 2014年 Renren Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WeiboSDK.h"
#import "RMShareObject.h"

@interface RMShareToWeiBoManager : NSObject<WeiboSDKDelegate>

+ (instancetype)sharedInstance;
- (void)shareWithShareObject:(RMShareObject *)shareObject
                  completion:(ShareCompletion)shareCompletion;
@end
