//
//  XGStockDetailHeaderView.h
//  XGCG
//
//  Created by Owen on 15/5/16.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol XGStockDetailHeaderViewDelegate;
@class XGStockInfoItem;
@interface XGStockDetailHeaderView : UIView<PTFactoryProtocol>
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *buttonLeadingConstraints;
@property (weak, nonatomic) IBOutlet UIView *kLineContainerView;
@property (weak, nonatomic) IBOutlet UIView *volumeContainerView;
@property (weak, nonatomic) IBOutlet UIView *danmuContainerView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *chartButtons;
@property (weak, nonatomic) IBOutlet UILabel *stockPrice;
@property (weak, nonatomic) IBOutlet UILabel *increasePrice;
@property (weak, nonatomic) IBOutlet UILabel *increasePercentage;
@property (weak, nonatomic) IBOutlet UIButton *danmuButton;
@property (weak, nonatomic) IBOutlet UILabel *todayOpeningPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *yesterdayClosingPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;
@property (weak, nonatomic) IBOutlet UILabel *turnoverRateLabel;
@property (weak, nonatomic) IBOutlet UIView *chartButtonContainer;
@property (nonatomic,weak)id <XGStockDetailHeaderViewDelegate> delegate;
-(void)addKLineView;
-(void)configData:(XGStockInfoItem *)item;
@end
@protocol XGStockDetailHeaderViewDelegate <NSObject>

-(void)didTapChartButton:(UIButton *)sender;
-(void)didTapDanmuSwitchButton:(UIButton *)sender;

@end