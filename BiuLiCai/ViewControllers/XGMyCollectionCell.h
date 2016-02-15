//
//  XGMyCollectionCell.h
//  BiuLiCai
//
//  Created by Owen on 15/5/24.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XGStockInfoItem;
@interface XGMyCollectionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *stockName;
@property (weak, nonatomic) IBOutlet UILabel *stockId;
@property (weak, nonatomic) IBOutlet UILabel *stockPrice;
@property (weak, nonatomic) IBOutlet UILabel *stockUpDownRate;
- (void)configData:(XGStockInfoItem *)item;
@end
