//
//  XGMyHoldingItem.h
//  XGCG
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGBaseItem.h"

@interface XGMyHoldingItem : XGBaseItem
@property(nonatomic,copy)NSString *stockID;
@property(nonatomic,strong)NSNumber *income;
@property(nonatomic,strong)NSNumber *holdCount;
@property(nonatomic,strong)NSNumber *price;
@property(nonatomic,copy)NSString *stockName;
@end
