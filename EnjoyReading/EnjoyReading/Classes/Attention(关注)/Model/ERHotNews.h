//
//  ERHotNews.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/22.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERHotNews : NSObject

/**  每一条的id */
@property (nonatomic, copy) NSString *id;
/**  标题 */
@property (nonatomic, copy) NSString *title;
/**  类别 */
@property (nonatomic, copy) NSString *topclass;
/**  简介 */
@property (nonatomic, copy) NSString *descript;
/**  来源 */
@property (nonatomic, copy) NSString *fromname;
/**  网址 */
@property (nonatomic, copy) NSString *fromurl;
/**  关键字 */
@property (nonatomic, copy) NSString *keywords;
/**  时间 */
@property (nonatomic, copy) NSString *time;
/**  访问数 */
@property (nonatomic, copy) NSString *count;
/**  图片 */
@property (nonatomic, copy) NSString *img;

/**  cellHeight */
@property (nonatomic, assign) CGFloat cellHeight;

+ (instancetype)hotNewsWithDict:(NSDictionary *)dict;
@end
