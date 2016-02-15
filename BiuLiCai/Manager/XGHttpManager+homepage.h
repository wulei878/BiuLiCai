//
//  XGHttpManager+homepage.h
//  XGCG
//
//  Created by Owen on 15/4/26.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGHttpManager.h"

@interface XGHttpManager (homepage)
-(void)requestMyHomepageInfoWithSuccessBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock;
-(void)requestHomepageInfo:(NSNumber *)userId successBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock;
@end
