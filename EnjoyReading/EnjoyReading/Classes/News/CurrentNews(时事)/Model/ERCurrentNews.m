//
//  ERCurrentNews.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/13.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERCurrentNews.h"



@implementation ERCurrentNews

- (void)setContent:(NSString *)content
{
    NSString *c = [content stringByReplacingOccurrencesOfString:@"<em>" withString:@""];
    _content = [c stringByReplacingOccurrencesOfString:@"</em>" withString:@""];

}
@end
