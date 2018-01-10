//
//  HYStockListSecFooterView.m
//  HY_futuniuniu
//
//  Created by tongfang on 2017/11/24.
//  Copyright © 2017年 Hyman. All rights reserved.
//

#import "HYStockListTabFooterView.h"
#import "Masonry.h"
#import "UIButton+ImageTitleSpacing.h"
@implementation HYStockListTabFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 0.5f;
         [self addSubViews];
    }
    return self;
}


- (void)addSubViews{
    UIButton *addStockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addStockBtn setImage:[UIImage imageNamed:@"skin_quote_icon_add"] forState:UIControlStateNormal];
    [addStockBtn setTitle:@"添加股票" forState:UIControlStateNormal];
    addStockBtn.titleLabel.font = HYFONT(15.f);
    [addStockBtn setTitleColor:HYCOLOR(177, 192, 214, 1) forState:UIControlStateNormal];
    [addStockBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    [addStockBtn addTarget:self action:@selector(addStcok) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addStockBtn];
    
    [addStockBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
    }];
}

- (void)addStcok{
    
}
@end
