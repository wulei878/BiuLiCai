//
//  RCContactInfo.h
//  RongIMLib
//
//  Created by xugang on 5/8/15.
//  Copyright (c) 2015 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  联系信息类
 */
@interface RCContactInfo : NSObject
/**
 *  电话
 */
@property(nonatomic, copy) NSString *tel;
/**
 *  邮箱
 */
@property(nonatomic, copy) NSString *email;
/**
 *  地址
 */
@property(nonatomic, copy) NSString *address;
/**
 *  QQ
 */
@property(nonatomic, copy) NSString *qq;
/**
 *  微博ID
 */
@property(nonatomic, copy) NSString *weiBo;
/**
 *  微信号
 */
@property(nonatomic, copy) NSString *weiXin;

@end
