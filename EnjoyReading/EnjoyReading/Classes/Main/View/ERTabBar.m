//
//  ERTabBar.m
//  EnjoyReading
//
//  Created by 王亮 on 16/2/28.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERTabBar.h"
#import "ERTabBarButton.h"

@interface ERTabBar()

@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation ERTabBar
- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    
    // 遍历模型数组，创建对应tabBarButton
    for (UITabBarItem *item in _items) {
        
        ERTabBarButton *btn = [ERTabBarButton buttonWithType:UIButtonTypeCustom];
        
        // 给按钮赋值模型，按钮的内容由模型对应决定
        btn.item = item;
        
        btn.tag = self.buttons.count;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        if (btn.tag == 0) { // 选中第0个
            [self btnClick:btn];
            
        }
        
        [self addSubview:btn];
        
        
        // 把按钮添加到按钮数组
        [self.buttons addObject:btn];
    }
}

// 点击tabBarButton调用
-(void)btnClick:(UIButton *)button
{
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
    // 通知tabBarVc切换控制器，
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:button.tag];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    // 设置tabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / self.items.count;
    CGFloat buttonH = height;
    NSInteger index = 0;
    
    for (UIView *tabBarButton in self.subviews) {
        
        CGFloat buttonX = buttonW * index;
        tabBarButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index++;
    }
}

@end
