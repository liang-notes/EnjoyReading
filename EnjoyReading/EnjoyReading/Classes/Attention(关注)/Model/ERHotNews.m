//
//  ERHotNews.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/22.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHotNews.h"
#import "NSDate+MJ.h"
#import "MJExtension.h"

@implementation ERHotNews
MJCodingImplementation

+ (instancetype)hotNewsWithDict:(NSDictionary *)dict
{
    ERHotNews *hotNews = [[self alloc] init];
    [hotNews setValuesForKeysWithDictionary:dict];
    return hotNews;
}

- (void)setTime:(NSString *)time
{
    NSInteger ss = [time doubleValue] * 0.001;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *atime = [NSDate dateWithTimeIntervalSince1970:ss];
    NSString *tt = [fmt stringFromDate:atime];
    _time = tt;

}

@end
