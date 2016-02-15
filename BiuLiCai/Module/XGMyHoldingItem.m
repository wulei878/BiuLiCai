//
//  XGMyHoldingItem.m
//  XGCG
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGMyHoldingItem.h"

@implementation XGMyHoldingItem
+(instancetype)getInstanceWithDictionary:(NSDictionary *)dictionary
{
    XGMyHoldingItem *item = [[XGMyHoldingItem alloc] init];
    item.stockID = dictionary[@"stock_id"];
    item.stockName = dictionary[@"stock_name"];
    item.holdCount = @([dictionary[@"hold_num"] integerValue]);
    item.income = @([dictionary[@"income"] floatValue]);
    item.price =  @([dictionary[@"price"] floatValue]);
    return item;
    
}
@end