//
//  ERItem.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/7.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERItem.h"

@implementation ERItem

+ (instancetype)itemWithDict:(NSDictionary *)dict
{
    ERItem *item = [[self alloc] init];
    [item setValuesForKeysWithDictionary:dict];
    
    return item;
}
@end
