//
//  XGTradingRecordViewController.m
//  XGCG
//
//  Created by Owen on 15/4/30.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGTradingRecordViewController.h"


@interface XGTradingRecordViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation XGTradingRecordViewController
+ (instancetype)getInstance
{
    return [[UIStoryboard storyboardWithName:@"XGSimulateStockViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"XGTradingRecordViewController"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [((XGMainViewController *)self.navigationController.parentViewController) hideTabBar];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tradingRecordCell" forIndexPath:indexPath];
    return cell;
}
- (IBAction)didTapBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
