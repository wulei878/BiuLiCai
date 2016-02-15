//
//  XGStockCommentCell.m
//  XGCG
//
//  Created by Owen on 15/4/27.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGStockCommentCell.h"
#import "XGChampionItem.h"
#import "UIImageView+WebCache.h"

@implementation XGStockCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)configChampionData:(XGChampionItem *)data
{
    [self.headIconImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"avatar_%d",rand()%3]]];
    self.nameLabel.text = data.name;
    self.incomeLabel.text = [NSString stringWithFormat:@"%.2f",data.todayROIRatio];
    self.commentLabel.text = data.userSign;
}
@end
