//
//  XGPersonItem.h
//  XGCG
//
//  Created by Owen on 15/4/26.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGBaseItem.h"

@interface XGPersonItem : XGBaseItem
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSURL *headIconUrl;
@property(nonatomic,assign)Float64 todayROIRatio;
@property(nonatomic,strong)NSNumber *userLevel;
@property(nonatomic,copy)NSString *userSign;
@property(nonatomic,strong)NSString *userID;
@property(nonatomic,strong)NSNumber *rate;
@property(nonatomic,strong)NSNumber *level;
@end