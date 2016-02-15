//
//  XGPersonalSettingViewController.m
//  XGCG
//
//  Created by Owen on 15/4/30.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGPersonalSettingViewController.h"
#import "XGLoginViewController.h"
#import "UMSocial.h"

@interface XGPersonalSettingViewController ()
@property (weak, nonatomic) IBOutlet UIButton *quitButton;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation XGPersonalSettingViewController
+ (instancetype)getInstance
{
    return [[UIStoryboard storyboardWithName:@"XGProfileViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"XGPersonalSettingViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.quitButton setBackgroundImage:[XGUtility kXGImageWithColor:[XGUtility kXGHexColor:0xfc594b]] forState:UIControlStateNormal];
    [((XGMainViewController *)self.navigationController.parentViewController) hideTabBar];
    self.nameLabel.text = [XGCurrentUserManager sharedInstance].userItem.account.userName;
    self.name.text = self.nameLabel.text;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[XGCurrentUserManager sharedInstance].userItem.account.iconURL] placeholderImage:[UIImage imageNamed:@"avatar_0"]];
    [self.headerImageView clipsToRound];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 33)];
    view.backgroundColor = [XGUtility kXGHexColor:0xf8f8f8];
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 1)];
    topLine.backgroundColor = [UIColor hexColor:0xf0f0f0];
    [view addSubview:topLine];

    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 33;
}
- (IBAction)didTapQuitButton:(id)sender {
    [MBProgressHUD showLoadingHUDOnView:self.view message:nil animated:YES];
    [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [[XGCurrentUserManager sharedInstance].weiboFriends removeAllObjects];
        [XGCurrentUserManager sharedInstance].userItem.account = nil;
        [self.navigationController presentViewController:[XGLoginViewController getInstance] animated:YES completion:nil];
    }];
}
- (IBAction)didTapBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
