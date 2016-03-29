//
//  ERHoroscopeView.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/16.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHoroscopeView.h"
#import "ERHoroscope.h"

@implementation ERHoroscopeView

+ (instancetype)horoscopeViewWithHoroscope:(ERHoroscope *)horoscope
{
    ERHoroscopeView *horo = [[self alloc] init];
    horo.horoscope = horoscope;
    return horo;
}

// 调整子控件的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat buttonW = self.frame.size.width;
    CGFloat buttonH = self.frame.size.height;

    self.imageView.frame = CGRectMake(0, 0, buttonW, buttonH);
}

- (void)setHoroscope:(ERHoroscope *)horoscope
{
    _horoscope = horoscope;
    
    [self setImage:[UIImage imageNamed:horoscope.icon] forState:UIControlStateNormal];
}

@end
