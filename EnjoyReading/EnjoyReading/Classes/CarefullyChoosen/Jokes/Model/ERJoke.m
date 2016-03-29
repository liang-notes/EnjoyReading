//
//  ERJoke.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/8.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERJoke.h"
#import "NSDate+MJ.h"

@implementation ERJoke

//- (void)setUpdatetime:(NSString *)updatetime
//{
//    _updatetime = updatetime;
//    
//    NSDateFormatter *format = [[NSDateFormatter alloc] init];
//    format.dateFormat =
//}

- (NSString *)updatetime
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *updatetime = [fmt dateFromString:_updatetime];

    if ([updatetime isThisYear]) { //当前时间是今年
        
        if ([updatetime isToday]) { //当前时间是今天
            
            NSDateComponents *cmp = [updatetime deltaWithNow];

            if (cmp.hour > 1) {
                return [NSString stringWithFormat:@"%ld小时前",(long)cmp.hour];
            }else if (cmp.minute > 1){
                return [NSString stringWithFormat:@"%ld分钟前",(long)cmp.minute];
            }else{
                return @"刚刚";
            }
            
        }else if ([updatetime isYesterday]){ //当前时间是昨天
            
            fmt.dateFormat = @"昨天 HH:MM";
            return [fmt stringFromDate:updatetime];
            
        }else{ //当前时间是前天
            
            fmt.dateFormat = @"MM-DD HH:MM";
            return [fmt stringFromDate:updatetime];
        }
        
    }else{ // 不是今年
        fmt.dateFormat = @"YYYY-MM-DD HH:MM";
        return [fmt stringFromDate:updatetime];
    }

}

@end
