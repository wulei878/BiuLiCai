//
//  XGMessageListViewController.m
//  XGCG
//
//  Created by Owen on 15/4/30.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGMessageListViewController.h"

@interface XGMessageListViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation XGMessageListViewController
+ (instancetype)getInstance
{
    return [[UIStoryboard storyboardWithName:@"XGIMListViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"XGMessageListViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = kXGNavigationBarTintColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: kXGNavigationBarTextColor};
    [((XGMainViewController *)self.navigationController.parentViewController) hideTabBar];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell" forIndexPath:indexPath];
    return cell;
}
- (IBAction)didTapBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
