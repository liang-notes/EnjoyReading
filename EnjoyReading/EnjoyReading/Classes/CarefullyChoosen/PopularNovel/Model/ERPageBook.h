//
//  ERPageBook.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/23.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERPageBook : NSObject
/**  标题 */
@property (nonatomic, copy) NSString *title;

/**  内容 */
@property (nonatomic, copy) NSString *message;

/**  页码（章节） */
@property (nonatomic, copy) NSString *id;

/**  高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
