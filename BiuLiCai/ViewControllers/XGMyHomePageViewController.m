//
//  XGMyHomePageViewController.m
//  XGCG
//
//  Created by Owen on 15/4/30.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGMyHomePageViewController.h"
#import "XGHttpManager+homepage.h"
#import "XGUserItem.h"
#import "XGStockInfoItem.h"
#import "XGMyHomepageFeedCell.h"
#import "XGMyHomepageIncomeCell.h"
#import "RMShareToWeiBoManager.h"

@interface XGMyHomePageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *tableViewHeader;
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)XGUserItem *userItem;
@property(nonatomic,strong)XGStockInfoItem *stock;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;
@property (weak, nonatomic) IBOutlet UILabel *followLabel;
@property (nonatomic,strong) UIView *topView;
@end

@implementation XGMyHomePageViewController
+ (instancetype)getInstance
{
    return [[UIStoryboard storyboardWithName:@"XGMyHomePageViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"XGMyHomePageViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [((XGMainViewController *)self.navigationController.parentViewController) hideTabBar];
    if ([self.userID isEqualToString:[XGCurrentUserManager sharedInstance].userItem.account.usid] || !self.userID) {
        self.isMyself = YES;
    } else {
        self.isMyself = NO;
    }
//    self.view.backgroundColor = kXGNavigationBarTintColor;
    self.tableViewHeader.backgroundColor = kXGNavigationBarTintColor;
//    self.tableView.backgroundColor = self.view.backgroundColor;
    [self.headerView clipsToRound];
    self.headerView.layer.borderWidth = 2;
    self.headerView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.contentOffset.y, self.tableView.width, 0)];
    self.topView.backgroundColor = self.tableViewHeader.backgroundColor;
    [self.view addSubview:self.topView];
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)requestData
{
    __weak __typeof(self) weakSelf = self;
    [MBProgressHUD showLoadingHUDOnView:self.view message:nil animated:YES];
    if (self.isMyself) {
        [[XGHttpManager sharedManager] requestMyHomepageInfoWithSuccessBlock:^(id responseObject) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
            [weakSelf loadData:responseObject];
        } failBlock:^(NSString *errorMessage) {
            [MBProgressHUD showTimedDetailsTextHUDOnView:weakSelf.view message:errorMessage animated:YES];
        }];
    } else {
        [[XGHttpManager sharedManager] requestHomepageInfo:@1 successBlock:^(id responseObject) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
            [weakSelf loadData:responseObject];
        } failBlock:^(NSString *errorMessage) {
            [MBProgressHUD showTimedDetailsTextHUDOnView:weakSelf.view message:errorMessage animated:YES];
        }];
    }
}

-(void)loadData:(id)data
{
    self.userItem = [XGUserItem getInstanceWithDictionary:data[@"user_info"]];
    self.userItem.accountItem = [XGAccountItem getInstanceWithDictionary:data[@"account_info"]];
    self.stock = [XGStockInfoItem getInstanceWithDictionary:data[@"stock_info"]];
    if (self.isMyself) {
        self.nameLabel.text = [XGCurrentUserManager sharedInstance].userItem.account.userName;
        [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[XGCurrentUserManager sharedInstance].userItem.account.iconURL] placeholderImage:[UIImage imageNamed:@"avatar_0"]];
    } else {
        [self.headerImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"avatar_%d",rand()%3]]];
        self.nameLabel.text = self.userItem.name;
    }

    self.fansLabel.text = [NSString stringWithFormat:@"%ld",self.userItem.fans];
    self.followLabel.text = [NSString stringWithFormat:@"%ld",self.userItem.followCount];
    self.collectionCountLabel.text = [NSString stringWithFormat:@"%ld",self.userItem.collectionCount];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y <= 0) {
        self.topView.height = -scrollView.contentOffset.y;
    } else {
        self.topView.height = 0;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        XGMyHomepageIncomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inComeCell" forIndexPath:indexPath];
        [cell configData:self.userItem.accountItem];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homepageCell" forIndexPath:indexPath];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    } else {
        return 116;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 41;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 41)];
    view.backgroundColor = [UIColor hexColor:0xf8f8f8];
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor hexColor:0x2C2A31];
    label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
    if (section == 0) {
        label.text = @"股票收益";
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow"]];
        imageView.centerY = view.height / 2;
        imageView.left = view.width - imageView.width - 15;
        [view addSubview:imageView];
    } else {
        label.text = @"动态";
    }
    [label sizeToFit];
    label.left = 15;
    label.centerY = view.height / 2;
    label.top -= 3;
    [view addSubview:label];
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, view.height - 1, tableView.width, 1)];
    bottomLine.backgroundColor = [UIColor hexColor:0xf0f0f0];
    [view addSubview:bottomLine];
    return view;
}

- (IBAction)didTapBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didTapShareButton:(id)sender {
    RMShareObject *object = [[RMShareObject alloc] init];
    object.title = @"Biu~Biu~Biu";
    object.shareContentType = ShareContentTypeText;
    object.detailContent = @"并没有什么卵用";
    [[RMShareToWeiBoManager sharedInstance] shareWithShareObject:object completion:^(NSInteger errorNumber, NSDictionary *userInfo) {
        if (errorNumber == 0) {
            [MBProgressHUD showTimedDetailsTextHUDOnView:self.view message:@"分享成功" animated:YES];
        }
    }];
}
@end
