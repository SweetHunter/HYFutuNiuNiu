//
//  HYStockModel.h
//  HY_futuniuniu
//
//  Created by tongfang on 2017/11/23.
//  Copyright © 2017年 Hyman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYStockModel : NSObject

/**
 股票名称
 */
@property (nonatomic,copy) NSString *name;

/**
 股票代码
 */
@property (nonatomic,copy) NSString *code;

/**
 市场
 */
@property (nonatomic,copy) NSString *market;

/**
 最新价
 */
@property (nonatomic,copy) NSString *price;

/**
 昨收
 */
@property (nonatomic,copy) NSString *yesterdayClosePrice;

/**
 是否停牌
 */
@property (nonatomic,assign) BOOL suspended;
@end
