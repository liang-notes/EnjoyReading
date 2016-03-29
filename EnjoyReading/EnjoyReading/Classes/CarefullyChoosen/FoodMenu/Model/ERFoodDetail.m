//
//  ERFoodDetail.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/19.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERFoodDetail.h"

@implementation ERFoodDetail

+ (instancetype)foodDetailWithDict:(NSDictionary *)dict
{
    ERFoodDetail *foodDetail = [[self alloc] init];
    foodDetail.name = dict[@"name"];
    foodDetail.food = dict[@"food"];
    foodDetail.descrip = dict[@"description"];
    foodDetail.img = dict[@"img"];
    foodDetail.message = dict[@"message"];
    foodDetail.keywords = dict[@"keywords"];
    foodDetail.fcount = dict[@"fcount"];
    foodDetail.rcount = dict[@"rcount"];
    foodDetail.count = dict[@"count"];

    return foodDetail;
}

- (void)setMessage:(NSString *)message
{
    NSString *msg = [message stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    msg = [msg stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
    msg = [msg stringByReplacingOccurrencesOfString:@"<h2>" withString:@"\n"];
    msg = [msg stringByReplacingOccurrencesOfString:@"</h2>" withString:@""];
    msg = [msg stringByReplacingOccurrencesOfString:@"<hr>" withString:@""];
    _message = msg;
}

- (void)setFcount:(NSString *)fcount
{
    _fcount = [NSString stringWithFormat:@"收藏数: %@",fcount];
}

- (void)setRcount:(NSString *)rcount
{
    _rcount = [NSString stringWithFormat:@"回复数: %@",rcount];
}

- (void)setCount:(NSString *)count
{
     _count = [NSString stringWithFormat:@"访问数: %@",count];
}

@end
