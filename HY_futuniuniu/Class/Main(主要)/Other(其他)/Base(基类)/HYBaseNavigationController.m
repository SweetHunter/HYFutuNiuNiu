//
//  HYBaseNavigationController.m
//  HY_futuniuniu
//
//  Created by tongfang on 2017/11/16.
//  Copyright © 2017年 Hyman. All rights reserved.
//

#import "HYBaseNavigationController.h"
#import "UINavigationBar+HYOverlay.h"
@interface HYBaseNavigationController ()

@end

@implementation HYBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setNavigationBarBackGroundColor:NAVIGATIONBARCOLOR];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
