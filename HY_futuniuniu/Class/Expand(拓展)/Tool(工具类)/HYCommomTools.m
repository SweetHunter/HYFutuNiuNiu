//
//  HYCommomTools.m
//  HY_futuniuniu
//
//  Created by tongfang on 2017/11/21.
//  Copyright © 2017年 Hyman. All rights reserved.
//

#import "HYCommomTools.h"

@implementation HYCommomTools

+ (UIImage*)createImageWithColor:(UIColor*)color{
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage*image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
