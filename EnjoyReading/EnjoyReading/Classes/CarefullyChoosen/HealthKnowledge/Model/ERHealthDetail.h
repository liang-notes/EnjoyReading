//
//  ERHealthDetail.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/18.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERHealthDetail : NSObject
/**  标题 */
@property (nonatomic, copy) NSString *title;
/**  描述 */
@property (nonatomic, copy) NSString *descrip;
/**  图片 */
@property (nonatomic, copy) NSString *img;
/**  内容 */
@property (nonatomic, copy) NSString *message;
/**  时间 */
@property (nonatomic, copy) NSString *time;
/**  关键字 */
@property (nonatomic, copy) NSString *keywords;
/**  访问数 */
@property (nonatomic, copy) NSString *count;
/**  收藏数 */
@property (nonatomic, copy) NSString *fcount;

/**  cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

+ (instancetype)healthDetailWithDict:(NSDictionary *)dict;


@end
