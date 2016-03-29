//
//  ERHoroscope.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/16.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERHoroscope : NSObject
/**  图标 */
@property (nonatomic, copy) NSString *icon;
/**  名称 */
@property (nonatomic, copy) NSString *name;


+ (instancetype)horoscopeWithDict:(NSDictionary *)dict;

@end
