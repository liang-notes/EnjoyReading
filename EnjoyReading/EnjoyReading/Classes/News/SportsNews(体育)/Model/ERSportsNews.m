//
//  ERNationalNews.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/10.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERSportsNews.h"

@implementation ERSportsNews
+ (instancetype)sportsNewsWithDict:(NSDictionary *)dict
{
    ERSportsNews *news = [[self alloc] init];
    news.title = dict[@"title"];
    news.erdescription = dict[@"description"];
    news.ctime = dict[@"ctime"];
    news.picUrl = dict[@"picUrl"];
    news.url = dict[@"url"];
    return news;
}

- (void)setCtime:(NSString *)ctime
{
    _ctime = ctime;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *ctimedate = [fmt dateFromString:_ctime];
    fmt.dateFormat = @"yyyy-MM-dd";
    _ctime = [fmt stringFromDate:ctimedate];

}
@end
