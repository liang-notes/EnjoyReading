//
//  ERHealthDetail.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/18.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHealthDetail.h"

@implementation ERHealthDetail
+ (instancetype)healthDetailWithDict:(NSDictionary *)dict
{
    ERHealthDetail *healthDetail = [[self alloc] init];
    healthDetail.title = dict[@"title"];
    healthDetail.descrip = dict[@"description"];
    healthDetail.img = dict[@"img"];
    healthDetail.message = dict[@"message"];
    healthDetail.time = dict[@"time"];
    healthDetail.keywords = dict[@"keywords"];
    healthDetail.fcount = dict[@"fcount"];
    healthDetail.count = dict[@"count"];

    return healthDetail;
}


- (void)setTime:(NSString *)time
{
    
    NSInteger ss = [time doubleValue] * 0.001;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *atime = [NSDate dateWithTimeIntervalSince1970:ss];
    NSString *tt = [fmt stringFromDate:atime];
    _time = [NSString stringWithFormat:@"发表时间: %@",tt];
}

- (void)setMessage:(NSString *)message
{
    NSString *msg = [message stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    msg = [msg stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
    msg = [msg stringByReplacingOccurrencesOfString:@"<strong>" withString:@"\n"];
    msg = [msg stringByReplacingOccurrencesOfString:@"</strong>" withString:@""];
    msg = [msg stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
    _message = msg;
}

- (void)setFcount:(NSString *)fcount
{
    
    _fcount = [NSString stringWithFormat:@"收藏数: %@",fcount];
}

-(void)setCount:(NSString *)count
{
    _count =  [NSString stringWithFormat:@"访问数: %@",count];
}

@end
