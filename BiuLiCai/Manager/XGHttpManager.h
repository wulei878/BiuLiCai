//
//  XGHttpManager.h
//  XGCG
//
//  Created by Owen on 15/4/26.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

@class XGHttpManager;

typedef void (^HttpRequestSucceededBlock) (id responseObject);
typedef void (^HttpRequestFailedBlock) (NSString *errorMessage);
typedef void (^HttpRequestProgressBlock) (float percent);
static NSString * const kNetworkErrorMessage = @"网络断开，请检查网络连接";
static NSString * const kNetworkUnstableMessage = @"网络不稳定，点击刷新";
static NSString * const kServerErrorMessage = @"出了点问题，请重新试试";

@interface XGHttpManager : NSObject

+ (XGHttpManager *)sharedManager;

- (instancetype)initWithBaseURL:(NSURL *)baseURL;

- (void)getRequestForPath:(NSString *)urlPath
               parameters:(NSDictionary *)parameters
             successBlock:(HttpRequestSucceededBlock)success
                failBlock:(HttpRequestFailedBlock)failure;

- (void)postRequestForPath:(NSString *)urlPath
                parameters:(NSDictionary *)parameters
              successBlock:(HttpRequestSucceededBlock)success
                 failBlock:(HttpRequestFailedBlock)failure;

- (void)postWithFormDataForPath:(NSString *)urlPath
                      imageData:(NSData *)imageData
                     parameters:(NSDictionary *)parameters
                   successBlock:(HttpRequestSucceededBlock)success
                      failBlock:(HttpRequestFailedBlock)failure
                  progressBlock:(HttpRequestProgressBlock)progress;
@end
