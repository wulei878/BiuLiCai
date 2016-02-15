//
//  XGLoginViewController.m
//  XGCG
//
//  Created by Owen on 15/5/13.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGLoginViewController.h"
#import "XGPhoneLoginViewController.h"
#import "XGWeiboFriendItem.h"

@interface XGLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *phoneLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *weiboButton;

@end

@implementation XGLoginViewController

+ (instancetype)getInstance
{
    return [[UIStoryboard storyboardWithName:@"XGLoginViewController" bundle:nil] instantiateInitialViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self.phoneLoginButton roundCornerButton:UIColor.whiteColor];
    [self.weiboButton roundCornerButton:[UIColor hexColor:0xfc594b]];
    [UIButton centerButtonsWithSpacing:16 buttons:@[self.phoneLoginButton,self.weiboButton]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)didTapCloseButton:(id)sender {
    NSString *platformName = [UMSocialSnsPlatformManager getSnsPlatformString:UMSocialSnsTypeSina];
    if (![UMSocialAccountManager isOauthAndTokenNotExpired:platformName]) {
        [MBProgressHUD showTimedDetailsTextHUDOnView:self.view message:@"请先登录" animated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (IBAction)didTapPhoneLoginButton:(id)sender {
    [self.navigationController pushViewController:[XGPhoneLoginViewController getInstance] animated:YES];
}
- (IBAction)didTapWeiboRegisterButton:(id)sender {
    //此处调用授权的方法,你可以把下面的platformName 替换成 UMShareToSina,UMShareToTencent等
    NSString *platformName = [UMSocialSnsPlatformManager getSnsPlatformString:UMSocialSnsTypeSina];
    
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:platformName];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        //          获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:platformName];
            [UMSocialAccountManager postSnsAccount:snsAccount completion:^(UMSocialResponseEntity *response) {
                [UMSocialAccountManager setSnsAccount:snsAccount];
                XGUserItem *userItem = [[XGUserItem alloc] init];
                userItem.account = snsAccount;
                [XGCurrentUserManager sharedInstance].userItem = userItem;
                if ([self.delegate respondsToSelector:@selector(XGLoginSucceed)]) {
                    [self.delegate XGLoginSucceed];
                } else {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }];
//            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
//                NSLog(@"SnsInformation is %@",response.data);
//            }];
        }
    });
}
@end
