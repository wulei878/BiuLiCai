//
//  XGChampionItem.m
//  XGCG
//
//  Created by Owen on 15/4/26.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGChampionItem.h"

@implementation XGChampionItem
+(instancetype)getInstanceWithDictionary:(NSDictionary *)dictionary
{
    XGChampionItem *item = [[XGChampionItem alloc] init];
    item.name = dictionary[@"user_name"];
    item.headIconUrl = [NSURL URLWithString:dictionary[@"user_headicon"]];
    item.userLevel = @([dictionary[@"user_level"] integerValue]);
    item.userSign = dictionary[@"user_sign"];
    item.todayROIRatio = [dictionary[@"user_stock_up"] floatValue];
    return item;
}
@end
