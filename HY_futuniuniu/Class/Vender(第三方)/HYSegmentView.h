//
//  HYSegmentView.h
//  HY_futuniuniu
//
//  Created by tongfang on 2017/11/21.
//  Copyright © 2017年 Hyman. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYSegmentViewDelegate <NSObject>

@optional

- (void)HYSegmentViewDidSelectedItemAtIndex:(NSInteger)index;

@end

@interface HYSegmentView : UIView

/**
 初始化

 @param frame 尺寸
 @param titles item的标题
 @return 对象
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles;

/**
 未选中时的颜色
 */
@property (nonatomic,strong) UIColor *normolColor;

/**
 选中时的颜色
 */
@property (nonatomic,strong) UIColor *selectedColor;

/**
 item字体的大小
 */
@property (nonatomic,assign) CGFloat fontSize;

/**
 背景颜色
 */
@property (nonatomic,strong) UIColor *mainViewBackGroundColor;

/**
 代理
 */
@property (nonatomic,weak) id <HYSegmentViewDelegate> delegate;
@end
