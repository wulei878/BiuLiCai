//
//  XGSearchStockViewController.m
//  XGCG
//
//  Created by Owen on 15/5/9.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGSearchStockViewController.h"

#import "XGHttpManager+stockDetail.h"
#import "XGStockInfoItem.h"


static NSString *kCellIdentifier = @"hotStockCell";
@interface XGSearchStockViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet XGSearchTextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldRight;
@property (nonatomic, strong) NSMutableArray *stocks;
@property (weak, nonatomic) IBOutlet UITableView *resultTableView;
@property (nonatomic, strong) NSMutableArray *resultArray;
@end

@implementation XGSearchStockViewController
+ (instancetype)getInstance
{
    return [[UIStoryboard storyboardWithName:@"XGSimulateStockViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"XGSearchStockViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [((XGMainViewController *)self.navigationController.parentViewController) hideTabBar];
    [self.textField becomeFirstResponder];
    self.textField.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearButtonTapped)];
    [self.textField.rightView addGestureRecognizer:tap];
    self.stocks = [NSMutableArray array];
    self.resultArray = [NSMutableArray array];
    [self requestData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)requestData
{
    __weak __typeof(self) weakSelf = self;
    [MBProgressHUD showLoadingHUDOnView:self.view message:nil animated:YES];
    [[XGHttpManager sharedManager] checkAllStockVersionWithSuccessBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        [weakSelf loadData:responseObject];
    } failBlock:^(NSString *errorMessage) {
        [MBProgressHUD showTimedDetailsTextHUDOnView:weakSelf.view message:errorMessage animated:YES];
    }];
}

-(void)loadData:(id)data
{
    NSArray *array = data;
    for (int i = 0; i < array.count; i ++) {
        XGStockInfoItem *item = [XGStockInfoItem getInstanceWithDictionary:array[i]];
        [self.stocks addObject:item];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.resultTableView) {
        return 1;
    }
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.resultTableView) {
        return self.resultArray.count;
    }
    if (section == 0) {
        return 3;
    }
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.resultTableView) {
        XGSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultCell" forIndexPath:indexPath];
        [cell configData:self.resultArray[indexPath.row]];
        return cell;
    }
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell" forIndexPath:indexPath];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.resultTableView) {
        return 0;
    }
    return 41;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.resultTableView) {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 41)];
    view.backgroundColor = [UIColor hexColor:0xf8f8f8];
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor hexColor:0x999999];
    label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
    label.text = section == 0 ? @"历史搜索":@"热门搜索";
    [label sizeToFit];
    label.left = 15;
    label.centerY = view.height / 2 + 4;
    [view addSubview:label];
    if (section == 0) {
        UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        clearButton.contentEdgeInsets = UIEdgeInsetsZero;
        [clearButton setTitle:@"清除" forState:UIControlStateNormal];
        clearButton.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
        [clearButton setTitleColor:[UIColor hexColor:0xff5845] forState:UIControlStateNormal];
        clearButton.backgroundColor = [UIColor clearColor];
        clearButton.left = view.width - 15 - clearButton.width;
        clearButton.centerY = view.height / 2 + 4;
        [view addSubview:clearButton];
    }
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, view.height - 1, view.width, 1)];
    bottomLine.backgroundColor = [UIColor hexColor:0xf0f0f0];
    [view addSubview:bottomLine];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
}

- (void)keyboardWillHide:(NSNotification *)notification
{
}

- (void)clearButtonTapped {
    self.textField.text = @"";
    self.resultTableView.hidden = YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldTextDidChange:(NSNotification *)notification
{
    if (self.textField.text.length == 0) {
        self.resultTableView.hidden = YES;
    } else {
        self.resultTableView.hidden = NO;
    }
    [self.resultArray removeAllObjects];
    [self.stocks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XGStockInfoItem *item = obj;
        if ([item.stockName rangeOfString:self.textField.text].length != 0 || [item.stockID.stringValue rangeOfString:self.textField.text].length != 0) {
            [self.resultArray addObject:item];
        }
    }];
    [self.resultTableView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.resultTableView) {
        [self.textField resignFirstResponder];
    }
}

- (IBAction)didTapCancelButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
