//
//  ERBookList.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/23.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERBookList.h"

@implementation ERBookList

- (void)setCount:(NSString *)count
{
    _count = [NSString stringWithFormat:@"%@人阅读过",count];
}

- (void)setAuthor:(NSString *)author
{
    _author = [NSString stringWithFormat:@"作者: %@",author];
}

- (void)setSummary:(NSString *)summary
{
    NSString *msg = [summary stringByReplacingOccurrencesOfString:@"<br>" withString:@""];

    _summary = msg;
}

@end
