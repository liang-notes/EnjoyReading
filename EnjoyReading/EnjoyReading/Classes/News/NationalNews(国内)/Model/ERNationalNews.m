//
//  ERNationalNews.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/10.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERNationalNews.h"

@implementation ERNationalNews
+ (instancetype)nationalNewsWithDict:(NSDictionary *)dict
{
    ERNationalNews *nationalNews = [[self alloc] init];
    nationalNews.title = dict[@"title"];
    nationalNews.erdescription = dict[@"description"];
    nationalNews.ctime = dict[@"ctime"];
    nationalNews.picUrl = dict[@"picUrl"];
    nationalNews.url = dict[@"url"];
    return nationalNews;
}

//- (NSString *)ctime
//{
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
//    NSDate *ctime = [fmt dateFromString:_ctime];
//    fmt.dateFormat = @"yyyy-MM-dd";
//    _ctime = [fmt stringFromDate:ctime];
//    return _ctime;
//}

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
