//
//  ERNewsPushController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/14.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERNewsPushController.h"

@interface ERNewsPushController ()

@end

@implementation ERNewsPushController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ERGlobalBackground;
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 64, ScreenW, ScreenH - 64);
    label.backgroundColor = ERColor(245, 245, 245);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"暂无内容";
    [self.view addSubview:label];
    
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
