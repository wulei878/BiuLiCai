//
//  XGCompeteViewController.m
//  XGCG
//
//  Created by Owen on 15/5/1.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGCompeteViewController.h"
#import "XGMyHomePageViewController.h"

@interface XGCompeteViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UIView *bottomView;
@end

@implementation XGCompeteViewController
+ (instancetype)getInstance
{
    return [[UIStoryboard storyboardWithName:@"XGCompeteViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"XGCompeteViewController"];
}


- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = false;
    [(XGMainViewController *)(self.navigationController.parentViewController) hideTabBar];
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    bottomView.backgroundColor = [UIColor whiteColor];
    UIButton *competeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 145, 28)];
    competeButton.centerX = bottomView.width / 2;
    competeButton.centerY = bottomView.height / 2;
    competeButton.layer.masksToBounds = YES;
    [competeButton setBackgroundImage:[UIImage imageWithColor:[UIColor hexColor:0xfc594b]] forState:UIControlStateNormal];
    competeButton.layer.cornerRadius = competeButton.height / 2;
    [competeButton setTitle:@"立即参赛" forState:UIControlStateNormal];
    [competeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    competeButton.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
    bottomView.bottom = self.view.height;
    competeButton.alpha = 1;
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bottomView.width, 1)];
    seperator.backgroundColor = [UIColor hexColor:0xe4e5e6];
    [bottomView addSubview:seperator];
    [self.view addSubview:bottomView];
    [bottomView addSubview:competeButton];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"competeCell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        if (view.tag == 1) {
            UILabel *label = (UILabel *)view;
            label.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    XGMyHomePageViewController *viewController = [XGMyHomePageViewController getInstance];
    viewController.userID = @"1";
    [self.navigationController pushViewController:viewController animated:YES];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
