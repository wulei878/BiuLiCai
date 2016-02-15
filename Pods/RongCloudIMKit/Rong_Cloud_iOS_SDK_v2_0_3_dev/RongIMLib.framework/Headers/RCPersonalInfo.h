//
//  RCPersonalInfo.h
//  RongIMLib
//
//  Created by xugang on 5/8/15.
//  Copyright (c) 2015 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  个人信息类
 */
@interface RCPersonalInfo : NSObject
/**
 *  真实姓名
 */
@property(nonatomic, copy) NSString *realName;
/**
 *  性别
 */
@property(nonatomic, copy) NSString *sex;
/**
 *  生日
 */
@property(nonatomic, copy) NSString *birthday;
/**
 *  年龄
 */
@property(nonatomic, copy) NSString *age;
/**
 *  职业
 */
@property(nonatomic, copy) NSString *job;
/**
 *  头像URL
 */
@property(nonatomic, copy) NSString *portraitUri;
/**
 *  备注
 */
@property(nonatomic, copy) NSString *comment;


@end
