//
//  XGMyHoldingCell.m
//  XGCG
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGMyHoldingCell.h"
#import "XGMyHoldingItem.h"

@implementation XGMyHoldingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configData:(XGMyHoldingItem *)item {
    self.stockName.text = item.stockName;
    self.stockId.text = item.stockID;
    self.stockPrice.text = [NSString stringWithFormat:@"%.2f",item.price.floatValue];
    self.holdCount.text = [NSString stringWithFormat:@"%@",item.holdCount];
    self.income.text = [NSString stringWithFormat:@"%.2f",item.income.floatValue];
}

@end
