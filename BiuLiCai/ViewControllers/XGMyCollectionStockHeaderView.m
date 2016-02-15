//
//  XGMyCollectionStockHeaderView.m
//  XGCG
//
//  Created by Owen on 15/5/9.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGMyCollectionStockHeaderView.h"

@implementation XGMyCollectionStockHeaderView
+(instancetype)getInstance
{
    return [[UINib nibWithNibName:@"XGMyCollectionStockHeaderView" bundle:nil] instantiateWithOwner:nil options:nil].firstObject;
}

@end
