//
//  ERAttentionCategory.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/21.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERAttentionCategory : NSObject
/**  id */
@property (nonatomic, copy) NSString *id;
/**  名称 */
@property (nonatomic, copy) NSString *name;

/** 这个类别对应的新闻数据 */
@property (nonatomic, strong) NSMutableArray *hotNewses;

/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;

/** 总数 */
@property (nonatomic, assign) NSInteger total;

/**  cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
