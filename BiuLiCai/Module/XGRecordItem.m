//
//  XGRecordItem.m
//  XGCG
//
//  Created by Owen on 15/5/22.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGRecordItem.h"

@implementation XGRecordItem
+(instancetype)getInstanceWithDictionary:(NSDictionary *)dictionary
{
    XGRecordItem *item = [[XGRecordItem alloc] init];
    item.stockID = dictionary[@"stock_id"];
    item.stockName = dictionary[@"stock_name"];
    item.volume = @([dictionary[@"volumn"] integerValue]);
    item.recordID = dictionary[@"record_id"];
    item.deal = [dictionary[@"deal"] floatValue];
    item.price = [dictionary[@"price"] floatValue];
    item.operationType = [dictionary[@"op_type"] integerValue];
    item.operationTime = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"op_time"] longLongValue]];
    item.status = [dictionary[@"status"] integerValue];
    return item;
}
@end