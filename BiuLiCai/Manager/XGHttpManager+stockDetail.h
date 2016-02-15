//
//  XGHttpManager+stockDetail.h
//  XGCG
//
//  Created by Owen on 15/4/29.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGHttpManager.h"

@interface XGHttpManager (stockDetail)
-(void)requestStockInfo:(NSString *)stockId successBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock;
-(void)requestDanmuList:(NSDictionary *)parameters successBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock;
-(void)requestChampionInfo:(NSDictionary *)parameters successBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock;
-(void)requestRecordListWithSuccessBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock;
-(void)sendDanmu:(NSDictionary *)param successBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock;
-(void)getMyHoldingListWithSuccessBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock;
-(void)getStockIncomeList:(NSString *)stockID successBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock;
-(void)getBuyInInfo:(NSString *)stockID successBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock;
-(void)getSellOutInfo:(NSString *)stockID successBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock;
-(void)getMyCollectionStockWithSuccessBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock;
-(void)requestStockDetail:(NSString *)stockId successBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock;
-(void)requestStockDetailForLandscape:(NSString *)stockId successBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock;
-(void)getStockAccountWithSuccessBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock;
-(void)checkAllStockVersionWithSuccessBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock;
@end
