//
//  XGMyCollectionCell.m
//  BiuLiCai
//
//  Created by Owen on 15/5/24.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "XGMyCollectionCell.h"
#import "XGStockInfoItem.h"

@implementation XGMyCollectionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configData:(XGStockInfoItem *)item
{
    self.stockName.text = item.stockName;
    self.stockId.text = [NSString stringWithFormat:@"%ld",(long)[item.stockID integerValue]];
    self.stockPrice.text = [NSString stringWithFormat:@"%.2f",item.stockPrice];
    self.stockUpDownRate.text = [NSString stringWithFormat:@"%.2f%%",item.stockUpdownRate];
}

@end
