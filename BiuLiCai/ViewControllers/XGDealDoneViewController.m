//
//  XGDealDoneViewController.m
//  XGCG
//
//  Created by Owen on 15/5/9.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGDealDoneViewController.h"
#import "XGMyHoldingViewController.h"

@interface XGDealDoneViewController ()
@property (weak, nonatomic) IBOutlet UIButton *checkMyHolding;

@end

@implementation XGDealDoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [((XGMainViewController *)self.navigationController.parentViewController) hideTabBar];
    [self.checkMyHolding setBackgroundImage:[UIImage imageWithColor:[UIColor hexColor:0xfc594b]] forState:UIControlStateNormal];
    self.checkMyHolding.layer.masksToBounds = YES;
    self.checkMyHolding.layer.cornerRadius = self.checkMyHolding.height / 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)checkMyHoldingAction:(id)sender {
    [self.navigationController pushViewController:[XGMyHoldingViewController getInstance] animated:YES];
}

@end
