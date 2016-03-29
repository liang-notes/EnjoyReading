//
//  ERWxNews.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/7.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERWxNews.h"

@implementation ERWxNews
+ (instancetype)wxNewsWithDict:(NSDictionary *)dict
{
    ERWxNews *wxNews = [[self alloc] init];
    wxNews.title = dict[@"title"];
    wxNews.picUrl = dict[@"picUrl"];
    wxNews.er_description = dict[@"description"];
    wxNews.url = dict[@"url"];
//    wxNews.hottime = dict[@"hottime"];
    
    return wxNews;
}

- (void)setEr_description:(NSString *)er_description
{
    _er_description = [NSString stringWithFormat:@"来自:%@",er_description];
}
@end
