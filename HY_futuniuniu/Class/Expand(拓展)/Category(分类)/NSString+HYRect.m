//
//  NSString+HYRect.m
//  TongFangSecurity
//
//  Created by tongfang on 2017/6/30.
//  Copyright © 2017年 Tongfang Capital Management Co., Ltd. All rights reserved.
//

#import "NSString+HYRect.h"

@implementation NSString (HYRect)
- (CGRect)rectwithAttribute:(NSDictionary *)attribute {
    CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                                               options:NSStringDrawingTruncatesLastVisibleLine |         NSStringDrawingUsesLineFragmentOrigin |
                                                                   NSStringDrawingUsesFontLeading
                                                           attributes:attribute
                                                               context:nil];
    return rect;
}

@end
