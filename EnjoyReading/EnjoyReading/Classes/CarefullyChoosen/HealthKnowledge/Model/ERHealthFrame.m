//
//  ERHealthFrame.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/18.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHealthFrame.h"
#import "ERHealth.h"

#define HealthTitleFont [UIFont boldSystemFontOfSize:16]
#define HealthDescipFont [UIFont systemFontOfSize:14]
#define HealthTimeFont [UIFont systemFontOfSize:14]
#define HealthCountFont [UIFont systemFontOfSize:12]
#define Margin 10;
@implementation ERHealthFrame

-(void)setHealth:(ERHealth *)health
{
    _health = health;
    
    // 标题
    CGFloat titleLabelX = Margin;
    CGFloat titleLabelY = Margin;
    CGFloat titleLabelW = ScreenW - 2 * Margin;
    CGSize titleLabelSize = [health.title boundingRectWithSize:CGSizeMake(titleLabelW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:HealthTitleFont} context:nil].size;
    _titleLabelFrame = (CGRect){{titleLabelX,titleLabelY},titleLabelSize};
    
    // 描述
    CGFloat descripLabelX = titleLabelX;
    CGFloat descripLabelY = CGRectGetMaxY(_titleLabelFrame) + 0.5 * Margin;
    CGFloat descripLabelW = ScreenW - 2 * Margin;
    CGSize descripLabelSize = [health.descrip boundingRectWithSize:CGSizeMake(descripLabelW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:HealthDescipFont} context:nil].size;
    _descripLabelFrame = (CGRect){{descripLabelX,descripLabelY},descripLabelSize};

    // 图片
    CGFloat imgViewX = descripLabelX;
    CGFloat imgViewY = CGRectGetMaxY(_descripLabelFrame) + 0.5 * Margin;
    CGFloat imgViewW = 0.6 * ScreenW;
    CGFloat imgViewH = 0.25 * ScreenH;
    _imgViewFrame = CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH);

    // 收藏数
    CGFloat fcountLabelX = imgViewX;
    CGFloat fcountLabelY = CGRectGetMaxY(_imgViewFrame) + 0.5 * Margin;
    CGFloat fcountLabelW = 0.5 * ScreenW - Margin;
    CGFloat fcountLabelH = 30;
    _fcountLabelFrame = CGRectMake(fcountLabelX, fcountLabelY, fcountLabelW, fcountLabelH);

    // 访问数
    CGFloat countLabelX = CGRectGetMaxX(_fcountLabelFrame);
    CGFloat countLabelY = fcountLabelY;
    CGFloat countLabelW = fcountLabelW;
    CGFloat countLabelH = fcountLabelH;
    _countLabelFrame = CGRectMake(countLabelX, countLabelY, countLabelW, countLabelH);

    // 分隔线
    CGFloat spViewX = 0;
    CGFloat spViewY = CGRectGetMaxY(_fcountLabelFrame) + 0.5 * Margin;
    CGFloat spViewW = ScreenW;
    CGFloat spViewH = 1;
    _spViewFrame = CGRectMake(spViewX, spViewY, spViewW, spViewH);
    
    _cellHeight = CGRectGetMaxY(_spViewFrame);
}

@end
