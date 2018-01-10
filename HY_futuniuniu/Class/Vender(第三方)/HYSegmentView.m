//
//  HYSegmentView.m
//  HY_futuniuniu
//
//  Created by tongfang on 2017/11/21.
//  Copyright © 2017年 Hyman. All rights reserved.
//

#import "HYSegmentView.h"
#import "UIView+YYAdd.h"
#import "NSString+HYRect.h"
@interface HYSegmentView()
@property (nonatomic,copy) NSArray<NSString *>*titles;
@property (nonatomic,strong) UIButton *currentSelectedBtn;
@property (nonatomic,strong) UIView *indicatorView;
@property (nonatomic,strong) NSMutableArray <UIButton *>*itemButtons;
@end

@implementation HYSegmentView

- (NSMutableArray<UIButton *> *)itemButtons{
    if (_itemButtons == nil) {
        _itemButtons = @[].mutableCopy;
    }
    return _itemButtons;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles{
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        //初始化数据
        [self initDatas];
        //创建item视图
        [self addItemView];
        //创建item底部指示器
        [self addItemIndicatorView];
    }
    return self;
}

- (void)initDatas{
    self.normolColor = [UIColor whiteColor];
    self.selectedColor = HYCOLOR(50, 124, 226, 1);
    self.fontSize = 13.f;
    self.mainViewBackGroundColor = NAVIGATIONBARCOLOR;
}

- (void)addItemView{
    self.backgroundColor = self.mainViewBackGroundColor;
    CGFloat itemWidth = self.width/self.titles.count;
    [self.titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn.tag = 10+idx;
        itemBtn.frame = CGRectMake(itemWidth*idx, 0, itemWidth, self.height);
        [itemBtn setTitle:obj forState:UIControlStateNormal];
        [itemBtn setTitleColor:self.normolColor forState:UIControlStateNormal];
        [itemBtn setTitleColor:self.selectedColor forState:UIControlStateSelected];
        itemBtn.titleLabel.font = HYFONT(self.fontSize);
        [itemBtn addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itemBtn];
        [self.itemButtons addObject:itemBtn];
        if (idx == 0) {
            [self itemClick:itemBtn];
        }
    }];
}

- (void)addItemIndicatorView{
    CGRect itemTitleRect = [self.currentSelectedBtn.currentTitle rectwithAttribute:@{NSFontAttributeName:HYFONT(self.fontSize)}];
    UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-1, itemTitleRect.size.width+20, 2.f)];
    self.indicatorView = indicatorView;
    indicatorView.centerX = self.currentSelectedBtn.centerX;
    indicatorView.backgroundColor = self.selectedColor;
    [self addSubview:indicatorView];
}

- (void)itemClick:(UIButton *)sender{
    sender.selected = YES;
    self.currentSelectedBtn.selected = NO;
    self.currentSelectedBtn = sender;
    [UIView animateWithDuration:0.15f animations:^{
        self.indicatorView.centerX = self.currentSelectedBtn.centerX;
    }];
    if (self.delegate && [self.delegate respondsToSelector:@selector(HYSegmentViewDidSelectedItemAtIndex:)]) {
        [self.delegate HYSegmentViewDidSelectedItemAtIndex:sender.tag - 10];
    }
}
@end
