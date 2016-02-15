//
//  XGMyHoldingViewController.m
//  XGCG
//
//  Created by Owen on 15/4/29.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGMyHoldingViewController.h"
#import "XGHttpManager+stockDetail.h"
#import "XGMyHoldingItem.h"
#import "XGMyHoldingCell.h"

@interface XGMyHoldingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *myHoldingList;
@property(nonatomic,copy)NSString *marketValue;
@property(nonatomic,assign)BOOL hasMore;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation XGMyHoldingViewController
+(instancetype)getInstance
{
    return [[UIStoryboard storyboardWithName:@"XGSimulateStockViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"XGMyHoldingViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = false;
    [((XGMainViewController *)self.navigationController.parentViewController) hideTabBar];
    self.myHoldingList = [NSMutableArray array];
    [self requestData];
}

- (void)requestData{
    [MBProgressHUD showLoadingHUDOnView:self.view message:nil animated:YES];
    [[XGHttpManager sharedManager] getMyHoldingListWithSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self loadData:responseObject];
    } failBlock:^(NSString *errorMessage) {
        [MBProgressHUD showTimedDetailsTextHUDOnView:self.view message:errorMessage animated:YES];
    }];
}

- (void)loadData:(id)data{
    self.marketValue = [NSString stringWithFormat:@"%ld",[data[@"current_total"] integerValue]];
    self.hasMore = data[@"cangList"][@"more"];
    NSArray *array = data[@"cangList"][@"cangs"];
    for (NSDictionary *dic in array) {
        XGMyHoldingItem *item = [XGMyHoldingItem getInstanceWithDictionary:dic];
        [self.myHoldingList addObject:item];
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myHoldingList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XGMyHoldingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myHoldingCell" forIndexPath:indexPath];
    [cell configData:self.myHoldingList[indexPath.row]];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 41)];
    view.backgroundColor = [XGUtility kXGHexColor:0xf8f8f8];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"当前持仓";
    titleLabel.textColor = [XGUtility kXGHexColor:0x2c2a31];
    titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
    [titleLabel sizeToFit];
    titleLabel.left = 15;
    UILabel *marketValueLabel = [[UILabel alloc] init];
    marketValueLabel.text = @"最新市值";
    marketValueLabel.textColor = titleLabel.textColor;
    marketValueLabel.font = titleLabel.font;
    [marketValueLabel sizeToFit];
    marketValueLabel.left = tableView.width - 80 - marketValueLabel.width;
    UILabel *marketValue = [[UILabel alloc] init];
    marketValue.text = self.marketValue;
    marketValue.textColor = [XGUtility kXGHexColor:0xff5845];
    marketValue.font = [UIFont fontWithName:@"DIN Alternate" size:12];
    [marketValue sizeToFit];
    marketValue.left = marketValueLabel.right;
    titleLabel.centerY = view.height / 2;
    titleLabel.top += 4;
    marketValueLabel.centerY = titleLabel.centerY;
    marketValue.centerY = titleLabel.centerY;
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, view.height - 1, view.width, 1)];
    bottomLine.backgroundColor = [UIColor hexColor:0xf0f0f0];
    [view addSubview:bottomLine];
    [view addSubview:titleLabel];
    [view addSubview:marketValue];
    [view addSubview:marketValueLabel];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 41;
}
- (IBAction)didTapBackButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
