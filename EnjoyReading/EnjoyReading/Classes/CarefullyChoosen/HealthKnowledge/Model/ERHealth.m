//
//  ERHealth.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/18.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHealth.h"

@implementation ERHealth
+ (instancetype)healthWithDict:(NSDictionary *)dict
{
    ERHealth *health = [[self alloc] init];
    health.title = dict[@"title"];
    health.descrip = dict[@"description"];
    health.img = dict[@"img"];
    health.count = dict[@"count"];
    health.fcount = dict[@"fcount"];
    health.time = dict[@"time"];
    health.idstr = dict[@"id"];
    
    return health;
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

- (void)setFcount:(NSString *)fcount
{

    _fcount = [NSString stringWithFormat:@"收藏数: %@",fcount];
}

-(void)setCount:(NSString *)count
{
    _count =  [NSString stringWithFormat:@"访问数: %@",count];
}

//{"id":15,"description":"这是由子宫内膜侵入子宫肌层引起，但像郑小姐这样严重的情形并不多见，她的子宫已经扩大到婴儿脑袋大小，每个月大量出血导致她重度贫血，即使手术剥离了子宫内膜，不久还是会复发，只能通过切除子宫来彻底根除","img":"http://api.avatardata.cn/Lore/Img?file=5be1515933824854a04288b4bbae7ebc.jpg","keywords":"子宫 小姐 止痛药 医院 多年 ","title":"痛经多年靠止痛药硬扛 最终女子痛失子宫","loreclass":5,"time":1438305261000,"fcount":0,"count":101}

@end
