//
//  ERFoodListFrame.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/17.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERFoodListFrame.h"
#import "ERFoodList.h"

#define NameFont [UIFont systemFontOfSize:16]
#define FoodFont [UIFont systemFontOfSize:14]
#define DescFont [UIFont systemFontOfSize:14]
#define keywordsFont [UIFont systemFontOfSize:12]
#define Margin 10;
@implementation ERFoodListFrame

- (void)setFoodList:(ERFoodList *)foodList
{
    _foodList = foodList;
    
    // 菜名
    CGFloat nameX = Margin;
    CGFloat nameY = Margin;
    CGSize nameSize = [foodList.name sizeWithAttributes:@{NSFontAttributeName:NameFont}];
    _nameLabelFrame = (CGRect){{nameX,nameY},nameSize};
    
    // 材料
    CGFloat foodX = Margin;
    CGFloat foodY = CGRectGetMaxY(_nameLabelFrame) + 0.5 * Margin;
    CGFloat foodW = ScreenW - 2 * Margin;
    CGSize foodSize = [foodList.food boundingRectWithSize:CGSizeMake(foodW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FoodFont} context:nil].size;
    _foodLabelFrame = (CGRect){{foodX,foodY},foodSize};
    
    // 做法
    CGFloat descX = Margin;
    CGFloat descY = CGRectGetMaxY(_foodLabelFrame) + 0.5 * Margin;
    CGFloat descW = ScreenW - 2 * Margin;
    CGSize descSize = [foodList.foodDescription boundingRectWithSize:CGSizeMake(descW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DescFont} context:nil].size;
    _foodDescriptionLabelFrame = (CGRect){{descX,descY},descSize};
    
    // 图片
    CGFloat iconX = Margin;
    CGFloat iconY = CGRectGetMaxY(_foodDescriptionLabelFrame) + 0.5 * Margin;
    CGFloat iconW = 0.6 * ScreenW;
    CGFloat iconH = 0.25 * ScreenH;
    _iconViewFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 进度
    CGFloat progressW = 100;
    CGFloat progressH = 100;
    CGFloat progressX = 0.5 * (iconW - progressW);
    CGFloat progressY = 0.5 * (iconH - progressH);
    _progressFrame = CGRectMake(progressX, progressY, progressW, progressH);
    
    // 关键字
    CGFloat keywordX = Margin;
    CGFloat keywordY = CGRectGetMaxY(_iconViewFrame) + 0.5 * Margin;
    CGSize keywordSize = [foodList.foodDescription sizeWithAttributes:@{NSFontAttributeName:keywordsFont}];
    _keywordsLabelFrame = (CGRect){{keywordX,keywordY},keywordSize};
    
    // 分隔线
    CGFloat spViewX = 0;
    CGFloat spViewY = CGRectGetMaxY(_keywordsLabelFrame)+0.5 * Margin;
    CGFloat spViewW = ScreenW;
    CGFloat spViewH = 1;
    _spViewFrame = CGRectMake(spViewX, spViewY, spViewW, spViewH);
    
    // cell 高度
    _cellHeight = CGRectGetMaxY(_spViewFrame);
}

@end
