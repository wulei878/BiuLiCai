//
//  XGChartLandscapeViewController.m
//  XGCG
//
//  Created by Owen on 15/4/29.
//  Copyright (c) 2015年 Sean. All rights reserved.
//

#import "XGChartLandscapeViewController.h"

#import "Lines.h"
#import "XGHttpManager+stockDetail.h"
#import "XGStockInfoItem.h"

static CGFloat kStockChartButtonWidth = 60;
static CGFloat kChartVolumeLineWidth = 2;
@interface XGChartLandscapeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *stockNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockNumberLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *chartButtonContainer;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *buttonLeadingConstraints;
@property (weak, nonatomic) IBOutlet UIView *kLineContainerView;
@property (weak, nonatomic) IBOutlet UIView *volumeContainerView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *chartButtons;
@property (weak, nonatomic) IBOutlet UILabel *stockPrice;
@property (weak, nonatomic) IBOutlet UILabel *increasePercentage;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *highestPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *mediumPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowestPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *highestPercentage;
@property (weak, nonatomic) IBOutlet UILabel *mediumPercentage;
@property (weak, nonatomic) IBOutlet UILabel *lowestPercentage;
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;
@property (nonatomic, strong) XGStockInfoItem *stock;
@property (nonatomic, strong) NSArray *fiveBuyMarket;
@property (nonatomic, strong) NSArray *fiveSellMarket;
@end

@implementation XGChartLandscapeViewController
+(instancetype)getInstance
{
    return [[UIStoryboard storyboardWithName:@"XGStockDetailViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"XGChartLandscapeViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fiveBuyMarket = [NSArray array];
    self.fiveSellMarket = [NSArray array];
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addChartButtons];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addKLineView];
}

-(void)requestData
{
    __weak __typeof(self) weakSelf = self;
    [MBProgressHUD showLoadingHUDOnView:self.view message:nil animated:YES];
    [[XGHttpManager sharedManager] requestStockDetailForLandscape:@"000001" successBlock:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        [weakSelf loadData:responseObject];
    } failBlock:^(NSString *errorMessage) {
        [MBProgressHUD showTimedDetailsTextHUDOnView:weakSelf.view message:errorMessage animated:YES];
    }];
}

-(void)loadData:(id)data
{
    self.stock = [XGStockInfoItem getInstanceWithDictionary:data];
    self.stockNameLabel.text = self.stock.stockName;
    self.stockNumberLabel.text = [NSString stringWithFormat:@"(%ld)",[self.stock.stockID integerValue]];
    self.stockPrice.text = [NSString stringWithFormat:@"%.2f",self.stock.stockPrice];
    if (self.stock.stockUpdownRate >= 0.0) {
        self.increasePercentage.text = [NSString stringWithFormat:@"+%.2f%%",self.stock.stockUpdownRate];
        self.increasePercentage.textColor = kXGStockRizeTextColor;
    } else {
        self.increasePercentage.text = [NSString stringWithFormat:@"%.2f%%",self.stock.stockUpdownRate];
        self.increasePercentage.textColor = kXGStockfallTextColor;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"时间 HH:mm"];
    self.currentTimeLabel.text = [formatter stringFromDate:self.stock.date];
    self.highestPriceLabel.text = [NSString stringWithFormat:@"%.2f",self.stock.maximumPrice];
    self.lowestPriceLabel.text = [NSString stringWithFormat:@"%.2f",self.stock.minimumPrice];
    self.mediumPriceLabel.text = [NSString stringWithFormat:@"%.2f",self.stock.yesterdayEnd];
    self.fiveBuyMarket = data[@"buy_list"];
    self.fiveSellMarket = data[@"sell_list"];
    [self.tableView reloadData];
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)didTapCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addChartButtons
{
    CGFloat spacing = (self.chartButtonContainer.width - kStockChartButtonWidth * 5) / 4;
    for (NSLayoutConstraint *constraint in self.buttonLeadingConstraints) {
        constraint.constant = spacing;
    }
    for (UIButton *button in self.chartButtons) {
        if (button.tag == 1) {
            button.selected = YES;
            break;
        }
    }
}

-(void)addKLineView
{
    Lines *kLines = [[Lines alloc] initWithFrame:self.kLineContainerView.bounds];
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i < SCREEN_WIDTH / 5; i++) {
        NSString *string = [NSString stringWithFormat:@"{%d,%ld}",i * 5,rand() % (NSInteger)self.kLineContainerView.height];
        [array addObject:string];
    }
    kLines.points = array;
    kLines.color = 0xa599d3;
    [self.kLineContainerView addSubview:kLines];
    Lines *volumeLines = [[Lines alloc] initWithFrame:self.volumeContainerView.bounds];
    NSMutableArray *myArray = [NSMutableArray array];
    for (int i=0;i < SCREEN_WIDTH / kChartVolumeLineWidth / 2;i ++) {
        NSString *heightString = [NSString stringWithFormat:@"{%f,%ld}",(i * kChartVolumeLineWidth * 2),rand() % (NSInteger)self.volumeContainerView.height];
        NSString *lowString = [NSString stringWithFormat:@"{%f,%f}",(i * kChartVolumeLineWidth * 2),self.volumeContainerView.height];
        NSString *openString = lowString;
        NSString *closeString = lowString;
        [myArray addObject:@[heightString,lowString,openString,closeString]];
    }
    volumeLines.points = myArray;
    volumeLines.color = 0x747083;
    volumeLines.isK = YES;
    volumeLines.isVol = YES;
    volumeLines.lineWidth = 2;
    [self.volumeContainerView addSubview:volumeLines];
    Lines *lastDayCloseLine = [[Lines alloc] initWithFrame:self.kLineContainerView.bounds];
    NSString *startPoint = [NSString stringWithFormat:@"{%d,%f}",0,self.kLineContainerView.height /2];
    NSString *endPoint = [NSString stringWithFormat:@"{%f,%f}",SCREEN_WIDTH,self.kLineContainerView.height / 2];
    lastDayCloseLine.points = @[startPoint,endPoint];
    lastDayCloseLine.color = 0xe26356;
    lastDayCloseLine.isDotted = YES;
    lastDayCloseLine.lineWidth = 2;
    [self.kLineContainerView addSubview:lastDayCloseLine];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fiveBuyMarket.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 13;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 13)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chartCell" forIndexPath:indexPath];
    for (UILabel *label in cell.contentView.subviews) {
        if (indexPath.section == 0) {
            if (label.tag == 1) {
                label.text = [NSString stringWithFormat:@"买%ld",indexPath.row+1];
            } else if (label.tag == 2) {
                label.text = [NSString stringWithFormat:@"%.2f",[self.fiveBuyMarket[indexPath.row][0] floatValue]];
            } else if (label.tag == 3) {
                label.text = [NSString stringWithFormat:@"%ld",[self.fiveBuyMarket[indexPath.row][1] integerValue]];
            }
        } else {
            if (label.tag == 1) {
                label.text = [NSString stringWithFormat:@"卖%ld",indexPath.row+1];
            } else if (label.tag == 2) {
                label.text = [NSString stringWithFormat:@"%.2f",[self.fiveSellMarket[indexPath.row][0] floatValue]];
            } else if (label.tag == 3) {
                label.text = [NSString stringWithFormat:@"%ld",[self.fiveSellMarket[indexPath.row][1] integerValue]];
            }
        }

    }
    return cell;
}

@end
