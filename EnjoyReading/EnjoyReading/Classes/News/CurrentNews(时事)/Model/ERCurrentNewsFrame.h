//
//  ERCurrentNewsFrame.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/14.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ERCurrentNews;
@interface ERCurrentNewsFrame : NSObject

/** 新闻数据 */
@property (nonatomic, strong) ERCurrentNews *currentNews;

/**  标题 */
@property (nonatomic, assign) CGRect titleFrame;
/**  内容 */
@property (nonatomic, assign) CGRect contentFrame;
/**  发布时间 */
@property (nonatomic, assign) CGRect pdateFrame;
/**  来源 */
@property (nonatomic, assign) CGRect srcFrame;
/**  图片 */
@property (nonatomic, assign) CGRect imgFrame;

/**  分隔线 */
@property (nonatomic, assign) CGRect spFrame;

/**  cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
