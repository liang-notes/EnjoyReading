//
//  ERQiwenNews.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/25.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERQiwenNews.h"


@implementation ERQiwenNews
+ (instancetype)qiwenNewsWithDict:(NSDictionary *)dict
{
    ERQiwenNews *qiwenNews = [[self alloc] init];
    qiwenNews.title = dict[@"title"];
    qiwenNews.erdescription = dict[@"description"];
    qiwenNews.ctime = dict[@"ctime"];
    qiwenNews.picUrl = dict[@"picUrl"];
    qiwenNews.url = dict[@"url"];
    return qiwenNews;
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
