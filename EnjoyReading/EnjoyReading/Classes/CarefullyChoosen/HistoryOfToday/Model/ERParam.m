//
//  ERParam.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/9.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERParam.h"
#import "ERHistoryOfTodayController.h"

@implementation ERParam

- (NSString *)yue
{

    // 日期格式转换
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSDate *date =[format dateFromString:_yue];
    NSString *dateStr = [format stringFromDate:date];
    // 截取字符
    NSRange range = [dateStr rangeOfString:@"-"];
    dateStr = [dateStr substringFromIndex:(range.location +range.length)];
    range = [dateStr rangeOfString:@"-"];
    dateStr = [dateStr substringToIndex:range.location];
    _yue = dateStr;

    return _yue;
}

- (NSString *)ri
{
    // 日期格式转换
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
//    format.dateFormat = @"MM-dd";
//    NSDate *now = [NSDate date];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *date =[format dateFromString:_ri];
    NSString *dateStr = [format stringFromDate:date];

    // 截取字符
    NSRange range = [dateStr rangeOfString:@"-"];
    dateStr = [dateStr substringFromIndex:(range.location +range.length)];
    range = [dateStr rangeOfString:@"-"];
    dateStr = [dateStr substringFromIndex:(range.location +range.length)];
    _ri = dateStr;
    
    return _ri;
}

@end
