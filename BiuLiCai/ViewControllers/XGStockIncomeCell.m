//
//  XGStockIncomeCell.m
//  XGCG
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGStockIncomeCell.h"
#import "XGPersonItem.h"

@implementation XGStockIncomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)configData:(XGPersonItem *)item index:(NSInteger)index
{
    [self.userHeadView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"avatar_%d",rand()%3]]];
    self.rank.text = [NSString stringWithFormat:@"%ld",index+1];
    self.rate.text = [NSString stringWithFormat:@"%@%%",item.rate];
    self.userName.text = item.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
