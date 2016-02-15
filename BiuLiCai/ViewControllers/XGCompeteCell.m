//
//  XGCompeteCell.m
//  XGCG
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGCompeteCell.h"

@implementation XGCompeteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userAvatarView.image = [UIImage imageNamed:[NSString stringWithFormat:@"avatar_%d",rand()%3]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
