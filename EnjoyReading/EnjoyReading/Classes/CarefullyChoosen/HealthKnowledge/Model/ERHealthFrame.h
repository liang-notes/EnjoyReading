//
//  ERHealthFrame.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/18.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ERHealth;
@interface ERHealthFrame : NSObject

/** 模型 */
@property (nonatomic, strong) ERHealth *health;

/**  标题 */
@property (nonatomic, assign) CGRect titleLabelFrame;

/**  描述 */
@property (nonatomic, assign) CGRect descripLabelFrame;

/**  图片 */
@property (nonatomic, assign) CGRect imgViewFrame;

/**  发布时间 */
@property (nonatomic, assign) CGRect timeLabelFrame;

/**  收藏数 */
@property (nonatomic, assign) CGRect fcountLabelFrame;

/**  访问数 */
@property (nonatomic, assign) CGRect countLabelFrame;

/**  分隔线 */
@property (nonatomic, assign) CGRect spViewFrame;

/**  cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
