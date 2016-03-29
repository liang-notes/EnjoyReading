//
//  ERNavigationController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/2/28.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERNavigationController.h"

@interface ERNavigationController ()

@end

@implementation ERNavigationController

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
//    UINavigationBar *bar = [[UINavigationBar alloc] init];
    [bar setBackgroundImage: [UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
//    [bar setBackgroundImage: [UIImage imageWithStretchableName:@"c_xiaoshuo"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}
/**
 *  拦截push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count > 0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:ERGlobalTitleColor forState:UIControlStateHighlighted];
//        [button sizeToFit];
        button.size = CGSizeMake(70, 30);
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 让按钮的内容往左边偏移10
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;

    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
