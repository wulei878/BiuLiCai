//
//  XGHttpManager.m
//  XGCG
//
//  Created by Owen on 15/4/26.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGHttpManager.h"

#import "NSString+MD5.h"
#import <sys/utsname.h>
#import "AFNetworking.h"
#import "XGGlobalURL.h"
#import "AFHTTPRequestOperationManager+UploadProgress.h"
#import "XGCurrentUserManager.h"
#import "XGUserItem.h"

static NSInteger const kSuccessResponseStatusCode = 0;

typedef NS_ENUM(NSInteger, EHttpRequestTypes) {
    EHttpRequestTypeGET = 0,
    EHttpRequestTypePOST = 1
};

@interface XGHttpManager ()
@property (nonatomic,strong) AFHTTPRequestOperationManager *httpManager;
@end

@implementation XGHttpManager

+ (XGHttpManager *)sharedManager
{
    static XGHttpManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:kHostUrl()]];
    });
    return _sharedManager;
}

- (instancetype)initWithBaseURL:(NSURL *)baseURL
{
    if (self = [super init]) {
        self.httpManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
        self.httpManager.responseSerializer.acceptableContentTypes
        = [self.httpManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        NSString *appId = @"11111";
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        NSString *uaString = [NSString stringWithFormat:@"deviceId=%@&version=%@&appid=%@&fromId=2000505&model=%@&osName=%@ %@", kUUIDString(), [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"], appId, platform, [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]];
        [self.httpManager.requestSerializer setValue:uaString forHTTPHeaderField:@"User-Agent"];
    }
    return self;
}

- (void)getRequestForPath:(NSString *)urlPath parameters:(NSDictionary *)parameters successBlock:(HttpRequestSucceededBlock)success failBlock:(HttpRequestFailedBlock)failure
{
    [self getOrPostRequestForPath:urlPath parameters:parameters successBlock:success failBlock:failure method:EHttpRequestTypeGET];
}

- (void)postRequestForPath:(NSString *)urlPath parameters:(NSDictionary *)parameters successBlock:(HttpRequestSucceededBlock)success failBlock:(HttpRequestFailedBlock)failure
{
    [self getOrPostRequestForPath:urlPath parameters:parameters successBlock:success failBlock:failure method:EHttpRequestTypePOST];
}

- (void)getOrPostRequestForPath:(NSString *)urlPath parameters:(NSDictionary *)parameters successBlock:(HttpRequestSucceededBlock)success failBlock:(HttpRequestFailedBlock)failure method:(EHttpRequestTypes)type
{
//    NSMutableDictionary *parametersWithUserIdAndTicketIfHave = [self addUserIdentityInfoIfHaveToParamenter:parameters];
    void (^successBlock) (AFHTTPRequestOperation *, id) = ^void(AFHTTPRequestOperation *operation, id responseObject){
        NSDictionary *responseJson = responseObject;
//        PTInvokeBlock(success,responseJson);
        if (responseJson[@"status"] && [responseJson[@"status"] integerValue] == kSuccessResponseStatusCode) {
            PTInvokeBlock(success,responseObject[@"data"]);
        } else if (responseObject[@"message"]) {
            PTInvokeBlock(failure,responseObject[@"message"]);
        } else {
            PTInvokeBlock(failure,kServerErrorMessage);
        }
    };
    void (^failureBlock)(AFHTTPRequestOperation *, NSError *) = ^void(AFHTTPRequestOperation *operation, NSError *error) {
        if (error.code == NSURLErrorCannotConnectToHost || error.code == NSURLErrorNetworkConnectionLost || error.code == NSURLErrorNotConnectedToInternet) {
            PTInvokeBlock(failure,kNetworkErrorMessage);
        } else if(error.code == NSURLErrorTimedOut) {
            PTInvokeBlock(failure,kNetworkUnstableMessage);
        } else if (operation.response.statusCode >= 500 && operation.response.statusCode < 600) {
            PTInvokeBlock(failure,kServerErrorMessage);
        } else {
            PTInvokeBlock(failure,error.localizedDescription);
        }
    };
    switch (type) {
        case EHttpRequestTypeGET:
        {
            [self.httpManager GET:urlPath parameters:parameters success:successBlock failure:failureBlock];
        }
            break;
        case EHttpRequestTypePOST:
        {
            [self.httpManager POST:urlPath parameters:parameters success:successBlock failure:failureBlock];
        }
        default:
            break;
    }
}

- (void)postWithFormDataForPath:(NSString *)urlPath
                      imageData:(NSData *)imageData
                     parameters:(NSDictionary *)parameters
                   successBlock:(HttpRequestSucceededBlock)success
                      failBlock:(HttpRequestFailedBlock)failure
                  progressBlock:(HttpRequestProgressBlock)progress;
{
//    NSMutableDictionary *parametersWithUserIdAndTicketIfHave = [self addUserIdentityInfoIfHaveToParamenter:parameters];
    void (^successBlock) (AFHTTPRequestOperation *, id) = ^void(AFHTTPRequestOperation *operation, id responseObject){
        NSDictionary *responseJson = responseObject;
        if (responseJson[@"status"] && responseJson[@"status"][@"code"] && [responseJson[@"status"][@"code"] integerValue] == kSuccessResponseStatusCode) {
            PTInvokeBlock(success,responseJson[@"data"]);
        } else if (responseJson[@"status"][@"msg"]) {
            PTInvokeBlock(failure,responseJson[@"status"][@"msg"]);
        } else {
            PTInvokeBlock(failure,kServerErrorMessage);
        }
    };
    void (^failureBlock)(AFHTTPRequestOperation *, NSError *) = ^void(AFHTTPRequestOperation *operation, NSError *error) {
        if (error.code == NSURLErrorCannotConnectToHost || error.code == NSURLErrorNetworkConnectionLost || error.code == NSURLErrorNotConnectedToInternet) {
            PTInvokeBlock(failure,kNetworkErrorMessage);
        } else if(error.code == NSURLErrorTimedOut) {
            PTInvokeBlock(failure,kNetworkUnstableMessage);
        } else if (operation.response.statusCode >= 500 && operation.response.statusCode < 600) {
            PTInvokeBlock(failure,kServerErrorMessage);
        } else {
            PTInvokeBlock(failure,error.localizedDescription);
        }
    };
    void (^progressBlock)(AFHTTPRequestOperation *, float percent) = ^void(AFHTTPRequestOperation *operation, float percent) {
        PTInvokeBlock(progress,percent);
    };
    
    [self.httpManager POST:urlPath parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSString *filename = @"data.jpg";
        NSString *mimeType = @"image/jpeg";
        [formData appendPartWithFileData:imageData
                                    name:@"data"
                                fileName:filename
                                mimeType:mimeType];
    } success:successBlock failure:failureBlock progress:progressBlock];
}

//- (NSMutableDictionary *)addUserIdentityInfoIfHaveToParamenter:(NSDictionary *)parameters
//{
//    NSMutableDictionary *parametersWithUserIdAndTicketIfHave = [NSMutableDictionary dictionary];
//    if ([XGCurrentUserManager sharedInstance].userItem) {
//        if ([XGCurrentUserManager sharedInstance].userItem.userID) {
//            [parametersWithUserIdAndTicketIfHave setObject:[XGCurrentUserManager sharedInstance].userItem.userID forKey:@"userId"];
//            if ([PTCurrentUserManager sharedInstance].userItem.ticket) {
//                [parametersWithUserIdAndTicketIfHave setObject:[PTCurrentUserManager sharedInstance].userItem.ticket forKey:@"ticket"];
//            }
//        }
//    }
//    [parametersWithUserIdAndTicketIfHave addEntriesFromDictionary:parameters];
//    if ([PTCurrentUserManager sharedInstance].userItem.udk) {
//        NSArray *sortedKeys = [parametersWithUserIdAndTicketIfHave.allKeys sortedArrayUsingSelector:@selector(compare:)];
//        NSMutableString *mString = [[PTCurrentUserManager sharedInstance].userItem.udk mutableCopy];
//        for (NSInteger i=0; i<sortedKeys.count; i++) {
//            NSString *key = sortedKeys[i];
//            if (i > 0) {
//                [mString appendString:@","];
//            }
//            [mString appendFormat:@"%@=%@", key, parametersWithUserIdAndTicketIfHave[key]];
//        }
//        NSString *reqString;
//        reqString = (mString.length > 100) ? [mString substringToIndex:100] : [mString copy];
//        [parametersWithUserIdAndTicketIfHave setObject:[reqString MD5Digest] forKey:@"sig"];
//    }
//    return parametersWithUserIdAndTicketIfHave;
//}
@end
