//
//  HYBaseTabBarController.m
//  HY_futuniuniu
//
//  Created by tongfang on 2017/11/16.
//  Copyright © 2017年 Hyman. All rights reserved.
//

#import "HYBaseTabBarController.h"
#import "HYBaseTabBar.h"
#import "HYInfomationController.h"
#import "HYMyController.h"
#import "HYMarketController.h"
#import "HYTradeController.h"
#import "HYCircleOfNiuController.h"
#import "HYBaseNavigationController.h"
@interface HYBaseTabBarController ()

@end

@implementation HYBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //自定义TabBar
    [self addCustomTabBar];
    //添加子控制器
    [self addChildControllers];
}

/**
 自定义TabBar
 */
- (void)addCustomTabBar{
    
    HYBaseTabBar *tabBar = [[HYBaseTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
}


/**
 添加子控制器
 */
- (void)addChildControllers{
    
    HYMarketController *marketController = [[HYMarketController alloc] init];
    [self addChildViewController:marketController tabBarItemTitle:@"行情" tabBarItemImage:[UIImage imageNamed:@"skin_tabbar_icon_quote_normal"] tabBarItemSelectImage:[UIImage imageNamed:@"skin_tabbar_icon_quote_selected"]];
    
    HYTradeController *tradeController = [[HYTradeController alloc] init];
    [self addChildViewController:tradeController tabBarItemTitle:@"交易" tabBarItemImage:[UIImage imageNamed:@"skin_tabbar_icon_trade_normal"] tabBarItemSelectImage:[UIImage imageNamed:@"skin_tabbar_icon_trade_selected"]];

    HYInfomationController *infoMationController = [[HYInfomationController  alloc] init];
    [self addChildViewController:infoMationController tabBarItemTitle:@"资讯" tabBarItemImage:[UIImage imageNamed:@"skin_tabbar_icon_news_normal"] tabBarItemSelectImage:[UIImage imageNamed:@"skin_tabbar_icon_news_selected"]];
    
    HYCircleOfNiuController *circleOfNiuController = [[HYCircleOfNiuController alloc] init];
    [self addChildViewController:circleOfNiuController tabBarItemTitle:@"牛牛圈" tabBarItemImage:[UIImage imageNamed:@"skin_tabbar_icon_nncircle_normal"] tabBarItemSelectImage:[UIImage imageNamed:@"skin_tabbar_icon_nncircle_selected"]];
    
    HYMyController *myController = [[HYMyController alloc] init];
     [self addChildViewController:myController tabBarItemTitle:@"我的" tabBarItemImage:[UIImage imageNamed:@"skin_tabbar_icon_mine_normal"] tabBarItemSelectImage:[UIImage imageNamed:@"skin_tabbar_icon_mine_selected"]];
}
    
    

/**
 逐个添加子控制器

 @param viewController 被添加的子控制器
 @param title tabBarItem 的标题
 @param image 未选中时的图像
 @param selectImage 选中时的图像
 */
- (void)addChildViewController:(UIViewController *)viewController tabBarItemTitle:(NSString *)title tabBarItemImage:(UIImage *)image tabBarItemSelectImage:(UIImage *)selectImage{
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = image;
    viewController.tabBarItem.selectedImage = selectImage;
    
    HYBaseNavigationController *baseNav = [[HYBaseNavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:baseNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}



@end
