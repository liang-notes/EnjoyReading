//
//  ERFood.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/17.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERFoodList : NSObject
//{"id":102234,"description":"买了两个榴莲回来，一次没有吃完，就全部取肉后打成茸，冷冻在冰箱保存，随吃随拿","name":"榴莲西米","food":"榴莲,牛奶,西米,柚子,蒟蒻,搅拌机","img":"http://api.avatardata.cn/Cook/Img?file=603be4f923de47e080c3cf2ab4777e12.jpg","keywords":"榴莲 牛奶 全透明 搅拌 冷藏 ","count":4}

/**  菜名 */
@property (nonatomic, copy) NSString *name;
/**  材料 */
@property (nonatomic, copy) NSString *food;
/**  描述 */
@property (nonatomic, copy) NSString *foodDescription;
/**  关键字 */
@property (nonatomic, copy) NSString *keywords;
/**  图片 */
@property (nonatomic, copy) NSString *icon;

/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;

+ (instancetype)foodListWithDict:(NSDictionary *)dict;

@end
