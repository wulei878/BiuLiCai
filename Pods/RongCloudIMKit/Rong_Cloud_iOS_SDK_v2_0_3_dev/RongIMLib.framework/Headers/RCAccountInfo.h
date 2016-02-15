//
//  RCAccountInfo.h
//  RongIMLib
//
//  Created by xugang on 5/8/15.
//  Copyright (c) 2015 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  帐户信息类
 */
@interface RCAccountInfo : NSObject
/**
 *  登录名
 */
@property(nonatomic, copy) NSString *userName;
/**
 *  昵称
 */
@property(nonatomic, copy) NSString *nickName;
/**
 *  用户识别符
 */
@property(nonatomic, copy) NSString *appUserId;
@end
