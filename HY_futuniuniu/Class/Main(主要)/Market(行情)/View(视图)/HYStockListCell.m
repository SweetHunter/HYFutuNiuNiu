//
//  HYStockListCell.m
//  HY_futuniuniu
//
//  Created by tongfang on 2017/11/23.
//  Copyright © 2017年 Hyman. All rights reserved.
//

#import "HYStockListCell.h"
#import "Masonry.h"
#import "HYStockModel.h"
@implementation HYStockListCell{
    UIImageView *_marketView;
    UILabel *_name;
    UILabel *_code;
    UILabel *_price;
    UILabel *_updownRate;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addCustomView];
    }
    return self;
}


- (void)addCustomView{
    _marketView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    [self addSubview:_marketView];
    
    [_marketView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(@14);
        make.width.equalTo(@14);
        make.height.equalTo(@11);
    }];
    
    _name = [[UILabel alloc] initWithFrame:CGRectZero];
    _name.font = HYFONT(16.f);
    _name.textColor = [UIColor whiteColor];
    [self addSubview:_name];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_marketView.mas_right).offset(5);
        make.top.equalTo(@8);
    }];
    
    _code = [[UILabel alloc] initWithFrame:CGRectZero];
    _code.font = HYFONT(12.f);
    _code.textColor = HYCOLOR(121, 135, 154, 1);
    [self addSubview:_code];
    
    [_code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name);
        make.bottom.equalTo(@(-6));
    }];
    
    
    _updownRate = [[UILabel alloc] initWithFrame:CGRectZero];
    _updownRate.font = HYFONT(16.f);
    _updownRate.textColor = [UIColor whiteColor];
    _updownRate.textAlignment = NSTextAlignmentCenter;
    _updownRate.backgroundColor =HYCOLOR(0, 171, 60, 1);
    _updownRate.layer.cornerRadius = 2.f;
    _updownRate.layer.masksToBounds = YES;
    [self addSubview:_updownRate];
    
    [_updownRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-5));
        make.centerY.equalTo(self);
        make.width.equalTo(@80.f);
        make.height.equalTo(@25.f);
    }];
    
    _price = [[UILabel alloc] initWithFrame:CGRectZero];
    _price.font = HYFONT(16.f);
    _price.textColor = HYCOLOR(0, 171, 60, 1);
    [self addSubview:_price];
    
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_updownRate.mas_left).offset(-10);
        make.centerY.equalTo(self);
    }];
    
}

- (void)setModel:(HYStockModel *)model{
    _model = model;
    if ([_model.market isEqualToString:@"hk"]) {
        _marketView.image = [UIImage imageNamed:@"skin_quote_icon_hk"];
    }else if ([_model.market isEqualToString:@"sz"]){
        _marketView.image = [UIImage imageNamed:@"skin_quote_icon_sz"];
    }else if ([_model.market isEqualToString:@"sh"]){
         _marketView.image = [UIImage imageNamed:@"skin_quote_icon_sh"];
    }else if ([_model.market isEqualToString:@"us"]){
        _marketView.image = [UIImage imageNamed:@"skin_quote_icon_us"];
    }
    
    _name.text = _model.name;
    _code.text = _model.code;
    _price.text = _model.price;
    
    CGFloat rate = ([_model.price floatValue]-[_model.yesterdayClosePrice floatValue])/[_model.yesterdayClosePrice floatValue]*100;
    _updownRate.text = rate>=0?[NSString stringWithFormat:@"+%.2f%%",rate]:[NSString stringWithFormat:@"%.2f%%",rate];
    _updownRate.backgroundColor = rate >=0?HYCOLOR(253, 66, 74, 1):HYCOLOR(0, 171, 60, 1);
    _price.textColor = rate >=0?HYCOLOR(253, 66, 74, 1):HYCOLOR(0, 171, 60, 1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
