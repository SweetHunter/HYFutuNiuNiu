//
//  HYStockListSecHeadView.m
//  HY_futuniuniu
//
//  Created by tongfang on 2017/11/23.
//  Copyright © 2017年 Hyman. All rights reserved.
//

#import "HYStockListSecHeadView.h"
#import "UIView+YYAdd.h"
#import "UIButton+ImageTitleSpacing.h"
@implementation HYStockListSecHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 0.5f;
        [self addSubViews];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx, rect.size.width-18, (rect.size.height-15)/2.f+4, 7, -M_PI_2, 0, 0);
    CGContextAddLineToPoint(ctx, rect.size.width-10, (rect.size.height-15)/2.f-1.5);
    CGContextSetLineWidth(ctx, 1.f);
    CGContextSetStrokeColorWithColor(ctx, HYCOLOR(121, 135, 154, 1).CGColor);
    CGContextStrokePath(ctx);
}

- (void)addSubViews{
    UILabel *nameCode = [[UILabel alloc] initWithFrame:CGRectMake(15.f, 0, 100.f, self.height)];
    nameCode.font = HYFONT(13.f);
    nameCode.textColor = HYCOLOR(121, 135, 154, 1);
    nameCode.text = @"名称代码";
    [self addSubview:nameCode];
    
    UIButton *rotateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rotateBtn.frame = CGRectMake(self.width - 25, (self.height-15)/2.f, 10, 15);
    rotateBtn.layer.borderColor =HYCOLOR(121, 135, 154, 1).CGColor;
    rotateBtn.layer.borderWidth = 1.f;
    rotateBtn.layer.masksToBounds = YES;
    rotateBtn.layer.cornerRadius = 2.f;
    [rotateBtn addTarget:self action:@selector(rotateAciton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rotateBtn];
    
    UIButton *updownRateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    updownRateBtn.frame = CGRectMake(rotateBtn.left -10 -50, 0, 50.f, self.height);
    [updownRateBtn setImage:[UIImage imageNamed:@"skin_common_icon_sort_default"] forState:UIControlStateNormal];
    [updownRateBtn setTitle:@"涨跌幅" forState:UIControlStateNormal];
    [updownRateBtn setTitleColor:HYCOLOR(174, 189, 212, 1) forState:UIControlStateNormal];
    updownRateBtn.titleLabel.font = HYFONT(13.f);
    [updownRateBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5.f];
    [updownRateBtn addTarget:self action:@selector(updownAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:updownRateBtn];
    
    UIButton *newPriceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newPriceBtn.frame = CGRectMake(updownRateBtn.left -10 -50, 0, 50.f, self.height);
    [newPriceBtn setImage:[UIImage imageNamed:@"skin_common_icon_sort_default"] forState:UIControlStateNormal];
    [newPriceBtn setTitle:@"最新价" forState:UIControlStateNormal];
    [newPriceBtn setTitleColor:HYCOLOR(174, 189, 212, 1) forState:UIControlStateNormal];
    newPriceBtn.titleLabel.font = HYFONT(13.f);
    [newPriceBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5.f];
    [newPriceBtn addTarget:self action:@selector(updownAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:newPriceBtn];
    
}

- (void)rotateAciton:(UIButton *)sender{
    
}

@end
