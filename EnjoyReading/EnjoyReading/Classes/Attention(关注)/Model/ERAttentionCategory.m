//
//  ERAttentionCategory.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/21.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERAttentionCategory.h"

@implementation ERAttentionCategory
- (NSMutableArray *)hotNewses{
    if (_hotNewses == nil) {
        _hotNewses = [NSMutableArray array];
    }
    return _hotNewses;
}

- (void)setName:(NSString *)name
{
    NSRange range = [name rangeOfString:@"热点"];
    _name = [name substringToIndex:range.location];
}
@end
