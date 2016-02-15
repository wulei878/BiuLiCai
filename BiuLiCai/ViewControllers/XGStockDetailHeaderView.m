//
//  XGStockDetailHeaderView.m
//  XGCG
//
//  Created by Owen on 15/5/16.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGStockDetailHeaderView.h"
#import "Lines.h"
#import "XGStockInfoItem.h"

static CGFloat kStockChartButtonWidth = 48;
static CGFloat kChartVolumeLineWidth = 2;
@implementation XGStockDetailHeaderView
+(instancetype)getInstance
{
    return [[UINib nibWithNibName:@"XGStockDetailHeaderView" bundle:nil] instantiateWithOwner:nil options:nil].firstObject;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = kXGNavigationBarTintColor;
    [self addChartButtons];
    for (UIButton *button in self.chartButtons) {
        if (button.tag == 1) {
            button.selected = YES;
            break;
        }
    }
}

- (void)configData:(XGStockInfoItem *)item
{
    self.stockPrice.text = [NSString stringWithFormat:@"%.2f",item.stockPrice];
    if (item.stockUpdown >= 0.0) {
        self.increasePrice.text = [NSString stringWithFormat:@"+%.2f",item.stockUpdown];
        self.increasePrice.textColor = kXGStockRizeTextColor;
    } else {
        self.increasePrice.text = [NSString stringWithFormat:@"%.2f",item.stockUpdown];
        self.increasePrice.textColor = kXGStockfallTextColor;
    }
    if (item.stockUpdownRate >= 0.0) {
        self.increasePercentage.text = [NSString stringWithFormat:@"+%.2f%%",item.stockUpdownRate];
        self.increasePercentage.textColor = kXGStockRizeTextColor;
    } else {
        self.increasePercentage.text = [NSString stringWithFormat:@"%.2f%%",item.stockUpdownRate];
        self.increasePercentage.textColor = kXGStockfallTextColor;
    }
    self.todayOpeningPriceLabel.text = [NSString stringWithFormat:@"%.2f",item.todayStart];
    self.yesterdayClosingPriceLabel.text = [NSString stringWithFormat:@"%.2f",item.yesterdayEnd];
    self.volumeLabel.text = [NSString stringWithFormat:@"%.2f",[item.volume floatValue]/10000.0];
    self.turnoverRateLabel.text = [NSString stringWithFormat:@"%.2f",[item.change floatValue]];
}

-(void)addChartButtons
{
    CGFloat spacing = (self.chartButtonContainer.width - kStockChartButtonWidth * 5) / 4;
    for (NSLayoutConstraint *constraint in self.buttonLeadingConstraints) {
        constraint.constant = spacing;
    }
    [self setNeedsUpdateConstraints];
}

-(void)addKLineView
{
    Lines *kLines = [[Lines alloc] initWithFrame:self.kLineContainerView.bounds];
    kLines.userInteractionEnabled = YES;
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i < SCREEN_WIDTH / 5; i++) {
        NSString *string = [NSString stringWithFormat:@"{%d,%ld}",i * 5,rand() % (NSInteger)self.kLineContainerView.height];
        [array addObject:string];
    }
    kLines.points = array;
    kLines.color = 0xa599d3;
    [self.kLineContainerView addSubview:kLines];
    Lines *volumeLines = [[Lines alloc] initWithFrame:self.volumeContainerView.bounds];
    NSMutableArray *myArray = [NSMutableArray array];
    for (int i=0;i < SCREEN_WIDTH / kChartVolumeLineWidth / 2;i ++) {
        NSString *heightString = [NSString stringWithFormat:@"{%f,%ld}",(i * kChartVolumeLineWidth * 2),rand() % (NSInteger)self.volumeContainerView.height];
        NSString *lowString = [NSString stringWithFormat:@"{%f,%f}",(i * kChartVolumeLineWidth * 2),self.volumeContainerView.height];
        NSString *openString = lowString;
        NSString *closeString = lowString;
        [myArray addObject:@[heightString,lowString,openString,closeString]];
    }
    volumeLines.points = myArray;
    volumeLines.color = 0x747083;
    volumeLines.isK = YES;
    volumeLines.isVol = YES;
    volumeLines.lineWidth = 2;
    [self.volumeContainerView addSubview:volumeLines];
    Lines *lastDayCloseLine = [[Lines alloc] initWithFrame:self.kLineContainerView.bounds];
    NSString *startPoint = [NSString stringWithFormat:@"{%d,%f}",0,self.kLineContainerView.height /2];
    NSString *endPoint = [NSString stringWithFormat:@"{%f,%f}",SCREEN_WIDTH,self.kLineContainerView.height / 2];
    lastDayCloseLine.points = @[startPoint,endPoint];
    lastDayCloseLine.color = 0xe26356;
    lastDayCloseLine.isDotted = YES;
    lastDayCloseLine.lineWidth = 2;
    [self.kLineContainerView addSubview:lastDayCloseLine];
}

- (IBAction)didTapChartButton:(UIButton *)sender {
    sender.selected = YES;
    for (UIButton *button in self.chartButtons) {
        if (sender.tag != button.tag) {
            button.selected = NO;
        }
    }
    if ([self.delegate respondsToSelector:@selector(didTapChartButton:)]) {
        [self.delegate didTapChartButton:sender];
    }
}
- (IBAction)didTapDanmuSwitchButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didTapDanmuSwitchButton:)]) {
        [self.delegate didTapDanmuSwitchButton:sender];
    }
}
@end
