//
//  XGStockDetailViewController.m
//  XGCG
//
//  Created by Owen on 15/4/27.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGStockDetailViewController.h"

#import "XGStockCommentCell.h"
#import "Lines.h"
#import "XGChartLandscapeViewController.h"
#import "XGBuyStockViewController.h"
#import "XGSellStockViewController.h"
#import "XGStockDetailHeaderView.h"
#import "XGStockInfoItem.h"
#import "XGHttpManager+stockDetail.h"
#import "XGDanmuItem.h"
#import "XGChampionItem.h"
#import "XGStockIncomeViewController.h"
#import "RMShareToWeiBoManager.h"

@interface XGStockDetailViewController()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,XGStockDetailHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *stockNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockStatusLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UIButton *sellButton;
@property (weak, nonatomic) IBOutlet UIButton *pushDanmuButton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) XGStockDetailHeaderView *headerView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *labels;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIView *textViewContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomBarBottom;
@property (weak, nonatomic) IBOutlet UIView *bottomBar;
@property (nonatomic, strong) XGStockInfoItem *stockInfo;
@property (nonatomic,strong) XGChampionItem *champion;
@property (nonatomic,assign) BOOL danmuHasMore;
@property (nonatomic,strong) NSMutableArray *danmuList;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIView *coverViewOnEditingDanmu;
@end

@implementation XGStockDetailViewController
+(instancetype)getInstance
{
    return [[UIStoryboard storyboardWithName:NSStringFromClass([self class]) bundle:nil] instantiateInitialViewController];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = false;
    self.headerView.backgroundColor = kXGNavigationBarTintColor;
    [UIButton changeButtonsVertical:5 buttons:@[self.buyButton,self.sellButton,self.pushDanmuButton,self.collectButton]];
    self.textView = [[UITextView alloc] init];
    self.commentButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 29)];
    [self.commentButton setBackgroundImage:[UIImage imageNamed:@"comment_comfirm"] forState:UIControlStateNormal];
    [self.commentButton addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    self.textViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bottom, self.view.width, 44)];
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
    self.headerView = [XGStockDetailHeaderView getInstance];
    self.headerView.height = 397;
    [self.headerView layoutIfNeeded];
    self.tableView.tableHeaderView = self.headerView;
    self.headerView.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapLandScapeChart:)];
    tap.delegate = self;
    [self.headerView addGestureRecognizer:tap];
    self.danmuList = [NSMutableArray array];
    self.labels = [NSMutableArray array];
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapForHidingKeyboard:)];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanForHidingKeyboard)];
//    tapGesture.delegate = self;
    pan.delegate = self;
//    [self.tableView addGestureRecognizer:tapGesture];
    [self.tableView addGestureRecognizer:pan];
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.contentOffset.y, self.view.width, 0)];
    self.topView.backgroundColor = self.headerView.backgroundColor;
    [self.view addSubview:self.topView];
    [self requestData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [((XGMainViewController *)self.navigationController.parentViewController) hideTabBar];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(runLoopAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)requestData
{
    __weak __typeof(self) weakSelf = self;
    [MBProgressHUD showLoadingHUDOnView:self.view message:nil animated:YES];
    [[XGHttpManager sharedManager] requestStockDetail:@"600010" successBlock:^(id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf loadData:responseObject];
    } failBlock:^(NSString *errorMessage) {
        [MBProgressHUD showTimedDetailsTextHUDOnView:weakSelf.view message:errorMessage animated:YES];
    }];
}

- (void)loadData:(id)data
{
    self.stockInfo = [XGStockInfoItem getInstanceWithDictionary:data[@"stock_info"]];
    [self.headerView configData:self.stockInfo];
    self.stockNameLabel.text = self.stockInfo.stockName;
    self.stockNumberLabel.text = [NSString stringWithFormat:@"(%@)",self.stockInfo.stockID];
    self.champion = [XGChampionItem getInstanceWithDictionary:data[@"leizhu"]];
    NSArray *array = data[@"danmuList"][@"danmu"];
    for (int i = 0; i<array.count; i ++) {
        XGDanmuItem *item = [XGDanmuItem getInstanceWithDictionary:array[i]];
        [self.danmuList addObject:item];
    }
    [self addDanmuList];
    [self.headerView addKLineView];
    [self.tableView reloadData];
}

-(void)addDanmuList
{
    for (XGDanmuItem *item in self.danmuList) {
        UILabel *label = [self createDanmuLabel:item.content];
        [self.labels addObject:label];
    }
    [self runLoopAction];
}

- (UILabel *)createDanmuLabel:(NSString *)string
{
    UILabel *label = [[UILabel alloc] init];
    label.text = string;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"Heiti SC" size:12];
    [label sizeToFit];
    label.left = self.headerView.danmuContainerView.right;
    label.top = rand() % (NSInteger)self.headerView.danmuContainerView.height;
    [self.headerView.danmuContainerView addSubview:label];
    return label;
}

- (void)runLoopAction
{
    for (int i = 0; i < self.labels.count; i ++) {
        UILabel *label = self.labels[i];
        label.left = self.headerView.danmuContainerView.right;
        label.top = rand() % (NSInteger)self.headerView.danmuContainerView.height;
        [UIView animateWithDuration:5 delay:i * 0.2 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveLinear animations:^{
            label.right = 0;
        } completion:nil];
    }
}


-(void)changeButtonEdgeInsets:(UIButton *)button
{
    button.titleEdgeInsets = UIEdgeInsetsMake(button.imageView.height + 5, -button.imageView.width, 0, 0.0);
    button.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, button.titleLabel.height + 5, -button.titleLabel.width);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 0;
    }
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        XGStockCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"championCell" forIndexPath:indexPath];
        [cell configChampionData:self.champion];
        return cell;
    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"incomeListCell" forIndexPath:indexPath];
        return cell;
    } else {
        XGStockCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XGStockCommentCell" forIndexPath:indexPath];
        return cell;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    if (section == 2) {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 41)];
//        view.backgroundColor = [XGUtility kXGHexColor:0xf8f8f8 alpha:1];
//        UILabel *label = [[UILabel alloc] init];
//        label.text = @"相关动态";
//        label.font = [UIFont fontWithName:@"Heiti SC" size:12];
//        label.textColor = [XGUtility kXGHexColor:0x505050 alpha:1.0];
//        [label sizeToFit];
//        label.centerY = view.centerY;
//        label.left = 15;
//        [view addSubview:label];
//        return view;
//    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 41;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 116;
    } else if (indexPath.section == 1) {
        return 41;
    } else {
        return 167;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        [self.navigationController pushViewController:[XGStockIncomeViewController getInstance] animated:YES];
    }
}

- (void)adjustTableHeaderView
{
    UIView *headerView = self.tableView.tableHeaderView;
    
    [headerView layoutIfNeeded];
    self.tableView.tableHeaderView = nil;
    self.tableView.tableHeaderView = headerView;
}

- (IBAction)didTapShareButton:(id)sender {
    RMShareObject *object = [[RMShareObject alloc] init];
    object.title = @"Biu~Biu~Biu";
    object.shareContentType = ShareContentTypeText;
    object.detailContent = @"Biu~Biu~Biu";
    [[RMShareToWeiBoManager sharedInstance] shareWithShareObject:object completion:^(NSInteger errorNumber, NSDictionary *userInfo) {
        if (errorNumber == 0) {
            [MBProgressHUD showTimedDetailsTextHUDOnView:self.view message:@"分享成功" animated:YES];
        }
    }];
}


- (IBAction)didTapBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)didTapBuyButton:(id)sender {
    [self.navigationController pushViewController:[XGBuyStockViewController getInstance] animated:YES];
}
- (IBAction)didTapSellButton:(id)sender {
    [self.navigationController pushViewController:[XGSellStockViewController getInstance] animated:YES];
}
- (IBAction)didTapPushDanmuButton:(id)sender {
    self.bottomBarBottom.constant = - self.bottomBar.height;
    [self.textView becomeFirstResponder];
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (IBAction)didTapCollectButton:(id)sender {
}
- (void)didTapLandScapeChart:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:sender.view];
    if (CGRectContainsPoint(self.headerView.danmuContainerView.frame, point)) {
        [self.navigationController presentViewController:[XGChartLandscapeViewController getInstance] animated:YES completion:nil];
    }
}

- (void)didTapChartButton:(UIButton *)sender
{
}

-(void)didTapDanmuSwitchButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.headerView.danmuContainerView removeAllSubviews];
        [self.labels removeAllObjects];
        [self.timer invalidate];
        self.timer = nil;
    } else {
        [self addDanmuList];
        if (!self.timer) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(runLoopAction) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        }
    }
}

- (void)commentAction:(UIButton *)sender
{
    NSString *aString = [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (aString.length > 15) {
        [MBProgressHUD showTimedDetailsTextHUDOnView:self.view message:@"超过字数限制" animated:YES];
        return;
    }
    if (aString.length <= 0) {
        [MBProgressHUD showTimedDetailsTextHUDOnView:self.view message:@"弹幕不能为空" animated:YES];
        return;
    }
    UILabel *label = [self createDanmuLabel:aString];
    [UIView animateWithDuration:5 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveLinear animations:^{
        label.right = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.labels addObject:label];
        }
    }];
    [self.textView resignFirstResponder];
    self.textView.text = @"";
    [MBProgressHUD showLoadingHUDOnView:self.view message:nil animated:YES];
    NSNumber *contentTime = @([[NSDate date] timeIntervalSince1970]);
    [[XGHttpManager sharedManager] sendDanmu:@{@"uid":@"233344",@"sid":@"11111",@"content":aString,@"time":contentTime} successBlock:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failBlock:^(NSString *errorMessage) {
        [MBProgressHUD showTimedDetailsTextHUDOnView:self.view message:errorMessage animated:YES];
    }];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *keyboardInfo = [notification userInfo];
    CGRect rect = [keyboardInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = ((NSNumber *)keyboardInfo[UIKeyboardAnimationDurationUserInfoKey]).doubleValue;
    UIViewAnimationCurve curve = ((NSNumber *)keyboardInfo[UIKeyboardAnimationCurveUserInfoKey]).integerValue;
    if (!self.coverViewOnEditingDanmu) {
        self.coverViewOnEditingDanmu = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width,SCREEN_HEIGHT - rect.size.height - self.textViewContainer.height)];
        self.coverViewOnEditingDanmu.backgroundColor = [UIColor hexColorWithAlpha:0x000000 alpha:0.5];
        self.coverViewOnEditingDanmu.alpha = 0;
        [self.view.window addSubview:self.coverViewOnEditingDanmu];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapForHidingKeyboard)];
        tap.delegate = self;
        [self.coverViewOnEditingDanmu addGestureRecognizer:tap];
    }
    if (self.textViewContainer.bottom > self.view.height - rect.size.height) {
        [UIView animateWithDuration:animationDuration animations:^{
            [UIView setAnimationCurve:curve];
            self.textViewContainer.bottom = self.view.height - rect.size.height;
            self.coverViewOnEditingDanmu.alpha = 1;
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *keyboardInfo = [notification userInfo];
    NSTimeInterval animationDuration = ((NSNumber *)keyboardInfo[UIKeyboardAnimationDurationUserInfoKey]).doubleValue;
    UIViewAnimationCurve curve = ((NSNumber *)keyboardInfo[UIKeyboardAnimationCurveUserInfoKey]).integerValue;
    self.bottomBarBottom.constant = 0;
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:animationDuration animations:^{
        [UIView setAnimationCurve:curve];
        self.textViewContainer.bottom = self.view.height + self.textViewContainer.height;
        self.coverViewOnEditingDanmu.alpha = 0;
        [self.view layoutIfNeeded];
    }];
}

- (void)didTapForHidingKeyboard
{
    [self.textView resignFirstResponder];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y <= 0) {
        self.topView.height = -scrollView.contentOffset.y;
    } else {
        self.topView.height = 0;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]] && self.textView.isFirstResponder) {
        [self.textView resignFirstResponder];
        return NO;
    }
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && !self.textView.isFirstResponder) {
        return NO;
    }
    return YES;
}

@end
