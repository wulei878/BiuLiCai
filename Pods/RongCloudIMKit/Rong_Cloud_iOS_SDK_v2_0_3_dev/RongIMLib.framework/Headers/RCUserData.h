//
//  RCUserData.h
//  RongIMLib
//
//  Created by xugang on 5/8/15.
//  Copyright (c) 2015 RongCloud. All rights reserved.
//

#ifndef __RCUserData
#define __RCUserData

#import <Foundation/Foundation.h>
#import "RCPersonalInfo.h"
#import "RCAccountInfo.h"
#import "RCContactInfo.h"
#import "RCClientInfo.h"
/**
 *  用户信息实体类
 */
@interface RCUserData : NSObject
/**
 *  个人信息类
 */
@property(nonatomic, strong) RCPersonalInfo *personalInfo;
/**
 *  帐户信息类
 */
@property(nonatomic, strong) RCAccountInfo *accountInfo;
/**
 *  联系信息类
 */
@property(nonatomic, strong) RCContactInfo *contactInfo;
/**
 *  客户端信息类
 */
@property(nonatomic, strong) RCClientInfo *clientInfo;
/**
 *  应用版本
 */
@property(nonatomic, copy) NSString *appVersion;
/**
 *  扩展信息
 */
@property(nonatomic, copy) NSString *extra;
/**
 *  encode
 *
 *  @return return encode json string
 */
- (NSString *)encode;
/**
 *  decode
 *
 *  @param userDataJsonString userDataJsonString
 *
 *  @return return RCUserData*
 */
+ (instancetype)decodeWithJsonString:(NSString *)userDataJsonString;
@end
#endif
