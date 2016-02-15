//
//  XGAccountItem.m
//  BiuLiCai
//
//  Created by Owen on 15/5/25.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "XGAccountItem.h"

@implementation XGAccountItem
+(instancetype)getInstanceWithDictionary:(NSDictionary *)dictionary
{
    XGAccountItem *item = [[XGAccountItem alloc] init];
    item.stockAccount = [dictionary[@"account"]?:@0 floatValue];
    item.stockValue = [dictionary[@"stock_value"]?:@0 floatValue];
    item.earnRate = [dictionary[@"earn_rate"]?:@0 floatValue];
    item.cash = [dictionary[@"cash"]?:@0 floatValue];
    item.earnValue = [dictionary[@"earn"]?:@0 floatValue];
    return item;
}
@end