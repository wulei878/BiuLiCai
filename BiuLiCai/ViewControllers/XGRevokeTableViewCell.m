//
//  XGRevokeTableViewCell.m
//  XGCG
//
//  Created by Owen on 15/4/29.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGRevokeTableViewCell.h"
#import "XGRecordItem.h"

@implementation XGRevokeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.revokeLabel.text = @"撤\n单";
}

- (void)configData:(XGRecordItem *)item {
    self.stockName.text = item.stockName;
    self.stockNumber.text = item.stockID;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    self.buyTime.text = [formatter stringFromDate:item.operationTime];
    self.price.text = [NSString stringWithFormat:@"%.2f",item.price];
    self.amount.text = item.volume.stringValue;
    self.dealPrice.text = [NSString stringWithFormat:@"%.2f",item.deal];
    switch (item.status) {
        case ERecordStatusCanceled:
            self.state.text = @"已取消";
            break;
        case ERecordStatusCompleted:
            self.state.text = @"已完成";
            break;
            case ERecordStatusInProcess:
            self.state.text = @"进行中";
        default:
            break;
    }

    self.recordItem = item;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)didTapBuyButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didTapBuyButton:)]) {
        [self.delegate didTapBuyButton:self];
    }
}
- (IBAction)didTapRevokeButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didTapRevokeButton:)]) {
        [self.delegate didTapRevokeButton:self];
    }
}

@end
