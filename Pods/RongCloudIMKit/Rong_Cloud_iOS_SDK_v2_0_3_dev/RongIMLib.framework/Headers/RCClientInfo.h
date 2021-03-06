//
//  RCClientInfo.h
//  RongIMLib
//
//  Created by xugang on 5/8/15.
//  Copyright (c) 2015 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  客户端信息类
 */
@interface RCClientInfo : NSObject
/**
 *  网络类型
 */
@property(nonatomic, copy) NSString *network;
/**
 *  运营商
 */
@property(nonatomic, copy) NSString *carrier;
/**
 *  系统版本
 */
@property(nonatomic, copy) NSString *systemVersion;
/**
 *  操作系统
 */
@property(nonatomic, copy) NSString *os;
/**
 *  设备型号
 */
@property(nonatomic, copy) NSString *device;
/**
 *  手机厂商
 */
@property(nonatomic, copy) NSString *mobilePhoneManufacturers;
@end
