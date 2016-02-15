//
//  XGHttpManager+stockDetail.m
//  XGCG
//
//  Created by Owen on 15/4/29.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGHttpManager+stockDetail.h"
#import "XGFileInfo.h"

@implementation XGHttpManager (stockDetail)
-(void)requestStockDetail:(NSString *)stockId successBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock
{
    [self getRequestForPath:@"gupiaoxiangqing" parameters:@{@"sid":stockId} successBlock:^(id responseObject) {
        PTInvokeBlock(successBlock,responseObject);
    } failBlock:failBlock];
}

-(void)requestStockDetailForLandscape:(NSString *)stockId successBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock
{
    [self getRequestForPath:@"hengpingxiangqing" parameters:@{@"sid":stockId} successBlock:^(id responseObject) {
        PTInvokeBlock(successBlock,responseObject);
    } failBlock:failBlock];
}

-(void)requestStockInfo:(NSString *)stockId successBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock
{
    [self getRequestForPath:@"stock" parameters:@{@"sid":stockId} successBlock:^(id responseObject) {
        PTInvokeBlock(successBlock,responseObject);
    } failBlock:failBlock];
}

-(void)requestDanmuList:(NSDictionary *)parameters successBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock
{
    [self getRequestForPath:@"stock/danmuList" parameters:nil successBlock:^(id responseObject) {
        PTInvokeBlock(successBlock,responseObject[@"danmuList"][@"danmu"]);
    } failBlock:failBlock];
}

-(void)requestChampionInfo:(NSDictionary *)parameters successBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock
{
    [self getRequestForPath:@"stock/championInfo" parameters:nil successBlock:^(id responseObject) {
        PTInvokeBlock(successBlock,responseObject[@"leizhu"]);
    } failBlock:failBlock];
}

-(void)requestRecordListWithSuccessBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock
{
    [self getRequestForPath:@"chedan" parameters:@{@"uid":@2} successBlock:^(id responseObject) {
        PTInvokeBlock(successBlock,responseObject[@"recordList"]);
    } failBlock:failBlock];
}

-(void)sendDanmu:(NSDictionary *)param successBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock
{
    [self getRequestForPath:@"send_danmu" parameters:param successBlock:^(id responseObject) {
        PTInvokeBlock(successBlock,responseObject);
    } failBlock:failBlock];
}

-(void)getMyHoldingListWithSuccessBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock
{
    [self getRequestForPath:@"chicangqingkuang" parameters:@{@"uid":@1} successBlock:^(id responseObject) {
        PTInvokeBlock(successBlock,responseObject);
    } failBlock:failBlock];
}

-(void)getStockIncomeList:(NSString *)stockID successBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock
{
    [self getRequestForPath:@"gegushouyibang" parameters:@{@"sid":stockID} successBlock:^(id responseObject) {
        PTInvokeBlock(successBlock,responseObject);
    } failBlock:failBlock];
}

-(void)getBuyInInfo:(NSString *)stockID successBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock
{
    [self getRequestForPath:@"buyin" parameters:@{@"sid":stockID,@"uid":@1} successBlock:^(id responseObject) {
        PTInvokeBlock(successBlock,responseObject);
    } failBlock:failBlock];
}

-(void)getSellOutInfo:(NSString *)stockID successBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock
{
    [self getRequestForPath:@"sellout" parameters:@{@"sid":stockID,@"uid":@1} successBlock:^(id responseObject) {
        PTInvokeBlock(successBlock,responseObject);
    } failBlock:failBlock];
}

-(void)getMyCollectionStockWithSuccessBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock
{
    [self getRequestForPath:@"zixuangu" parameters:@{@"uid":@1} successBlock:^(id responseObject) {
        PTInvokeBlock(successBlock,responseObject);
    } failBlock:failBlock];
}

-(void)getStockAccountWithSuccessBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock
{
    [self getRequestForPath:@"monijiaoyi" parameters:@{@"uid":@1} successBlock:^(id responseObject) {
        PTInvokeBlock(successBlock,responseObject);
    } failBlock:failBlock];
}

-(void)checkAllStockVersionWithSuccessBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock
{
    NSString *filePath = [XGFileInfo filePathWithString:kAllStockList];
    [self getRequestForPath:@"stock_all_version" parameters:nil successBlock:^(id responseObject) {
        NSString *version = responseObject[@"version"];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
        if (!dic || !dic[version]) {
            dic = [NSMutableDictionary dictionary];
            [self getRequestForPath:@"stock_all" parameters:nil successBlock:^(id responseObject) {
                NSArray *stockList = responseObject[@"stock_list"];
                PTInvokeBlock(successBlock,stockList);
                [dic setObject:stockList forKey:version];
                [dic writeToFile:filePath atomically:true];
            } failBlock:failBlock];
        } else {
            PTInvokeBlock(successBlock,dic[version]);
        }
    } failBlock:failBlock];
}

-(void)getAllStockWithSuccessBlock:(HttpRequestSucceededBlock)successBlock failBlock:(HttpRequestFailedBlock)failBlock
{
    [self getRequestForPath:@"stock_all" parameters:nil successBlock:^(id responseObject) {
        PTInvokeBlock(successBlock,responseObject);
    } failBlock:failBlock];
}
@end
