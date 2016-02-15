//
//  XGStockIncomeViewController.m
//  XGCG
//
//  Created by Owen on 15/4/30.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGStockIncomeViewController.h"
#import "XGBuyStockViewController.h"
#import "XGHttpManager+stockDetail.h"
#import "XGPersonItem.h"
#import "XGStockInfoItem.h"
#import "XGStockIncomeCell.h"

@interface XGStockIncomeViewController()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *tableViewHeader;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (nonatomic,assign) BOOL hasMore;
@property (nonatomic,strong) NSMutableArray *incomeList;
@property (nonatomic,strong) XGStockInfoItem *stockInfo;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *stockPrice;
@property (weak, nonatomic) IBOutlet UILabel *stockName;
@property (weak, nonatomic) IBOutlet UILabel *stockID;
@property (weak, nonatomic) IBOutlet UILabel *stockUpDown;
@property (weak, nonatomic) IBOutlet UILabel *stockUpDownPercent;
@property (nonatomic,strong) UIView *topView;
@end

@implementation XGStockIncomeViewController
+(instancetype)getInstance
{
    return [[UIStoryboard storyboardWithName:@"XGStockDetailViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"XGStockIncomeViewController"];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [((XGMainViewController *)self.navigationController.parentViewController) hideTabBar];
    self.tableViewHeader.backgroundColor = [UIColor hexColor:0x2c2a31];
    [self.buyButton setBackgroundImage:[UIImage imageWithColor:[UIColor hexColor:0xfc594b]] forState:UIControlStateNormal];
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.contentOffset.y, self.tableView.width, 0)];
    self.topView.backgroundColor = self.tableViewHeader.backgroundColor;
    [self.view addSubview:self.topView];
    self.incomeList = [NSMutableArray array];
    [self requestData];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)requestData
{
    __weak __typeof(self) weakSelf = self;
    [MBProgressHUD showLoadingHUDOnView:self.view message:nil animated:YES];
    [[XGHttpManager sharedManager] getStockIncomeList:@"600010" successBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        [weakSelf loadData:responseObject];
    } failBlock:^(NSString *errorMessage) {
        [MBProgressHUD showTimedDetailsTextHUDOnView:weakSelf.view message:errorMessage animated:YES];
    }];
}

-(void)loadData:(id)data
{
    self.hasMore = data[@"topList"][@"hasMore"];
    NSArray *tops = data[@"topList"][@"tops"];
    for (int i = 0; i < tops.count; i ++) {
        XGPersonItem *item = [XGPersonItem getInstanceWithDictionary:tops[i]];
        [self.incomeList addObject:item];
    }
    self.stockInfo = [XGStockInfoItem getInstanceWithDictionary:data[@"stock_info"]];
    self.stockID.text = [NSString stringWithFormat:@"%ld",self.stockInfo.stockID.longValue];
    self.stockName.text = self.stockInfo.stockName;
    self.stockPrice.text = [NSString stringWithFormat:@"%.2f",self.stockInfo.stockPrice];
    if (self.stockInfo.stockUpdown >= 0.0) {
        self.stockUpDown.text = [NSString stringWithFormat:@"+%.2f",self.stockInfo.stockUpdown];
        self.stockUpDown.textColor = kXGStockRizeTextColor;
    } else {
        self.stockUpDown.text = [NSString stringWithFormat:@"%.2f",self.stockInfo.stockUpdown];
        self.stockUpDown.textColor = kXGStockfallTextColor;
    }
    if (self.stockInfo.stockUpdownRate >= 0.0) {
        self.stockUpDownPercent.text = [NSString stringWithFormat:@"+%.2f%%",self.stockInfo.stockUpdownRate];
        self.stockUpDown.textColor = kXGStockRizeTextColor;
    } else {
        self.stockUpDownPercent.text = [NSString stringWithFormat:@"%.2f%%",self.stockInfo.stockUpdownRate];
        self.stockUpDown.textColor = kXGStockfallTextColor;
    }
    

    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.incomeList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XGStockIncomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StockIncomeCell" forIndexPath:indexPath];
    [cell configData:self.incomeList[indexPath.row] index:indexPath.row];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y <= 0) {
        self.topView.height = -scrollView.contentOffset.y;
    } else {
        self.topView.height = 0;
    }
}
- (IBAction)didTapBuyButton:(id)sender {
    [self.navigationController pushViewController:[XGBuyStockViewController getInstance] animated:YES];
}

- (IBAction)didTapBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didTapShareButton:(id)sender {
}
@end
