//
//  HYMiniStockView.m
//  HY_futuniuniu
//
//  Created by tongfang on 2017/12/28.
//  Copyright © 2017年 Hyman. All rights reserved.
//

#import "HYMiniStockView.h"
#import "HYSegmentView.h"
#import "UIView+YYAdd.h"
@interface HYMiniStockView()<HYSegmentViewDelegate>
@end

@implementation HYMiniStockView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加导航栏分段视图
        [self addNavigationItemView];
    }
    return self;
}

- (void)addNavigationItemView{
    UIView *navigationItemView = [[UIView alloc] initWithFrame:CGRectMake(-1, 0.6, SCREEN_WIDTH+2, 30.f)];
    navigationItemView.backgroundColor = MARKETMAINCOLOR;
    [self addSubview:navigationItemView];
    
    HYSegmentView *segmentView = [[HYSegmentView alloc] initWithFrame:CGRectMake(30, 0, SCREEN_WIDTH-60, 30.f) titles:@[@"沪深",@"港股",@"美股"]];
    segmentView.delegate = self;
    [navigationItemView addSubview:segmentView];
    
    UIButton *downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    downBtn.frame = CGRectMake(SCREEN_WIDTH-30, 0, 30, 30);
    [downBtn setImage:[UIImage imageNamed:@"skin_common_icon_arrow_down"] forState:UIControlStateNormal];
    [downBtn addTarget:self action:@selector(downAction:) forControlEvents:UIControlEventTouchUpInside];
    [navigationItemView addSubview:downBtn];
    
    UIView *miniStockView = [[UIView alloc] initWithFrame:CGRectMake(0, navigationItemView.bottom+0.6, SCREEN_WIDTH, self.height - 31.8)];
    miniStockView.backgroundColor = MARKETMAINCOLOR;
    [self addSubview:miniStockView];
    
}

- (void)downAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(HYMiniStockViewDidClickDownBtn)]) {
        [self.delegate HYMiniStockViewDidClickDownBtn];
    }
}

- (void)HYSegmentViewDidSelectedItemAtIndex:(NSInteger)index{
    
}

@end
