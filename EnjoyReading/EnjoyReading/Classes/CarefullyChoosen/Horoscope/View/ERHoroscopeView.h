//
//  ERHoroscopeView.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/16.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ERHoroscope;
@interface ERHoroscopeView : UIButton

/** 星座模型 */
@property (nonatomic, strong) ERHoroscope *horoscope;
+ (instancetype)horoscopeViewWithHoroscope:(ERHoroscope *)horoscope;

@end
