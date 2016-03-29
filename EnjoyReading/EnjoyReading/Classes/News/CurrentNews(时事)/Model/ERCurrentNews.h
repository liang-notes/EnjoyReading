//
//  ERCurrentNews.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/13.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERCurrentNews : NSObject

/**  标题 */
@property (nonatomic, copy) NSString *title;
/**  内容 */
@property (nonatomic, copy) NSString *content;
/**  发布时间 */
@property (nonatomic, copy) NSString *pdate;
/**  来源 */
@property (nonatomic, copy) NSString *src;
/**  详细地址 */
@property (nonatomic, copy) NSString *url;
/**  图片 */
@property (nonatomic, copy) NSString *img;
@end
