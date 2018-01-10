//
//  HYStockListTabHeaderView.h
//  HY_futuniuniu
//
//  Created by tongfang on 2017/11/24.
//  Copyright © 2017年 Hyman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYStockListTabHeaderView : UIView

@end

@interface HYControlView :UIView

@property (nonatomic,assign) NSInteger currentPage;

- (instancetype)initWithFrame:(CGRect)frame page:(NSInteger)page;
@end

@interface HYCheckMarkView:UIView

@end
