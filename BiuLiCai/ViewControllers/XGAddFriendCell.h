//
//  XGAddFriendCell.h
//  XGCG
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XGWeiboFriendItem;
@interface XGAddFriendCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userHeadView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userIncomeRate;
- (void)configData:(XGWeiboFriendItem *)item;
@end
