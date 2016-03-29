//
//  ERHoroBgView.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/16.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHoroBgView.h"
#import "ERHoroscope.h"
#import "ERHoroscopeView.h"

@interface ERHoroBgView()

/** 星座模型数据 */
@property (nonatomic, strong) NSArray *horoscopes;


@end

@implementation ERHoroBgView
-(NSArray *)horoscopes
{
    if (_horoscopes ==nil) {
        // 加载plist数据(字典数组)
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"horoscope.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:filePath];
        NSMutableArray *horoArr = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            ERHoroscope *horo = [ERHoroscope horoscopeWithDict:dict];
            [horoArr addObject:horo];
        }
        _horoscopes = horoArr;
    }
    return _horoscopes;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // 添加子控件
        int count = 12;
        for (NSInteger i = 0; i < count; i++) {
            
            ERHoroscopeView *horoView = [ERHoroscopeView horoscopeViewWithHoroscope:self.horoscopes[i]];
            horoView.tag = i;
            [horoView addTarget:self action:@selector(horoViewDidClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:horoView];
        }
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置按钮的frame
    NSInteger btnCount = self.subviews.count;
    CGFloat btnW = 104;
    CGFloat btnH = 137;
    for (int i = 0 ; i < btnCount; i++) {
        // 一行的列数
        NSInteger cols = 3;
        // 每一列之间的间距
        CGFloat colMargin = (self.frame.size.width - cols * btnW) / (cols + 1);
        
        // 每一行之间的间距
        CGFloat rowMargin = 10;
        
        // 图标的x值
        NSInteger col = i % cols;
        CGFloat btnX = col * (btnW + colMargin) + colMargin;
        
        // 图标的y值
        NSInteger row = i / cols;
        CGFloat btnY = row * (btnH + rowMargin) + rowMargin;
        
        ERHoroscopeView *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = btnX;
        btn.y = btnY;
        
    }
    
}

#pragma mark --私有方法
/**
 *  监听按钮的点击
 */
- (void)horoViewDidClick:(ERHoroscopeView *)button
{
    
    // 1.通知代理
    if ([self.delegate respondsToSelector:@selector(horoBgView:didSelectedButtonIndex:)]) {
        [self.delegate horoBgView:self didSelectedButtonIndex:button.tag];
        
        //        ERLog(@"点击了%ld",button.tag);
        
    }
    //    // 2.控制按钮的状态
    //    self.selectedButton.selected = NO;
    //    button.selected = YES;
    //    self.selectedButton = button;
}


@end
