//
//  ERTabBar.h
//  EnjoyReading
//
//  Created by 王亮 on 16/2/28.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ERTabBar;
@protocol ERTabBarDelegate <NSObject>

@optional
- (void)tabBar:(ERTabBar *)tabBar didClickButton:(NSInteger)index;

@end

@interface ERTabBar : UIView

// items:保存每一个按钮对应tabBarItem模型
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id<ERTabBarDelegate> delegate;

@end
