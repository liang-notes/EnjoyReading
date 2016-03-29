//
//  ERHealthType.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/18.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHealthType.h"

@implementation ERHealthType

+ (instancetype)healthTypeWithDict:(NSDictionary *)dict
{
    ERHealthType *healthType = [[self alloc] init];
//    healthType.icon
    [healthType setValuesForKeysWithDictionary:dict];
    
    return healthType;
}

@end
