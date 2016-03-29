//
//  ERHealthTypeCell.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/18.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERWaterflowViewCell.h"
@class ERHealthType,ERWaterflowView;
@interface ERHealthTypeCell : ERWaterflowViewCell
/** 类别 */
@property (nonatomic, strong) ERHealthType *healthType;

+ (instancetype)cellWithWaterflowView:(ERWaterflowView *)waterflowView;
@end
