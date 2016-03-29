//
//  ERWxNews.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/7.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERWxNews : NSObject
/**  名称 */
@property (nonatomic, copy) NSString *title;
/**  时间 */
@property (nonatomic, copy) NSString *hottime;
///**  描述（来源） */
@property (nonatomic, copy) NSString *er_description;
/**  图片 */
@property (nonatomic, copy) NSString *picUrl;
/**  详情页 */
@property (nonatomic, copy) NSString *url;

/** cell的高度 */
@property (assign, nonatomic) CGFloat cellHeight;

+ (instancetype)wxNewsWithDict:(NSDictionary *)dict;
@end
