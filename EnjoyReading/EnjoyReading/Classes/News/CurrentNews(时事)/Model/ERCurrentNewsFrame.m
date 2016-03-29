//
//  ERCurrentNewsFrame.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/14.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERCurrentNewsFrame.h"
#import "ERCurrentNews.h"

@interface ERCurrentNewsFrame()

@end

@implementation ERCurrentNewsFrame

- (void)setCurrentNews:(ERCurrentNews *)currentNews
{
    _currentNews = currentNews;
    
    // 计算子控件的frame
    CGFloat titleX = NewsCellMargin;
    CGFloat titleY = NewsCellMargin;
    CGFloat titleW = ScreenW - 2 * NewsCellMargin;
    CGSize titleSize = [_currentNews.title boundingRectWithSize:CGSizeMake(titleW ,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:NewsTitleFont} context:nil].size;
    _titleFrame = (CGRect){{titleX,titleY},titleSize};
    
    
    if (currentNews.img.length) {
        CGFloat imgX = titleX;
        CGFloat imgY = CGRectGetMaxY(_titleFrame) + NewsCellMargin;
        CGFloat imgW = ScreenW - 2 * NewsCellMargin;
        CGFloat imgH = 200;
        _imgFrame = CGRectMake(imgX, imgY, imgW, imgH);
        
        CGFloat contentX = titleX;
        CGFloat contentY = CGRectGetMaxY(_imgFrame) + NewsCellMargin;
        CGFloat contentW = ScreenW - 2 * NewsCellMargin;
        CGSize contentSize = [_currentNews.content boundingRectWithSize:CGSizeMake(contentW ,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:NewsContentFont} context:nil].size;
        _contentFrame = (CGRect){{contentX,contentY},contentSize};
        
        CGFloat srcX = contentX;
        CGFloat srcY = CGRectGetMaxY(_contentFrame) + NewsCellMargin * 0.5;
        CGSize srcSize = [_currentNews.src sizeWithAttributes:@{NSFontAttributeName:NewsErdescriptionFont}];
        _srcFrame = (CGRect){{srcX,srcY},srcSize};
        
        CGFloat pdateX = CGRectGetMaxX(_srcFrame) + NewsCellMargin;
        CGFloat pdateY = srcY;
        CGSize pdateSize = [_currentNews.pdate sizeWithAttributes:@{NSFontAttributeName:NewsErdescriptionFont}];
        _pdateFrame = (CGRect){{pdateX,pdateY},pdateSize};
        
         _spFrame = CGRectMake(0, CGRectGetMaxY(_srcFrame) + 5, ScreenW, 1);
        
        _cellHeight = CGRectGetMaxY(_spFrame);

    }else{
    CGFloat contentX = titleX;
    CGFloat contentY = CGRectGetMaxY(_titleFrame) + NewsCellMargin;
    CGFloat contentW = ScreenW - 2 * NewsCellMargin;
    CGSize contentSize = [_currentNews.content boundingRectWithSize:CGSizeMake(contentW ,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:NewsContentFont} context:nil].size;
    _contentFrame = (CGRect){{contentX,contentY},contentSize};
    
    CGFloat srcX = contentX;
    CGFloat srcY = CGRectGetMaxY(_contentFrame) + NewsCellMargin * 0.5;
    CGSize srcSize = [_currentNews.src sizeWithAttributes:@{NSFontAttributeName:NewsErdescriptionFont}];
    _srcFrame = (CGRect){{srcX,srcY},srcSize};
    
    CGFloat pdateX = CGRectGetMaxX(_srcFrame) + NewsCellMargin;
    CGFloat pdateY = srcY;
    CGSize pdateSize = [_currentNews.pdate sizeWithAttributes:@{NSFontAttributeName:NewsErdescriptionFont}];
    _pdateFrame = (CGRect){{pdateX,pdateY},pdateSize};
        
    _spFrame = CGRectMake(0, CGRectGetMaxY(_srcFrame) + 5 , ScreenW, 1);
    
    _cellHeight = CGRectGetMaxY(_spFrame) ;
    }
}

@end
