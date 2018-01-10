//
//  UITabBar+HYOverlay.m
//  HY_futuniuniu
//
//  Created by tongfang on 2017/11/20.
//  Copyright © 2017年 Hyman. All rights reserved.
//

#import "UITabBar+HYOverlay.h"
#import <objc/runtime.h>
@implementation UITabBar (HYOverlay)
static char overlayKey;
- (UIView *)overlay{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN);
}

- (void)setTabBarBackGroundColor:(UIColor *)backGroundColor{
    if (!self.overlay) {
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backGroundColor;
}

@end
