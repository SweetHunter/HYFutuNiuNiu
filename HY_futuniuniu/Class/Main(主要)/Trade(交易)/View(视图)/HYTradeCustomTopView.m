//
//  HYTradeCustomTopView.m
//  HY_futuniuniu
//
//  Created by tongfang on 2018/1/9.
//  Copyright © 2018年 Hyman. All rights reserved.
//

#import "HYTradeCustomTopView.h"
#import "Masonry.h"
@implementation HYTradeCustomTopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    UIImageView *logoImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    logoImg.image = [UIImage imageNamed:@"skin_quote_icon_flag_hk"];
    [self addSubview:logoImg];
    
    [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.width.equalTo(@16);
        make.height.equalTo(@16);
    }];
    
    UILabel *cashAccountLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    cashAccountLbl.text = @"现金账户";
    cashAccountLbl.textColor = HYCOLOR(117, 135, 152, 1);
    cashAccountLbl.font = HYFONT(12.f);
    cashAccountLbl.textAlignment = NSTextAlignmentCenter;
    [self addSubview:cashAccountLbl];
    
    [cashAccountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(logoImg.mas_right).offset(10.f);
        make.centerY.equalTo(logoImg.mas_centerY);
    }];
    
    UILabel *cashAccountContentLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    cashAccountContentLbl.text = @"1001 1001 2010 6306";
    cashAccountContentLbl.textColor = [UIColor blackColor];
    cashAccountContentLbl.font = HYFONT(12.f);
    cashAccountContentLbl.textAlignment = NSTextAlignmentCenter;
    [self addSubview:cashAccountContentLbl];
    
    [cashAccountContentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cashAccountLbl.mas_right).offset(10.f);
        make.centerY.equalTo(cashAccountLbl.mas_centerY);
    }];
    
    UIButton *freeUpdateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [freeUpdateBtn setBackgroundColor:HYCOLOR(166, 199, 248, 1)];
    freeUpdateBtn.layer.masksToBounds = YES;
    freeUpdateBtn.layer.cornerRadius = 3.f;
    [freeUpdateBtn setTitle:@"免费升级" forState:UIControlStateNormal];
    freeUpdateBtn.titleLabel.font = HYFONT(10.f);
    [freeUpdateBtn addTarget:self action:@selector(freeUpdateAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:freeUpdateBtn];
    
    [freeUpdateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10.f);
        make.centerY.equalTo(cashAccountContentLbl.mas_centerY);
        make.width.equalTo(@50.f);
        make.height.equalTo(@20.f);
    }];
    
    UIView *seperatorLine = [[UIView alloc] initWithFrame:CGRectZero];
    seperatorLine.backgroundColor = HYCOLOR(240, 242, 245, 1);
    [self addSubview:seperatorLine];
    
    [seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(logoImg.mas_bottom).offset(10);
        make.height.equalTo(@1.f);
    }];
    
    UILabel *assetsLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    assetsLbl.text = @"资产净值(港元)";
    assetsLbl.font =HYFONT(11.f);
    assetsLbl.textColor = HYCOLOR(117, 135, 152, 1);
    assetsLbl.textAlignment = NSTextAlignmentCenter;
    [self addSubview:assetsLbl];
    
    [assetsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10.f);
        make.top.equalTo(seperatorLine.mas_bottom).offset(10.f);
    }];
    
    
    UIButton *todayProfitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [todayProfitBtn setImage:[UIImage imageNamed:@"skin_quote_icon_share"] forState:UIControlStateNormal];
    [todayProfitBtn addTarget:self action:@selector(todayProfitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:todayProfitBtn];
    
    [todayProfitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10.f);
        make.centerY.equalTo(assetsLbl.mas_centerY);
        make.width.equalTo(@20.f);
        make.height.equalTo(@20.f);
    }];
    
    UILabel *todayProfitLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    todayProfitLbl.text = @"今日盈亏";
    todayProfitLbl.font =HYFONT(11.f);
    todayProfitLbl.textColor = HYCOLOR(117, 135, 152, 1);
    todayProfitLbl.textAlignment = NSTextAlignmentCenter;
    [self addSubview:todayProfitLbl];
    
    [todayProfitLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(todayProfitBtn.mas_left).offset(-15.f);
        make.centerY.equalTo(assetsLbl.mas_centerY);
    }];
    
    NSString *assetsNumberStr = @"888.88";
    NSMutableAttributedString *assetsNumberAttributeStr = [[NSMutableAttributedString alloc] initWithString:assetsNumberStr];
    NSArray *components = [assetsNumberStr componentsSeparatedByString:@"."];
    
    NSString *firstStr = components.firstObject;
    NSString *endStr = components.lastObject;
    [assetsNumberAttributeStr addAttribute:NSFontAttributeName value:HYFONT(30.f) range:NSMakeRange(0, firstStr.length)];
    [assetsNumberAttributeStr addAttribute:NSFontAttributeName value:HYFONT(18.f) range:NSMakeRange(firstStr.length+1, endStr.length)];
    [assetsNumberAttributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, assetsNumberStr.length)];
    
    UILabel *assetsNumberLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    assetsNumberLbl.attributedText = assetsNumberAttributeStr;
    [self addSubview:assetsNumberLbl];
    
    [assetsNumberLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10.f);
        make.top.equalTo(assetsLbl.mas_bottom).offset(20.f);
    }];
    
    UILabel *todayProfitNumberLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    todayProfitNumberLbl.text = @"+123.45";
    todayProfitNumberLbl.textColor = HYCOLOR(117, 135, 152, 1);
    todayProfitNumberLbl.font = HYFONT(16.f);
    todayProfitNumberLbl.textAlignment  = NSTextAlignmentCenter;
    [self addSubview:todayProfitNumberLbl];
    
    [todayProfitNumberLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10.f);
        make.top.equalTo(assetsNumberLbl.mas_top);
    }];
    
    UILabel *todayProfitRateNumberLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    todayProfitRateNumberLbl.text = @"+6.60%";
    todayProfitRateNumberLbl.textColor = HYCOLOR(117, 135, 152, 1);
    todayProfitRateNumberLbl.font = HYFONT(14.f);
    todayProfitRateNumberLbl.textAlignment  = NSTextAlignmentCenter;
    [self addSubview:todayProfitRateNumberLbl];
    
    [todayProfitRateNumberLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(todayProfitNumberLbl);
        make.bottom.equalTo(assetsNumberLbl.mas_bottom);
    }];
    
    UIView *seperatorLine2 = [[UIView alloc] initWithFrame:CGRectZero];
    seperatorLine2.backgroundColor = HYCOLOR(240, 242, 245, 1);
    [self addSubview:seperatorLine2];
    
    [seperatorLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(assetsNumberLbl.mas_bottom).offset(20.f);
        make.height.equalTo(@1.f);
    }];
    
    UILabel *securityMarketValueLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    securityMarketValueLbl.text = @"证券市值";
    securityMarketValueLbl.textColor = HYCOLOR(117, 135, 152, 1);
    securityMarketValueLbl.font = HYFONT(12.f);
    securityMarketValueLbl.textAlignment  = NSTextAlignmentCenter;
    [self addSubview:securityMarketValueLbl];
    
    [securityMarketValueLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(seperatorLine2.mas_bottom).offset(10.f);
        make.centerX.equalTo(self).offset(-SCREEN_WIDTH*1/4.f);
    }];
    
    UILabel *securityMarketValueNumberLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    securityMarketValueNumberLbl.text = @"1234.56";
    securityMarketValueNumberLbl.textColor = [UIColor blackColor];
    securityMarketValueNumberLbl.font = HYFONT(14.f);
    securityMarketValueNumberLbl.textAlignment  = NSTextAlignmentCenter;
    [self addSubview:securityMarketValueNumberLbl];
    
    [securityMarketValueNumberLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(securityMarketValueLbl.mas_bottom).offset(5.f);
        make.centerX.equalTo(securityMarketValueLbl);
    }];
    
    UILabel *cashValueLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    cashValueLbl.text = @"现金";
    cashValueLbl.textColor = HYCOLOR(117, 135, 152, 1);
    cashValueLbl.font = HYFONT(12.f);
    cashValueLbl.textAlignment  = NSTextAlignmentCenter;
    [self addSubview:cashValueLbl];
    
    [cashValueLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(seperatorLine2.mas_bottom).offset(10.f);
        make.centerX.equalTo(self).offset(SCREEN_WIDTH*1/4.f);
    }];
    
    UILabel *cashValueNumberLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    cashValueNumberLbl.text = @"6666.66";
    cashValueNumberLbl.textColor = [UIColor blackColor];
    cashValueNumberLbl.font = HYFONT(14.f);
    cashValueNumberLbl.textAlignment  = NSTextAlignmentCenter;
    [self addSubview:cashValueNumberLbl];
    
    [cashValueNumberLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cashValueLbl.mas_bottom).offset(5.f);
        make.centerX.equalTo(self).offset(SCREEN_WIDTH*1/4.f);
    }];
    
    UIButton *arrowDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [arrowDownBtn setImage:[UIImage imageNamed:@"skin_common_icon_arrow_small_down"] forState:UIControlStateNormal];
    [arrowDownBtn addTarget:self action:@selector(arrowDownAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:arrowDownBtn];
    
    [arrowDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.centerX.equalTo(self);
        make.width.equalTo(@8.f);
        make.height.equalTo(@8.f);
    }];
}
@end
