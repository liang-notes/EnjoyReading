//
//  ERNews.m
//  预习-03-无限滚动
//
//  Created by MJ Lee on 14-5-30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ERNews.h"

@implementation ERNews
+ (instancetype)newsWithDict:(NSDictionary *)dict
{
    ERNews *news = [[self alloc] init];
    [news setValuesForKeysWithDictionary:dict];
    return news;
}
@end
