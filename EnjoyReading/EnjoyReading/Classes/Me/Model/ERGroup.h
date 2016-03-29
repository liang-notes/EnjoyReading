//
//  ERGroup.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/14.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERGroup : NSObject
/** 组头 */
@property (nonatomic, copy) NSString *header;
/** 组尾 */
@property (nonatomic, copy) NSString *footer;
/** 这组的所有行模型(数组中存放的都是WLCommonItem模型) */
@property (nonatomic, strong) NSArray *items;

+ (instancetype)group;
@end
