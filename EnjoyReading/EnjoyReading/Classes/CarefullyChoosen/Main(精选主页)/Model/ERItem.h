//
//  ERItem.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/7.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERItem : NSObject

/** 名称 */
@property (nonatomic, strong) NSString *title;
/** 图标 */
@property (nonatomic, strong) NSString *icon;


+ (instancetype)itemWithDict:(NSDictionary *)dict;

@end
