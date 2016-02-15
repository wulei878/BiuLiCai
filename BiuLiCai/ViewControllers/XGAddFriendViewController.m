//
//  XGAddFriendViewController.m
//  XGCG
//
//  Created by Owen on 15/5/8.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGAddFriendViewController.h"
#import "XGAddFriendCell.h"
#import "XGMyHomePageViewController.h"
#import "XGWeiboFriendItem.h"

@interface XGAddFriendViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *tipsView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation XGAddFriendViewController
+ (instancetype)getInstance
{
    return [[UIStoryboard storyboardWithName:@"XGFeedViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"XGAddFriendViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [((XGMainViewController *)self.navigationController.parentViewController) hideTabBar];
    [self requestFriendsData];
}

- (void)requestFriendsData {
    [MBProgressHUD showLoadingHUDOnView:self.view message:nil animated:YES];
    [[UMSocialDataService defaultDataService] requestSnsFriends:UMShareToSina completion:^(UMSocialResponseEntity *response) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self configFriendsData:response];
    }];
}

- (void)configFriendsData:(UMSocialResponseEntity *)response {
    [XGCurrentUserManager sharedInstance].weiboFriends = [NSMutableArray array];
    [response.data enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *friendID = key;
        NSDictionary *dic = obj;
        XGWeiboFriendItem *item = [[XGWeiboFriendItem alloc] initWithFriendID:friendID dictionary:dic];
        [[XGCurrentUserManager sharedInstance].weiboFriends addObject:item];
    }];
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [XGCurrentUserManager sharedInstance].weiboFriends ? [XGCurrentUserManager sharedInstance].weiboFriends.count : 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 42;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XGAddFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendCell" forIndexPath:indexPath];
    [cell configData:[XGCurrentUserManager sharedInstance].weiboFriends[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    XGMyHomePageViewController *viewController = [XGMyHomePageViewController getInstance];
    viewController.userID = @"1";
    [self.navigationController pushViewController:viewController animated:YES];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 42)];
    view.backgroundColor = [UIColor hexColor:0xf8f8f8];
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor hexColor:0x999999];
    label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
    label.text = @"可能感兴趣的人";
    [label sizeToFit];
    label.left = 15;
    label.centerY = view.height / 2;
    label.top += 4;
    [view addSubview:label];
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 1)];
    topLine.backgroundColor = [UIColor hexColor:0xf0f0f0];
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, view.height - 1, view.width, 1)];
    bottomLine.backgroundColor = [UIColor hexColor:0xf0f0f0];
    [view addSubview:topLine];
    [view addSubview:bottomLine];
    return view;
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)closeTipsAction:(id)sender {
    self.tipsView.hidden = YES;
    self.tableView.tableHeaderView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
