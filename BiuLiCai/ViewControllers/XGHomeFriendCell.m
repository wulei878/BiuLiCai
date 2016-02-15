//
//  XGHomeFriendCell.m
//  XGCG
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGHomeFriendCell.h"
#import "XGWeiboFriendItem.h"

@implementation XGHomeFriendCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configData:(XGWeiboFriendItem *)item index:(NSInteger)index
{
    [self.userHeaderView sd_setImageWithURL:item.friendHeaderURL placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",rand()%3]]];
    [self.userHeaderView clipsToRound];
    self.userName.text = item.friendName;
    self.rank.text = [NSString stringWithFormat:@"%ld",index+1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configMyData
{
    [self.userHeaderView sd_setImageWithURL:[NSURL URLWithString:[XGCurrentUserManager sharedInstance].userItem.account.iconURL] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",rand()%3]]];
    [self.userHeaderView clipsToRound];
    self.userName.text = [XGCurrentUserManager sharedInstance].userItem.account.userName;
    self.rank.text = @"1";
}

@end
