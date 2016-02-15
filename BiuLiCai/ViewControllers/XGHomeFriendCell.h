//
//  XGHomeFriendCell.h
//  XGCG
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XGWeiboFriendItem;
@interface XGHomeFriendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userRate;
@property (weak, nonatomic) IBOutlet UILabel *rank;
- (void)configData:(XGWeiboFriendItem *)item index:(NSInteger)index;
- (void)configMyData;
@end
