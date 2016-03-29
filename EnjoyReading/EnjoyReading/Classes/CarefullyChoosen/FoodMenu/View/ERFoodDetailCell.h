//
//  ERFoodDetailCell.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/19.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ERFoodDetail;
@interface ERFoodDetailCell : UITableViewCell
/** 模型 */
@property (nonatomic, strong) ERFoodDetail *foodDetail;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
