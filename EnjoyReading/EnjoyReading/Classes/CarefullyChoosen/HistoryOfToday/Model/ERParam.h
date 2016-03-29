//
//  ERParam.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/9.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERParam : NSObject

/**  api秘钥 */
@property (nonatomic, copy) NSString *key;
/**  月份 */
@property (nonatomic, copy) NSString *yue;
/**  日 */
@property (nonatomic, copy) NSString *ri;
/**  类型 */
@property (nonatomic, copy) NSString *type;
/**  行数 */
@property (nonatomic, copy) NSString *row;

@end
