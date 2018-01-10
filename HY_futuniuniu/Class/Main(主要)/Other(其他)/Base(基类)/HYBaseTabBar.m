//
//  HYBaseTabBar.m
//  HY_futuniuniu
//
//  Created by tongfang on 2017/11/20.
//  Copyright © 2017年 Hyman. All rights reserved.
//

#import "HYBaseTabBar.h"
#import "UITabBar+HYOverlay.h"
@implementation HYBaseTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setTabBarBackGroundColor:TABBARCOLOR];
}

@end
