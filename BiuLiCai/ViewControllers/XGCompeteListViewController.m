//
//  XGCompeteListViewController.m
//  XGCG
//
//  Created by Owen on 15/5/12.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGCompeteListViewController.h"
#import "XGCompeteViewController.h"

@interface XGCompeteListViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation XGCompeteListViewController
+ (instancetype)getInstance
{
    return [[UIStoryboard storyboardWithName:@"XGCompeteViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"XGCompeteListViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    self.navigationController.navigationBarHidden = false;
    [(XGMainViewController *)(self.navigationController.parentViewController) showTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"competeListCell" forIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.navigationController pushViewController:[XGCompeteViewController getInstance] animated:YES];
}

@end
