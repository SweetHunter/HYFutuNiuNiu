//
//  HYTradeController.m
//  HY_futuniuniu
//
//  Created by tongfang on 2017/11/20.
//  Copyright © 2017年 Hyman. All rights reserved.
//

#import "HYTradeController.h"
#import "HYTradeCustomTopView.h"
@interface HYTradeController ()
@property (nonatomic,strong) UIButton *selectedTitleBtn;
@end

@implementation HYTradeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HYCOLOR(236, 239, 245, 1);
    //设置导航栏右边的Item
    [self addNavigationItem];
    
    //设置导航栏中间的segment
    [self addCustomSegmentView];
    
    //设置topView
    [self addCustomTopView];
    
    //设置MiddleView
    [self addCustomMiddleView];
}

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

- (void)addCustomSegmentView{
    UIView *segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 25)];
    segmentView.layer.borderColor = [UIColor blackColor].CGColor;
    segmentView.layer.borderWidth = 0.6f;
    segmentView.layer.cornerRadius = 2.f;
    segmentView.layer.masksToBounds = YES;
    UIButton *HKStockBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    HKStockBtn.frame = CGRectMake(0, 0, 60, 25);
    [HKStockBtn setTitle:@"港股" forState:UIControlStateNormal];
    [HKStockBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [HKStockBtn setTitleColor:HYCOLOR(163, 179, 201, 1) forState:UIControlStateNormal];
    [HKStockBtn setBackgroundImage:[HYCommomTools createImageWithColor:NAVIGATIONBARCOLOR] forState:UIControlStateNormal];
    [HKStockBtn setBackgroundImage:[HYCommomTools createImageWithColor:[UIColor blackColor]] forState:UIControlStateSelected];
    HKStockBtn.titleLabel.font = HYFONT(13);
    [HKStockBtn addTarget:self action:@selector(changeTitleSeg:) forControlEvents:UIControlEventTouchUpInside];
    [segmentView addSubview:HKStockBtn];
    [self changeTitleSeg:HKStockBtn];
    
    UIView *seperatorLine = [[UIView alloc] initWithFrame:CGRectMake(59.4, 0, 0.6, 25)];
    seperatorLine.backgroundColor = [UIColor blackColor];
    [segmentView addSubview:seperatorLine];
   
    
    UIButton *AmeStockBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    AmeStockBtn.frame = CGRectMake(60, 0, 60, 25);
    [AmeStockBtn setTitle:@"美股" forState:UIControlStateNormal];
    [AmeStockBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [AmeStockBtn setTitleColor:HYCOLOR(163, 179, 201, 1) forState:UIControlStateNormal];
    [AmeStockBtn setBackgroundImage:[HYCommomTools createImageWithColor:NAVIGATIONBARCOLOR] forState:UIControlStateNormal];
    [AmeStockBtn setBackgroundImage:[HYCommomTools createImageWithColor:[UIColor blackColor]] forState:UIControlStateSelected];
    AmeStockBtn.titleLabel.font = HYFONT(13);
    [AmeStockBtn addTarget:self action:@selector(changeTitleSeg:) forControlEvents:UIControlEventTouchUpInside];
    [segmentView addSubview:AmeStockBtn];
    
    UIView *seperatorLine2 = [[UIView alloc] initWithFrame:CGRectMake(119.4, 0, 0.6, 25)];
    seperatorLine2.backgroundColor = [UIColor blackColor];
    [segmentView addSubview:seperatorLine2];
    
    UIButton *AStockBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    AStockBtn.frame = CGRectMake(120, 0, 60, 25);
    [AStockBtn setTitle:@"A股" forState:UIControlStateNormal];
    [AStockBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [AStockBtn setTitleColor:HYCOLOR(163, 179, 201, 1) forState:UIControlStateNormal];
    [AStockBtn setBackgroundImage:[HYCommomTools createImageWithColor:NAVIGATIONBARCOLOR] forState:UIControlStateNormal];
    [AStockBtn setBackgroundImage:[HYCommomTools createImageWithColor:[UIColor blackColor]] forState:UIControlStateSelected];
    AStockBtn.titleLabel.font = HYFONT(13);
    [AStockBtn addTarget:self action:@selector(changeTitleSeg:) forControlEvents:UIControlEventTouchUpInside];
    [segmentView addSubview:AStockBtn];
    
    self.navigationItem.titleView = segmentView;
}

- (void)addCustomTopView{
    UIView *backContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
    [self.view addSubview:backContentView];
    HYTradeCustomTopView *topView = [[HYTradeCustomTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*2/7.f)];
    topView.backgroundColor = [UIColor whiteColor];
    [backContentView addSubview:topView];
}

- (void)addCustomMiddleView{
    UIView *operationView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*2/7.f + 10.f, SCREEN_WIDTH, SCREEN_HEIGHT*1/9.f)];
    operationView.backgroundColor = [UIColor whiteColor];
    [self.view.subviews.firstObject addSubview:operationView];
    
    NSArray <NSString *>*itemTitles = @[@"交易",@"存入资金",@"转入股票",@"货币兑换",@"更多"];
    NSArray <NSString *>*itemImageNames= @[];
    for (int i = 0; i < itemTitles.count; i ++) {
        UIButton *operationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
    }
}

- (void)changeTitleSeg:(UIButton *)sender{
    sender.selected = YES;
    self.selectedTitleBtn.selected = NO;
    self.selectedTitleBtn = sender;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
