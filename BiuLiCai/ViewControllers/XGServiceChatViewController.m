//
//  XGServiceChatViewController.m
//  XGCG
//
//  Created by Owen on 15/5/17.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGServiceChatViewController.h"

@interface XGServiceChatViewController ()

@end

@implementation XGServiceChatViewController
+(instancetype)getInstance
{
    return [[UIStoryboard storyboardWithName:@"XGIMListViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"XGServiceChatViewController"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [(XGMainViewController *)(self.navigationController.parentViewController) hideTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
