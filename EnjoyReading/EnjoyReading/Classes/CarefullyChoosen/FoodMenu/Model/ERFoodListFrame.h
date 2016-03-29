//
//  ERFoodListFrame.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/17.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ERFoodList;
@interface ERFoodListFrame : NSObject

/** 数据模型 */
@property (nonatomic, strong) ERFoodList *foodList;
/**  菜名 */
@property (nonatomic, assign) CGRect nameLabelFrame;
/**  材料 */
@property (nonatomic, assign) CGRect foodLabelFrame;
/**  描述 */
@property (nonatomic, assign) CGRect foodDescriptionLabelFrame;
/**  关键字 */
@property (nonatomic, assign) CGRect keywordsLabelFrame;
/**  图片 */
@property (nonatomic, assign) CGRect iconViewFrame;
/**  分隔线 */
@property (nonatomic, assign) CGRect spViewFrame;
/**  进度 */
@property (nonatomic, assign) CGRect progressFrame;
/**
 *  cell高度
 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
