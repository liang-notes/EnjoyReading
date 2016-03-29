//
//  ERHealth.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/18.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERHealth : NSObject
/**  id */
@property (nonatomic, copy) NSString *idstr;
/**  标题 */
@property (nonatomic, copy) NSString *title;

/**  描述 */
@property (nonatomic, copy) NSString *descrip;

/**  图片 */
@property (nonatomic, copy) NSString *img;

/**  发布时间 */
@property (nonatomic, copy) NSString *time;

/**  收藏数 */
@property (nonatomic, copy) NSString *fcount;

/**  访问数 */
@property (nonatomic, copy) NSString *count;


+ (instancetype)healthWithDict:(NSDictionary *)dict;


@end
