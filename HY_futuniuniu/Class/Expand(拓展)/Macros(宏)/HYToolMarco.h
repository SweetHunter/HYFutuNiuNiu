//
//  HYToolMarco.h
//  HY_futuniuniu
//
//  Created by tongfang on 2017/11/20.
//  Copyright © 2017年 Hyman. All rights reserved.
//

#ifndef HYToolMarco_h
#define HYToolMarco_h

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define HYCOLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define HYFONT(f) [UIFont systemFontOfSize:f]
//导航栏颜色
#define NAVIGATIONBARCOLOR HYCOLOR(30, 34, 45, 1)

//tabBar颜色
#define TABBARCOLOR HYCOLOR(26, 29, 35, 1)

/*行情页面*/
//行情页面主体颜色
#define MARKETMAINCOLOR HYCOLOR(30, 34, 45, 1)

#endif /* HYToolMarco_h */
