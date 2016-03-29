//
//  UIBarButtonItem+Extension.m
//  羊羊微博
//
//  Created by 王亮 on 15/11/9.
//  Copyright (c) 2015年 wangliang. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    // 设置导航栏按钮
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = button.currentBackgroundImage.size;
    // 监听按钮点击事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title  target:(id)target action:(SEL)action
{
    // 设置导航栏按钮
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 设置按钮的尺寸为背景图片的尺寸
    [button sizeToFit];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    // 监听按钮点击事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
