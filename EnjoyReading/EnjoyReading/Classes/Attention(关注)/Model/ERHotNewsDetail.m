//
//  ERHotNewsDetail.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/22.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHotNewsDetail.h"

@implementation ERHotNewsDetail
+ (instancetype)hotNewsDetailWithDict:(NSDictionary *)dict
{
    ERHotNewsDetail *hotNewsDetail = [[self alloc] init];
    hotNewsDetail.title = dict[@"title"];
    hotNewsDetail.descript = dict[@"description"];
    hotNewsDetail.message = dict[@"message"];
    hotNewsDetail.time = dict[@"time"];
    hotNewsDetail.img = dict[@"img"];
    hotNewsDetail.fromname = dict[@"fromname"];
    hotNewsDetail.keywords = dict[@"keywords"];
    hotNewsDetail.fromurl = dict[@"fromurl"];
    
    return hotNewsDetail;
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
    msg = [msg stringByReplacingOccurrencesOfString:@"<span>" withString:@"\n"];
    msg = [msg stringByReplacingOccurrencesOfString:@"</span>" withString:@""];
    msg = [msg stringByReplacingOccurrencesOfString:@"<b>" withString:@"\n"];
    msg = [msg stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
    msg = [msg stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
    _message = msg;
}
@end
