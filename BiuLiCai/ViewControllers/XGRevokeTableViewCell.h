//
//  XGRevokeTableViewCell.h
//  XGCG
//
//  Created by Owen on 15/4/29.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XGRecordItem;
@protocol XGRevokeTableViewCellDelegate;

@interface XGRevokeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *stockName;
@property (weak, nonatomic) IBOutlet UILabel *stockNumber;
@property (weak, nonatomic) IBOutlet UILabel *buyTime;
@property (weak, nonatomic) IBOutlet UIButton *revokeButton;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UILabel *dealPrice;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *revokeLabel;
@property (nonatomic, strong) XGRecordItem *recordItem;
@property (nonatomic,weak) id <XGRevokeTableViewCellDelegate> delegate;
- (void)configData:(XGRecordItem *)item;
@end

@protocol XGRevokeTableViewCellDelegate <NSObject>

-(void)didTapBuyButton:(XGRevokeTableViewCell *)cell;
-(void)didTapRevokeButton:(XGRevokeTableViewCell *)cell;
@end
