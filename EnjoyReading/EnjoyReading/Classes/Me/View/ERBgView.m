//
//  ERBgView.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/15.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERBgView.h"
#import "ERMessageBtn.h"

@interface ERBgView()
@property (nonatomic, weak) ERMessageBtn *selectedButton;
@end

@implementation ERBgView
#pragma mark --初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        [self setupBtnWithIcon:@"setting_xiaoxi" hightIcon:@"setting_xiaoxi" title:@"消息" backgroundColor:ERColor(78, 123, 177)];
        [self setupBtnWithIcon:@"setting_tongzhi" hightIcon:@"setting_tongzhi" title:@"通知" backgroundColor:ERColor(78, 123, 177)];
            }
    return self;
}

/**
 *  添加按钮
 *
 *  @param icon  按钮图标
 *  @param title 按钮标题
 */
- (ERMessageBtn *)setupBtnWithIcon:(NSString *)icon hightIcon:(NSString *)hightIcon title:(NSString *)title backgroundColor:(UIColor *)backgroundColor
{
    
    ERMessageBtn *btn = [[ERMessageBtn alloc] init];
    btn.tag = self.subviews.count;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    //设置图片和标题
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hightIcon] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:ERColor(78, 123, 177) forState:UIControlStateNormal];
    [btn setTitleColor:ERGlobalTitleColor forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    //设置按钮选中背景
    [btn setBackgroundImage:[UIImage imageWithColor:backgroundColor] forState:UIControlStateSelected];
    
    //设置高亮的时候不要让图标变色
//    btn.adjustsImageWhenHighlighted = NO;
    
    //设置按钮的内容左对齐
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    //设置间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    
    return btn;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置按钮的frame
    NSInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width /btnCount ;
    CGFloat btnH = self.height;
    for (int i = 0 ; i < btnCount; i++) {
        ERMessageBtn *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = i * btnW;
        btn.y = 0;
    }
    
}

#pragma mark --私有方法
/**
 *  监听按钮的点击
 */

- (void)buttonClick:(ERMessageBtn *)button
{
    // 1.通知代理
    if ([self.delegate respondsToSelector:@selector(bgView:didSelectedButtonAtIndex:)]) {
        [self.delegate bgView:self didSelectedButtonAtIndex:button.tag];
    }
    
//    // 2.控制按钮的状态
//    self.selectedButton.selected = NO;
//    button.selected = YES;
//    self.selectedButton = button; 
}

@end
