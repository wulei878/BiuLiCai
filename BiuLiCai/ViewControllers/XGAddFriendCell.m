//
//  XGAddFriendCell.m
//  XGCG
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGAddFriendCell.h"
#import "XGWeiboFriendItem.h"

@implementation XGAddFriendCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)configData:(XGWeiboFriendItem *)item
{
    [self.userHeadView sd_setImageWithURL:item.friendHeaderURL placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"avatar_%d",rand()%3]]];
    [self.userHeadView clipsToRound];
    self.userName.text = item.friendName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
