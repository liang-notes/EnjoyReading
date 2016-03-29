//
//  ERPageBook.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/23.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERPageBook.h"

@implementation ERPageBook

-(void)setMessage:(NSString *)message
{

    NSString *msg = [message stringByReplacingOccurrencesOfString:@"<div>" withString:@""];
    msg = [msg stringByReplacingOccurrencesOfString:@"</div>" withString:@""];
    msg = [msg stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    msg = [msg stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    _message = msg;
    
}

@end
