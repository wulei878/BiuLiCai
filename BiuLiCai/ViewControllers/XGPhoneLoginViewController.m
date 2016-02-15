//
//  XGPhoneLoginViewController.m
//  XGCG
//
//  Created by Owen on 15/5/14.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGPhoneLoginViewController.h"
#import "AFNetworking.h"
#import "XGHttpManager.h"

@interface XGPhoneLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendVerificationCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic, copy) NSString *errorMessage;
@end

@implementation XGPhoneLoginViewController
+ (instancetype)getInstance
{
    return [[UIStoryboard storyboardWithName:@"XGLoginViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"XGPhoneLoginViewController"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.loginButton roundCornerButton:[UIColor hexColor:0xfc594b]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendVerificationCodeAction:(id)sender {
    NSString *phoneNumber = self.phoneTextField.text;
    if (![self verifyPhoneNumber:phoneNumber]) {
        [MBProgressHUD showTimedDetailsTextHUDOnView:self.view message:self.errorMessage animated:YES];
        return;
    }
    //等待发送验证码的接口
//    [[AFHTTPRequestOperationManager manager] POST:YunpianMessageURL parameters:@{@"apikey":YunpianApikey,@"mobile":phoneNumber,@"text":kVerificationCodeMessage} success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if (responseObject[@"code"] == 0) {
//            
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
}
- (IBAction)didTapLogin:(id)sender {
    NSString *phoneNumber = self.phoneTextField.text;
    if (![self verifyPhoneNumber:phoneNumber]) {
        [MBProgressHUD showTimedDetailsTextHUDOnView:self.view message:self.errorMessage animated:YES];
        return;
    }
}

- (BOOL)verifyPhoneNumber:(NSString *)phoneNumber
{
    if (phoneNumber.length == 0) {
        self.errorMessage = @"请输入手机号码";
        return NO;
    } else if (phoneNumber.length != 11) {
        self.errorMessage = @"请输入正确的手机号码";
        return NO;
    } else if (([[phoneNumber substringToIndex:2] integerValue] > 18) || ([[phoneNumber substringToIndex:2] integerValue] < 13)) {
        self.errorMessage = @"请输入正确的手机号码";
        return NO;
    }
    
    self.errorMessage = @"";
    return YES;
}
@end
