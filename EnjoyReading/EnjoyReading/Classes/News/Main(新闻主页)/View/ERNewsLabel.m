//
//  ERNewsLabel.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/11.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERNewsLabel.h"
#import "ERConst.h"

@implementation ERNewsLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15];
        self.textColor = [UIColor colorWithRed:ERRed green:ERGreen blue:ERBlue alpha:1.0];
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    //      R G B
    // 默认：0.4 0.6 0.7
    // 红色：1   0   0
    
    CGFloat red = ERRed + (1 - ERRed) * scale;
    CGFloat green = ERGreen + (0 - ERGreen) * scale;
    CGFloat blue = ERBlue + (0 - ERBlue) * scale;
    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    // 大小缩放比例
    CGFloat transformScale = 1 + scale * 0.3; // [1, 1.3]
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
}

@end
