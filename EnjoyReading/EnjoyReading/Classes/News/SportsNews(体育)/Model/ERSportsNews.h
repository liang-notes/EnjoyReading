//
//  ERNationalNews.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/10.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERSportsNews : NSObject
/**  时间 */
@property (nonatomic, copy) NSString *ctime;
/**  标题 */
@property (nonatomic, copy) NSString *title;
/**  描述 */
@property (nonatomic, copy) NSString *erdescription;
/**  图片 */
@property (nonatomic, copy) NSString *picUrl;
/**  详情 */
@property (nonatomic, copy) NSString *url;

///** cell的高度 */
@property (assign, nonatomic) CGFloat cellHeight;

+ (instancetype)sportsNewsWithDict:(NSDictionary *)dict;
@end
