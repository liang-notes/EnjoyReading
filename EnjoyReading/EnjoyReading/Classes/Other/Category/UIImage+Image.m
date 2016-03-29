//
//  UIImage+Image.m
//  毛毛微博
//
//  Created by 王亮 on 14/5/8.
//  Copyright (c) 2014年 wangliang. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

// 原始图片
+ (instancetype)imageWithOriginalName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

// 拉伸图片
+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

// 通过颜色创建一张图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGFloat imageW = 100;
    CGFloat imageH = 100;
    // 1.开启基于位图的图形上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0.0);
    
    // 2.画一个color颜色的矩形框
    [color set];
    UIRectFill(CGRectMake(0, 0, imageW, imageH));
    
    // 3.拿到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
    
}

@end
