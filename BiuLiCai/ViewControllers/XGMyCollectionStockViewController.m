//
//  XGMyCollectionStockViewController.m
//  XGCG
//
//  Created by Owen on 15/5/9.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGMyCollectionStockViewController.h"
#import "XGMyCollectionStockHeaderView.h"
#import "XGStockDetailViewController.h"
#import "XGStockInfoItem.h"
#import "XGHttpManager+stockDetail.h"
#import "XGMyCollectionCell.h"

@interface XGMyCollectionStockViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, assign) BOOL hasMore;
@property(nonatomic,strong) NSMutableArray *stocks;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet XGSearchTextField *textField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldRight;
@end

@implementation XGMyCollectionStockViewController
+(instancetype)getInstance
{
    return [[UIStoryboard storyboardWithName:@"XGSimulateStockViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"XGMyCollectionStockViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = false;
    [((XGMainViewController *)self.navigationController.parentViewController) hideTabBar];
    self.stocks = [NSMutableArray array];
    [self.textField.rightView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearAction)]];
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)requestData
{
    __weak __typeof(self) weakSelf = self;
    [MBProgressHUD showLoadingHUDOnView:self.view message:nil animated:YES];
    [[XGHttpManager sharedManager] getMyCollectionStockWithSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        [weakSelf loadData:responseObject];
    } failBlock:^(NSString *errorMessage) {
        [MBProgressHUD showTimedDetailsTextHUDOnView:weakSelf.view message:errorMessage animated:YES];
    }];
}

-(void)loadData:(id)data
{
    self.hasMore = data[@"stockList"][@"more"];
    NSArray *array = data[@"stockList"][@"stocks"];
    for (int i = 0; i < array.count; i ++) {
        XGStockInfoItem *item = [XGStockInfoItem getInstanceWithDictionary:array[i]];
        [self.stocks addObject:item];
    }
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stocks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XGMyCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"optionalShareCell" forIndexPath:indexPath];
    [cell configData:self.stocks[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 42;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [XGMyCollectionStockHeaderView getInstance];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.navigationController pushViewController:[XGStockDetailViewController getInstance] animated:YES];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
}

- (void)keyboardWillHide:(NSNotification *)notification
{
}

- (void)clearAction
{
    self.textField.text = @"";
}

- (IBAction)didTapCancelButton:(id)sender {
    [self.textField resignFirstResponder];
}

@end
