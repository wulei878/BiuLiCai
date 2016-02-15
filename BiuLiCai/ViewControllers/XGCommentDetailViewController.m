//
//  XGCommentDetailViewController.m
//  XGCG
//
//  Created by Owen on 15/5/7.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGCommentDetailViewController.h"
#import "XGCommentDetailCell.h"

@interface XGCommentDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) UILabel *testLabel;
@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,strong) UIView *textViewContainer;
@property(nonatomic,strong) UIButton *commentButton;
@end

@implementation XGCommentDetailViewController
+ (instancetype)getInstance
{
    return [[UIStoryboard storyboardWithName:@"XGCommentViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"XGCommentDetailViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [((XGMainViewController *)self.navigationController.parentViewController) hideTabBar];
    self.textView = [[UITextView alloc] init];
    self.commentButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 29)];
    [self.commentButton setBackgroundImage:[UIImage imageNamed:@"comment_comfirm"] forState:UIControlStateNormal];
    self.textViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bottom - 64 - 44, self.view.width, 44)];
    self.commentButton.left = self.textViewContainer.width - 15 - self.commentButton.width;
    self.commentButton.centerY = self.textViewContainer.height / 2;
    self.textView.size = CGSizeMake(self.commentButton.left - 31, 29);
    self.textView.left = 15;
    self.textView.centerY = self.commentButton.centerY;
    [self.textViewContainer addSubview:self.commentButton];
    [self.textViewContainer addSubview:self.textView];
    self.textViewContainer.backgroundColor = [UIColor whiteColor];
    self.textViewContainer.layer.borderWidth = 1;
    self.textViewContainer.layer.borderColor = [UIColor hexColor:0xe4e5e6].CGColor;
    self.textView.layer.cornerRadius = 15;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [UIColor hexColor:0xe4e5e6].CGColor;
    [self.view addSubview:self.textViewContainer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *keyboardInfo = [notification userInfo];
    CGRect rect = [keyboardInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = ((NSNumber *)keyboardInfo[UIKeyboardAnimationDurationUserInfoKey]).doubleValue;
    UIViewAnimationCurve curve = ((NSNumber *)keyboardInfo[UIKeyboardAnimationCurveUserInfoKey]).integerValue;
    
    if (self.textViewContainer.bottom > self.view.height - rect.size.height) {
        [UIView animateWithDuration:animationDuration animations:^{
            [UIView setAnimationCurve:curve];
            self.textViewContainer.bottom = self.view.height - rect.size.height;
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *keyboardInfo = [notification userInfo];
    NSTimeInterval animationDuration = ((NSNumber *)keyboardInfo[UIKeyboardAnimationDurationUserInfoKey]).doubleValue;
    UIViewAnimationCurve curve = ((NSNumber *)keyboardInfo[UIKeyboardAnimationCurveUserInfoKey]).integerValue;
    [UIView animateWithDuration:animationDuration animations:^{
        [UIView setAnimationCurve:curve];
        self.textViewContainer.bottom = 0;
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self calculateCellHeight];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XGCommentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentDetailCell" forIndexPath:indexPath];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)calculateCellHeight {
    if (!self.testLabel) {
        self.testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        self.testLabel.font = [UIFont fontWithName:@"Heiti SC" size:12];
        self.testLabel.numberOfLines = 0;
    }
    self.testLabel.text = @"买入个股$平安银行$，成交价15.00元，数量10000股，成交额150000元。个股仓位占比20%";
    return 57 + 14 + [self.testLabel sizeThatFits:CGSizeMake(self.tableView.width - 80, 0)].height;
}

@end
