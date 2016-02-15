//
//  XGMyHomepageIncomeCell.m
//  BiuLiCai
//
//  Created by Owen on 15/5/25.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import "XGMyHomepageIncomeCell.h"
#import "XGAccountItem.h"

@implementation XGMyHomepageIncomeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configData:(XGAccountItem *)item
{
    self.stockValue.text = [NSString stringWithFormat:@"%.2f",item.stockValue];
    self.account.text = [NSString stringWithFormat:@"%.2f",item.stockAccount];
    self.earnRate.text = [NSString stringWithFormat:@"%.2f%%",item.earnRate];
    self.cash.text = [NSString stringWithFormat:@"%.2f",item.cash];
}

@end
