//
//  XGStockIncomeCell.h
//  XGCG
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XGPersonItem;
@interface XGStockIncomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userHeadView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *rate;
@property (weak, nonatomic) IBOutlet UILabel *rank;
- (void)configData:(XGPersonItem *)item index:(NSInteger)index;
@end
