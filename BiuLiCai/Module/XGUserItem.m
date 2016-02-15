//
//  XGUserItem.m
//  XGCG
//
//  Created by Owen on 15/4/26.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGUserItem.h"

@implementation XGUserItem
+(instancetype)getInstanceWithDictionary:(NSDictionary *)dictionary
{
    XGUserItem *item = [[XGUserItem alloc] init];
    item.name = dictionary[@"user_name"];
    item.monthUpdownRate = [dictionary[@"month_updown_rate"]?:@0 floatValue];
    item.followCount = [dictionary[@"guanzhu"]?:@0 integerValue];
    item.flower = [dictionary[@"flower"]?:@0 integerValue];
    item.fans = [dictionary[@"fensi"]?:@0 integerValue];
    item.collectionCount = [dictionary[@"stock_num"]?:@0 integerValue];
    return item;
}
@end