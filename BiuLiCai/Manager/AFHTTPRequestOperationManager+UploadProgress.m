//
//  AFHTTPRequestOperationManager+UploadProgress.m
//  XGCG
//
//  Created by Owen on 15/4/26.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "AFHTTPRequestOperationManager+UploadProgress.h"

@implementation AFHTTPRequestOperationManager (UploadProgress)
- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                        progress:(void (^)(AFHTTPRequestOperation *operation, float percent))progress
{
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:nil];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    
    __weak __typeof(operation)weakOperation = operation;
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        float percent = 0.0f;
        if (totalBytesExpectedToWrite > 0) {
            percent = (float)totalBytesWritten / (float)totalBytesExpectedToWrite;
        }
        NSLog(@"%@ >>>>>>>>>> UploadProgress: %.2f %%\n",URLString, percent*100);
        if (progress) {
            progress(weakOperation, percent);
        }
    }];
    
    [self.operationQueue addOperation:operation];
    
    return operation;
}
@end
