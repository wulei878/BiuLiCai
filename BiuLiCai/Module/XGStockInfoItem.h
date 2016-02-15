//
//  XGStockInfoItem.h
//  XGCG
//
//  Created by Owen on 15/4/29.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGBaseItem.h"

@interface XGStockInfoItem : XGBaseItem
@property(nonatomic,assign)NSNumber *stockID;
@property(nonatomic,copy)NSString *stockName;
@property(nonatomic,assign)float stockPrice;
@property(nonatomic,assign)float stockUpdown;
@property(nonatomic,assign)float stockUpdownRate;
@property(nonatomic,assign)float todayStart;
@property(nonatomic,assign)float yesterdayEnd;
@property(nonatomic,strong)NSNumber *volume; //成交量
@property(nonatomic,strong)NSNumber *change; //换手率
@property(nonatomic,copy)NSString *stockPinyin;
@property(nonatomic,strong)NSArray *fiveQuotation;
@property(nonatomic,strong)NSDate *date;
@property(nonatomic,assign)float minimumPrice;
@property(nonatomic,assign)float maximumPrice;
@property(nonatomic,copy) NSString *stockType;
@end