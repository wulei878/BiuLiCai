//
//  XGBuyStockViewController.m
//  XGCG
//
//  Created by Owen on 15/5/9.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGBuyStockViewController.h"

#import "XGHttpManager+stockDetail.h"
#import "XGStockInfoItem.h"

@interface XGBuyStockViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UITableView *marketTableView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *amountButtons;
@property (nonatomic,strong) XGStockInfoItem *stockInfo;
@property (nonatomic,strong) NSArray *buyFiveMarket;
@property (nonatomic,strong) NSArray *sellFiveMarket;
@property (weak, nonatomic) IBOutlet UILabel *maxBuyAmount;
@property (nonatomic,assign) NSInteger maxBuy;
@property (weak, nonatomic) IBOutlet UITextField *stockName;
@property (weak, nonatomic) IBOutlet UITextField *stockId;
@property (weak, nonatomic) IBOutlet UILabel *stockUpDown;
@property (weak, nonatomic) IBOutlet UILabel *stockUpDownRate;
@end

@implementation XGBuyStockViewController

+ (instancetype)getInstance
{
    return [[UIStoryboard storyboardWithName:@"XGSimulateStockViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"XGBuyStockViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [((XGMainViewController *)self.navigationController.parentViewController) hideTabBar];
    [self.buyButton setBackgroundImage:[UIImage imageWithColor:[UIColor hexColor:0xfc594b]] forState:UIControlStateNormal];
    self.buyButton.layer.masksToBounds = YES;
    self.buyButton.layer.cornerRadius = self.buyButton.height / 2;
    self.buyFiveMarket = [NSArray array];
    [self requestData];
}

-(void)requestData
{
    __weak __typeof(self) weakSelf = self;
    [MBProgressHUD showLoadingHUDOnView:self.view message:nil animated:YES];
    [[XGHttpManager sharedManager] getBuyInInfo:@"600010" successBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        [weakSelf loadData:responseObject];
    } failBlock:^(NSString *errorMessage) {
        [MBProgressHUD showTimedDetailsTextHUDOnView:weakSelf.view message:errorMessage animated:YES];
    }];
}

-(void)loadData:(id)data
{
    self.stockInfo = [XGStockInfoItem getInstanceWithDictionary:data[@"stock_info"]];
    self.stockName.text = self.stockInfo.stockName;
    self.stockId.text = [NSString stringWithFormat:@"%ld",[self.stockInfo.stockID integerValue]];
    self.price.text = [NSString stringWithFormat:@"%.2f",self.stockInfo.stockPrice];
    self.stockUpDownRate.text = [NSString stringWithFormat:@"%.2f%%",self.stockInfo.stockUpdownRate];
    self.buyFiveMarket = data[@"stock_info"][@"buy_list"];
    self.sellFiveMarket = data[@"stock_info"][@"sell_list"];
    self.maxBuy = [data[@"max_sell_out"] integerValue];
    self.maxBuyAmount.text = [NSString stringWithFormat:@"最大可买%ld",self.maxBuy];
    self.priceLabel.text = self.price.text;
    [self.marketTableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.marketTableView) {
        return self.buyFiveMarket.count;
    }
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.marketTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sellStockCell" forIndexPath:indexPath];
        for (UILabel *view in cell.contentView.subviews) {
            switch (view.tag) {
                case 1:
                    view.text = [NSString stringWithFormat:@"%.2f",[self.buyFiveMarket[indexPath.row][0] floatValue]];
                    break;
                case 2:
                    view.text = [NSString stringWithFormat:@"%ld",[self.buyFiveMarket[indexPath.row][1] integerValue]];
                    break;
                case 3:
                    view.text = [NSString stringWithFormat:@"%.2f",[self.sellFiveMarket[indexPath.row][0] floatValue]];
                    break;
                case 4:
                    view.text = [NSString stringWithFormat:@"%ld",[self.sellFiveMarket[indexPath.row][1] integerValue]];
                    break;
                case 5:
                    view.text = [NSString stringWithFormat:@"买%ld",indexPath.row+1];
                    break;
                case 6:
                    view.text = [NSString stringWithFormat:@"卖%ld",indexPath.row+1];
                default:
                    break;
            }
        }
        return cell;
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.marketTableView) {
        return 15;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didTapPriceMinusButton:(id)sender {
    Float64 price = [self.priceLabel.text floatValue];
    if (price == 0.0) {
        return;
    }
    price -= 0.01;
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f",price];
}

- (IBAction)didTapPricePlusButton:(id)sender {
    Float64 price = [self.priceLabel.text floatValue];
    price += 0.01;
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f",price];
}

- (IBAction)didTapAmountMinusButton:(id)sender {
    NSInteger amount = [self.amountLabel.text integerValue];
    if (amount == 0) {
        return;
    }
    amount -= 100;
    self.amountLabel.text = [NSString stringWithFormat:@"%ld",(long)amount];
}

- (IBAction)didTapAmountPlusButton:(id)sender {
    NSInteger amount = [self.amountLabel.text integerValue];
    amount += 100;
    if (amount > self.maxBuy) {
        return;
    }
    self.amountLabel.text = [NSString stringWithFormat:@"%ld",(long)amount];
}
- (IBAction)didTapHalfButton:(UIButton *)sender {
    for (UIButton *button in self.amountButtons) {
        if (button == sender) {
            button.selected = YES;
        } else {
            button.selected = NO;
        }
    }
    NSInteger amount = [self.amountLabel.text integerValue];
    amount = self.maxBuy / 2;
    self.amountLabel.text = [NSString stringWithFormat:@"%ld",(long)amount];
}
- (IBAction)didTapQuarterButton:(UIButton *)sender {
    for (UIButton *button in self.amountButtons) {
        if (button == sender) {
            button.selected = YES;
        } else {
            button.selected = NO;
        }
    }
    NSInteger amount = [self.amountLabel.text integerValue];
    amount = self.maxBuy / 4;
    self.amountLabel.text = [NSString stringWithFormat:@"%ld",(long)amount];
}
- (IBAction)didTapAllButton:(UIButton *)sender {
    for (UIButton *button in self.amountButtons) {
        if (button == sender) {
            button.selected = YES;
        } else {
            button.selected = NO;
        }
    }
    NSInteger amount = [self.amountLabel.text integerValue];
    amount = self.maxBuy;
    self.amountLabel.text = [NSString stringWithFormat:@"%ld",(long)amount];
}
@end
