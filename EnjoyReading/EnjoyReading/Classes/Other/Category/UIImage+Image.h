//
//  UIImage+Image.h
//  毛毛微博
//
//  Created by 王亮 on 14/5/8.
//  Copyright (c) 2014年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

// 加载最原始的图
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

// 加载拉伸过的图
+ (instancetype)imageWithStretchableName:(NSString *)imageName;

// 通过颜色创建一张纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
