//
//  HYMarketController.m
//  HY_futuniuniu
//
//  Created by tongfang on 2017/11/20.
//  Copyright © 2017年 Hyman. All rights reserved.
//

#import "HYMarketController.h"
#import "HYSegmentView.h"
#import "HYStockListCell.h"
#import "HYStockListSecHeadView.h"
#import "HYStockListTabFooterView.h"
#import "HYStockListTabHeaderView.h"
#import "MJExtension.h"
#import "HYStockModel.h"
#import "UIView+YYAdd.h"
#import "Masonry.h"
#import "HYMiniStockView.h"
static  NSString  *const HYStockListCellIdendifier = @"HYStockListCellIdendifier";

@interface HYMarketController ()<HYSegmentViewDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,HYMiniStockViewDelegate>
@property (nonatomic,strong) UIButton *selectedTitleBtn;
@property (nonatomic,strong) UITableView *stockListView;
@property (nonatomic,strong) NSMutableArray *stockList;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) HYMiniStockView *miniStockView;
@property (nonatomic,strong) dispatch_source_t sourceTimer;
@property (nonatomic,copy) NSArray *bottomData;
@end

@implementation HYMarketController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MARKETMAINCOLOR;
    
    //设置导航栏右边的Item
    [self addNavigationItem];
    
    //设置导航栏中间的segment
    [self addCustomSegmentView];
    
    //设置导航菜单视图
    [self addNavigaionListView];
    
    //创建股票自选列表视图
    [self addStockListView];
    
    //加载数据(模拟)
    [self loadStockListData];
    
    //创建底部视图
    [self addBottomView];
    
    //创建底部迷你股票视图
    [self addBottomMiniStockView];
    
}

#pragma mark *** lazy load ***
- (NSMutableArray *)stockList{
    if (_stockList == nil) {
        _stockList = @[].mutableCopy;
    }
    return _stockList;
}

#pragma mark *** Create View ***
/**
 设置导航栏左右Item
 */
- (void)addNavigationItem{
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(0, 0, 40, 40);
    [searchBtn setImage:[UIImage imageNamed:@"skin_navbar_icon_search"] forState:UIControlStateNormal];
    [searchBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];

    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.frame = CGRectMake(0, 0, 40, 40);
    [messageBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [messageBtn setImage:[UIImage imageNamed:@"skin_navbar_icon_chat"] forState:UIControlStateNormal];
    UIBarButtonItem *messageItem = [[UIBarButtonItem alloc] initWithCustomView:messageBtn];

    self.navigationItem.rightBarButtonItems = @[messageItem,searchItem];
    
}


/**
 设置导航栏的NavigationIem
 */
- (void)addCustomSegmentView{
    UIView *segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 25)];
    segmentView.layer.borderColor = [UIColor blackColor].CGColor;
    segmentView.layer.borderWidth = 1.f;
    segmentView.layer.cornerRadius = 2.f;
    segmentView.layer.masksToBounds = YES;
    UIButton *selfSelectBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    selfSelectBtn.frame = CGRectMake(0, 0, 60, 25);
    [selfSelectBtn setTitle:@"自选" forState:UIControlStateNormal];
    [selfSelectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [selfSelectBtn setTitleColor:HYCOLOR(163, 179, 201, 1) forState:UIControlStateNormal];
    [selfSelectBtn setBackgroundImage:[HYCommomTools createImageWithColor:NAVIGATIONBARCOLOR] forState:UIControlStateNormal];
    [selfSelectBtn setBackgroundImage:[HYCommomTools createImageWithColor:[UIColor blackColor]] forState:UIControlStateSelected];
    selfSelectBtn.titleLabel.font = HYFONT(13);
    [selfSelectBtn addTarget:self action:@selector(changeTitleSeg:) forControlEvents:UIControlEventTouchUpInside];
    [segmentView addSubview:selfSelectBtn];
    [self changeTitleSeg:selfSelectBtn];
    
    UIButton *marketBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    marketBtn.frame = CGRectMake(60, 0, 60, 25);
    [marketBtn setTitle:@"市场" forState:UIControlStateNormal];
    [marketBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [marketBtn setTitleColor:HYCOLOR(163, 179, 201, 1) forState:UIControlStateNormal];
    [marketBtn setBackgroundImage:[HYCommomTools createImageWithColor:NAVIGATIONBARCOLOR] forState:UIControlStateNormal];
    [marketBtn setBackgroundImage:[HYCommomTools createImageWithColor:[UIColor blackColor]] forState:UIControlStateSelected];
    marketBtn.titleLabel.font = HYFONT(13);
    [marketBtn addTarget:self action:@selector(changeTitleSeg:) forControlEvents:UIControlEventTouchUpInside];
    [segmentView addSubview:marketBtn];
    
    self.navigationItem.titleView = segmentView;
}


/**
 创建导航视图
 */
- (void)addNavigaionListView{
    HYSegmentView *segmentView = [[HYSegmentView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH-30, 40) titles:@[@"全部",@"沪深",@"港股",@"美股"]];
    segmentView.delegate = self;
    [self.view addSubview:segmentView];
    
    UIButton *addItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addItemBtn.frame = CGRectMake(segmentView.right, 64, 30, 40);
    [addItemBtn setBackgroundColor:NAVIGATIONBARCOLOR];
    [addItemBtn setImage:[UIImage imageNamed:@"skin_quote_icon_menu"] forState:UIControlStateNormal];
    addItemBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    [addItemBtn addTarget:self action:@selector(addItemAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addItemBtn];
}

/**
 创建股票自选列表视图
 */
- (void)addStockListView{
    UITableView *stockListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104.5, SCREEN_WIDTH, SCREEN_HEIGHT-104.5-49-35) style:UITableViewStylePlain];
    self.stockListView = stockListView;
    stockListView.separatorColor = [UIColor blackColor];
    stockListView.backgroundColor =MARKETMAINCOLOR;
    stockListView.delegate = self;
    stockListView.dataSource = self;
    stockListView.rowHeight = 55;
    stockListView.tableHeaderView = [[HYStockListTabHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80.f)];
    stockListView.tableFooterView = [[HYStockListTabFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40.f)];
    [stockListView registerClass:[HYStockListCell class] forCellReuseIdentifier:HYStockListCellIdendifier];
    [self.view addSubview:stockListView];
}

- (void)loadStockListData{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"StockList" ofType:@"plist"];
    NSArray *stockList = [NSArray arrayWithContentsOfFile:filePath];
    [stockList enumerateObjectsUsingBlock:^(NSDictionary  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HYStockModel *model = [HYStockModel mj_objectWithKeyValues:obj];
        [self.stockList addObject:model];
    }];
    [self.stockListView reloadData];
}

- (void)addBottomView{
    self.bottomData = @[@{@"title":@"深证成指",@"increaseRate":@"1.04%",@"increasePrice":@"+114.91",@"currentPrice":@"11118.25"},@{@"title":@"上证指数",@"increaseRate":@"1.12%",@"increasePrice":@"+21.19",@"currentPrice":@"3286.59"},@{@"title":@"创业板指",@"increaseRate":@"0.41%",@"increasePrice":@"+7.32",@"currentPrice":@"1789.74"}];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(-1, SCREEN_HEIGHT-49-35, SCREEN_WIDTH+2, 35.f)];
    bottomView.clipsToBounds = YES;
    self.bottomView = bottomView;
    bottomView.layer.borderColor = [UIColor blackColor].CGColor;
    bottomView.layer.borderWidth = 0.6f;
    bottomView.backgroundColor = MARKETMAINCOLOR;
    [self.view addSubview:bottomView];
    
    UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, 35)];
    [bottomView addSubview:itemView];
    
    UIButton *arrowBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    arrowBtn.frame = CGRectMake(itemView.right, 0, 30.f, 35.f);
    [arrowBtn setImage:[UIImage imageNamed:@"skin_common_icon_arrow_up"] forState:UIControlStateNormal];
    [arrowBtn addTarget:self action:@selector(updownAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:arrowBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.tag = 100;
    titleLabel.text = @"上证指数";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = HYFONT(12.f);
    [itemView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5.f);
        make.centerY.equalTo(itemView);
    }];
    
    UILabel *increaseRateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    increaseRateLabel.tag = 101;
    increaseRateLabel.text = @"1.12%";
    increaseRateLabel.font = HYFONT(12.f);
    increaseRateLabel.textColor = HYCOLOR(253, 66, 74, 1);
    [itemView addSubview:increaseRateLabel];
    
    [increaseRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(itemView);
        make.centerY.equalTo(itemView);
    }];
    
    UILabel *increasePriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    increasePriceLabel.tag = 102;
    increasePriceLabel.text = @"+21.19";
    increasePriceLabel.font = HYFONT(12.f);
    increasePriceLabel.textColor = HYCOLOR(253, 66, 74, 1);
    [itemView addSubview:increasePriceLabel];
    
    [increasePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(increaseRateLabel.mas_left).offset(-15);
        make.centerY.equalTo(itemView);
    }];
    
    UILabel *currentPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    currentPriceLabel.tag = 103;
    currentPriceLabel.text = @"3286.59";
    currentPriceLabel.font = HYFONT(12.f);
    currentPriceLabel.textColor = HYCOLOR(253, 66, 74, 1);
    [itemView addSubview:currentPriceLabel];
    
    [currentPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(increasePriceLabel.mas_left).offset(-20);
        make.centerY.equalTo(itemView);
    }];
    
    [self startAnimation];
    
}

- (void)addBottomMiniStockView{
    HYMiniStockView *miniStockView = [[HYMiniStockView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, SCREEN_HEIGHT*1/3.f)];
    self.miniStockView = miniStockView;
    miniStockView.delegate = self;
    miniStockView.backgroundColor = [UIColor blackColor];
    miniStockView.hidden = YES;
    [self.view addSubview:miniStockView];
}

- (void)startAnimation{
   __block NSInteger index = 0;
   
        NSTimeInterval second = 3.0;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _sourceTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_sourceTimer,dispatch_walltime(NULL, 0),second*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_sourceTimer, ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *data = self.bottomData[index%3];
                UIView *animationView = self.bottomView.subviews.firstObject;
                UILabel *titleLbl = [animationView viewWithTag:100];
                titleLbl.text = data[@"title"];
                UILabel *increaseRateLbl = [animationView viewWithTag:101];
                increaseRateLbl.text = data[@"increaseRate"];
                UILabel *increasePriceLbl = [animationView viewWithTag:102];
                increasePriceLbl.text = data[@"increasePrice"];
                UILabel *currentPriceLbl = [animationView viewWithTag:103];
                currentPriceLbl.text = data[@"currentPrice"];
                CATransition *transition = [CATransition animation];
                transition.duration = 1;
                transition.type = @"push";
                transition.subtype = kCATransitionFromTop;
                [animationView.layer addAnimation:transition forKey:nil];
                index ++;
            });
        });
        dispatch_resume(_sourceTimer);
}

#pragma mark *** Button Click ***
- (void)changeTitleSeg:(UIButton *)sender{
    sender.selected = YES;
    self.selectedTitleBtn.selected = NO;
    self.selectedTitleBtn = sender;
}

- (void)search{
    
}

- (void)message{
    
}

- (void)addItemAction{
    
}

- (void)updownAction{
    self.bottomView.hidden = YES;
    self.miniStockView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.miniStockView.bottom = SCREEN_HEIGHT-44;
    } completion:^(BOOL finished) {
    }];
}


#pragma mark *** HYMiniStockViewDelegate ***
- (void)HYMiniStockViewDidClickDownBtn{
    [UIView animateWithDuration:0.3 animations:^{
        self.miniStockView.top = SCREEN_HEIGHT-44;
    } completion:^(BOOL finished) {
        self.bottomView.hidden = NO;
        self.miniStockView.hidden = YES;
    }];
}

#pragma mark *** UIGestureRecognizerDelegate ***
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
#pragma mark *** HYSegmentViewDelegate ***
- (void)HYSegmentViewDidSelectedItemAtIndex:(NSInteger)index{
    NSLog(@"选中了第%ld个",index);
}

#pragma mark *** UITableViewDataSource ***
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.stockList.count;
}

#pragma mark *** UITableViewDelegate ***
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 34.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HYStockListSecHeadView *headView = [[HYStockListSecHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 34.f)];
    headView.backgroundColor = MARKETMAINCOLOR;
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HYStockListCell *cell = [tableView dequeueReusableCellWithIdentifier:HYStockListCellIdendifier forIndexPath:indexPath];
    cell.model = self.stockList[indexPath.row];
    cell.contentView.backgroundColor = MARKETMAINCOLOR;
    cell.backgroundColor = MARKETMAINCOLOR;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
