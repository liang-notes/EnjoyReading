//
//  ERHotNewsDetail.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/22.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERHotNewsDetail : NSObject
/**  标题 */
@property (nonatomic, copy) NSString *title;
/**  简介 */
@property (nonatomic, copy) NSString *descript;

/**  详情 */
@property (nonatomic, copy) NSString *message;

/**  时间 */
@property (nonatomic, copy) NSString *time;

/**  图片 */
@property (nonatomic, copy) NSString *img;

/**  来源 */
@property (nonatomic, copy) NSString *fromname;

/**  关键字 */
@property (nonatomic, copy) NSString *keywords;

/**  链接 */
@property (nonatomic, copy) NSString *fromurl;

/**  cellHeight */
@property (nonatomic, assign) CGFloat cellHeight;

+ (instancetype)hotNewsDetailWithDict:(NSDictionary *)dict;

@end
