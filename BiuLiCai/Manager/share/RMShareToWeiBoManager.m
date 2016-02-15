//
//  RMShareToWeiBoManager.m
//  MiMi-iOS
//
//  Created by 史良 on 14-4-25.
//  Copyright (c) 2014年 Renren Inc. All rights reserved.
//

#import "RMShareToWeiBoManager.h"

@interface RMShareToWeiBoManager ()

@property (nonatomic, copy)ShareCompletion shareCompletion;
@property (nonatomic, strong)RMShareObject *shareObject;

@end

@implementation RMShareToWeiBoManager

+ (instancetype)sharedInstance
{
    static RMShareToWeiBoManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)shareWithShareObject:(RMShareObject *)shareObject
                  completion:(ShareCompletion)shareCompletion
{
    self.shareCompletion = shareCompletion;
    self.shareObject = shareObject;
    if ([WeiboSDK isWeiboAppInstalled] && self.shareObject) {
        WBMessageObject *message = [WBMessageObject message];
        if (!shareObject.linkURL.length) {
            shareObject.linkURL = @"";
        }
        if (shareObject.shareContentType == ShareContentTypeImageAndText
            || shareObject.shareContentType == ShareContentTypeImage) {
            WBImageObject *imageObject = [WBImageObject object];
            imageObject.imageData = UIImageJPEGRepresentation(shareObject.imageData, (CGFloat)1.0);
            message.imageObject = imageObject;
            message.text = [NSString stringWithFormat:@"%@ %@", shareObject.detailContent, shareObject.linkURL];
        } else {
            message.text = [NSString stringWithFormat:@"%@ %@", shareObject.detailContent, shareObject.linkURL];
        }
        WBSendMessageToWeiboRequest *weiboRequest = [WBSendMessageToWeiboRequest requestWithMessage:message];
        [WeiboSDK sendRequest:weiboRequest];
    }
    else {
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        request.redirectURI = @"http://sns.whalecloud.com/sina2/callback";
        request.scope = @"all";
        [WeiboSDK sendRequest:request];
    }
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([WeiboSDK isWeiboAppInstalled] && self.shareObject) {
        NSString *value = @"已发送";
        if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]) {
            switch (response.statusCode) {
                case WeiboSDKResponseStatusCodeUserCancel:
                    value = @"用户取消发送";
                    break;
                case WeiboSDKResponseStatusCodeSentFail:
                    value = @"发送失败";
                    break;
                case WeiboSDKResponseStatusCodeAuthDeny:
                    value = @"授权失败";
                    break;
                case WeiboSDKResponseStatusCodeUserCancelInstall:
                    value = @"用户取消安装微博客户端";
                    break;
                case WeiboSDKResponseStatusCodeUnsupport:
                    value = @"不支持的请求";
                    break;
                case WeiboSDKResponseStatusCodeUnknown:
                    value = @"发送失败";
                    break;
                default:
                    break;
            }
        }
        if ([value isEqualToString:@"已发送"]) {
            if (self.shareCompletion) {
                self.shareCompletion(0, nil);
            }
        } else {
            if (self.shareCompletion) {
                self.shareCompletion(-1, response.userInfo);
            }
        }
    }
    else {
        [self didreceiveSSOResponse:response];
    }
}

- (void)didreceiveSSOResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            NSString *userId = [(WBAuthorizeResponse *)response userID];
           // RMCurrentUser.weiboID = userId.longLongValue;
           // [[RMLoginManager instance] saveCurrentUserInfo];
            NSString *accessToken = [(WBAuthorizeResponse *)response accessToken];
            [self shareWeiboWithBlog:accessToken];
            if (self.shareCompletion) {
                self.shareCompletion(0, @{@"userId":userId, @"token":accessToken});
            }
        }
        else {
            if (self.shareCompletion) {
                self.shareCompletion(-1, response.userInfo);
            }
        }
    }
}

- (void)shareWeiboWithBlog:(NSString *)token
{
    NSString * content = self.shareObject.detailContent;
    NSData *imageData =  UIImageJPEGRepresentation(self.shareObject.imageData, 1.0);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:content,@"status", @"0",@"visible", imageData, @"pic", nil];
    [WBHttpRequest requestWithAccessToken:token url:@"https://api.weibo.com/2/statuses/upload.json" httpMethod:@"POST" params:dic delegate:nil withTag:@"bibi"];
}
@end
