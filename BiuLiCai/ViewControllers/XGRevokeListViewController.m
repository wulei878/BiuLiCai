//
//  XGRevokeListViewController.m
//  XGCG
//
//  Created by Owen on 15/4/29.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGRevokeListViewController.h"
#import "XGRevokeTableViewCell.h"
#import "XGRecordItem.h"
#import "XGHttpManager+stockDetail.h"
#import "XGBuyStockViewController.h"

@interface XGRevokeListViewController ()<UITableViewDataSource,UITableViewDelegate,XGRevokeTableViewCellDelegate>
@property(nonatomic,strong)NSMutableArray *recordList;
@property(nonatomic,assign)BOOL hasMore;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation XGRevokeListViewController
+ (instancetype)getInstance
{
    return [[UIStoryboard storyboardWithName:@"XGSimulateStockViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"XGRevokeListViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [((XGMainViewController *)self.navigationController.parentViewController) hideTabBar];
    self.recordList = [NSMutableArray array];
    [self requestData];
}
- (IBAction)didTapBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)requestData
{
    __weak __typeof(self) weakSelf = self;
    [MBProgressHUD showLoadingHUDOnView:self.view message:nil animated:YES];
    [[XGHttpManager sharedManager] requestRecordListWithSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        [weakSelf loadData:responseObject];
    } failBlock:^(NSString *errorMessage) {
        [MBProgressHUD showTimedDetailsTextHUDOnView:weakSelf.view message:errorMessage animated:YES];
    }];
}

-(void)loadData:(id)data
{
    self.hasMore = data[@"hasMore"];
    NSArray *array = data[@"records"];
    for (int i = 0; i < array.count; i ++) {
        XGRecordItem *item = [XGRecordItem getInstanceWithDictionary:array[i]];
        [self.recordList addObject:item];
    }
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recordList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XGRevokeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"revokeCell" forIndexPath:indexPath];
    [cell configData:self.recordList[indexPath.row]];
    cell.delegate = self;
    return cell;
}

-(void)didTapBuyButton:(XGRevokeTableViewCell *)cell
{
    [self.navigationController pushViewController:[XGBuyStockViewController getInstance] animated:YES];
}

-(void)didTapRevokeButton:(XGRevokeTableViewCell *)cell
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
