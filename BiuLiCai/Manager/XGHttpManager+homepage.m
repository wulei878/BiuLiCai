//
//  XGHttpManager+homepage.m
//  XGCG
//
//  Created by Owen on 15/4/26.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGHttpManager+homepage.h"

@implementation XGHttpManager (homepage)
-(void)requestMyHomepageInfoWithSuccessBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock
{
    [self getRequestForPath:@"wodezhuye" parameters:@{@"uid":@1} successBlock:successBlock failBlock:failBlock];
}

-(void)requestHomepageInfo:(NSNumber *)userId successBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock
{
    [self getRequestForPath:@"tadezhuye" parameters:@{@"uid":userId,@"self_uid":@2} successBlock:successBlock failBlock:failBlock];
}
@end
