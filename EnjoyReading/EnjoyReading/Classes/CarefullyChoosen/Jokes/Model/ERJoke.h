//
//  ERJoke.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/8.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERJoke : NSObject
/**  内容 */
@property (nonatomic, copy) NSString *content;
/**  更新时间 */
@property (nonatomic, copy) NSString *updatetime;

/** cell的高度 */
@property (assign, nonatomic) CGFloat cellHeight;
@end
