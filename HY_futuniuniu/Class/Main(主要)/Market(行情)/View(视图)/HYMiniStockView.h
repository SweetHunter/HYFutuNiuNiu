//
//  HYMiniStockView.h
//  HY_futuniuniu
//
//  Created by tongfang on 2017/12/28.
//  Copyright © 2017年 Hyman. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYMiniStockViewDelegate<NSObject>

@optional

- (void)HYMiniStockViewDidSelectedItemAtIndex:(NSInteger)index;

- (void)HYMiniStockViewDidClickDownBtn;

@end

@interface HYMiniStockView : UIView

@property (nonatomic,weak) id <HYMiniStockViewDelegate>delegate;

@end
