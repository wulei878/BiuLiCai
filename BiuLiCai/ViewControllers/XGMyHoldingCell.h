//
//  XGMyHoldingCell.h
//  XGCG
//
//  Created by Owen on 15/5/23.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XGMyHoldingItem;
@interface XGMyHoldingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *stockName;
@property (weak, nonatomic) IBOutlet UILabel *stockId;
@property (weak, nonatomic) IBOutlet UILabel *stockPrice;
@property (weak, nonatomic) IBOutlet UILabel *holdCount;
@property (weak, nonatomic) IBOutlet UILabel *income;
- (void)configData:(XGMyHoldingItem *)item;
@end
