//
//  ERHealthType.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/18.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERHealthType : NSObject
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *uid;

+ (instancetype)healthTypeWithDict:(NSDictionary *)dict;
@end
