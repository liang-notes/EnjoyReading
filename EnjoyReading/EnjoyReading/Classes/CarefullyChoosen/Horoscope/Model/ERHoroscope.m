//
//  ERHoroscope.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/16.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHoroscope.h"

@implementation ERHoroscope

+(instancetype)horoscopeWithDict:(NSDictionary *)dict
{
    ERHoroscope *horo = [[self alloc] init];
//    dict["icon"] = horo.icon;
    [horo setValuesForKeysWithDictionary:dict];
    return horo;
}

@end
