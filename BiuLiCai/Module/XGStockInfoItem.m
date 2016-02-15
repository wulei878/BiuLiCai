//
//  XGStockInfoItem.m
//  XGCG
//
//  Created by Owen on 15/4/29.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGStockInfoItem.h"

@implementation XGStockInfoItem
+(instancetype)getInstanceWithDictionary:(NSDictionary *)dictionary
{
    XGStockInfoItem *item = [[XGStockInfoItem alloc] init];
    item.stockID = @([dictionary[@"stock_id"]?:@0 longLongValue]);
    item.stockName = dictionary[@"stock_name"];
    item.stockPrice = [dictionary[@"stock_price"]?:@0 floatValue];
    item.stockUpdown = [dictionary[@"updown"]?:@0 floatValue];
    item.stockUpdownRate = [dictionary[@"updown_percent"]?:@0 floatValue];
    item.todayStart = [dictionary[@"today_start"]?:@0 floatValue];
    item.yesterdayEnd = [dictionary[@"yesterday_end"]?:@0 floatValue];
    item.volume = @([dictionary[@"volumn"]?:@0 floatValue]);
    item.change = @([dictionary[@"change_rate"]?:@0 floatValue]);
    item.stockPinyin = dictionary[@"stock_pinyin"];
    item.date = dictionary[@"datetime"]? [NSDate dateWithTimeIntervalSince1970:[dictionary[@"datetime"] longLongValue]] : [NSDate date];
    item.minimumPrice = [dictionary[@"min"]?:@0 floatValue];
    item.maximumPrice = [dictionary[@"max"]?:@0 floatValue];
    item.stockType = dictionary[@"stock_type"];
    return item;
}
@end
