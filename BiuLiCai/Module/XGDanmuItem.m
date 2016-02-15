//
//  XGDanmuItem.m
//  XGCG
//
//  Created by Owen on 15/4/29.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGDanmuItem.h"

@implementation XGDanmuItem
+(instancetype)getInstanceWithDictionary:(NSDictionary *)dictionary
{
    XGDanmuItem *item = [[XGDanmuItem alloc] init];
    item.content = dictionary[@"content"];
    item.contentTime = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"content_time"] doubleValue]];
    return item;
}
@end
