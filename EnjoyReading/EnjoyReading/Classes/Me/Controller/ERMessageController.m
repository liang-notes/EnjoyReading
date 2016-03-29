//
//  ERMessageController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/14.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERMessageController.h"
#import "ERBgView.h"

@interface ERMessageController ()<ERBgViewDelegate>

@property (nonatomic, weak) ERBgView *bgView;
@property (nonatomic, weak) UILabel *label;
@end

@implementation ERMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ERGlobalBackground;
    
    // 添加背景
    ERBgView *bgView = [[ERBgView alloc] init];
    bgView.frame = CGRectMake(0, 64, ScreenW, 35);
    bgView.delegate = self;
    [self.view addSubview:bgView];
    self.bgView = bgView;

    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 99, ScreenW, ScreenH - 99);
    label.backgroundColor = ERColor(245, 245, 245);
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label.text = @"暂无消息";
    self.label = label;
 
}
#pragma mark --代理方法
- (void)bgView:(ERBgView *)bgView didSelectedButtonAtIndex:(NSInteger)index
{
    if (index == 0) {
       self.label.text = @"暂无消息";
        ERLog(@"点击了消息");
    }else{
        self.label.text = @"暂无通知";
        ERLog(@"点击了通知");
    }
}

@end
