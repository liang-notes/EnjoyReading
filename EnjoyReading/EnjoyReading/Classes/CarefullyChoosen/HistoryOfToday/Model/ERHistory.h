//
//  ERHistory.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/9.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERHistory : NSObject

/**  年份 */
@property (nonatomic, copy) NSString *year;

/**  事件 */
@property (nonatomic, copy) NSString *title;

/** cell的高度 */
@property (assign, nonatomic) CGFloat cellHeight;

@end
