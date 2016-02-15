//
//  XGMyHomepageIncomeCell.h
//  BiuLiCai
//
//  Created by Owen on 15/5/25.
//  Copyright (c) 2015年 Owen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XGAccountItem;
@interface XGMyHomepageIncomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *earnRate;
@property (weak, nonatomic) IBOutlet UILabel *account;
@property (weak, nonatomic) IBOutlet UILabel *cash;
@property (weak, nonatomic) IBOutlet UILabel *stockValue;
-(void)configData:(XGAccountItem *)item;
@end
