//
//  XGPersonItem.m
//  XGCG
//
//  Created by Owen on 15/4/26.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGPersonItem.h"

@implementation XGPersonItem
+(instancetype)getInstanceWithDictionary:(NSDictionary *)dictionary
{
    XGPersonItem *item = [[XGPersonItem alloc] init];
    item.name = dictionary[@"uname"];
    item.headIconUrl = [NSURL URLWithString:dictionary[@"upic"]];
    item.rate = @([dictionary[@"rate"]?:@0 floatValue]);
    item.level = @([dictionary[@"level"]?:@0 integerValue]);
    return item;
}
@end