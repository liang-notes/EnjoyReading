//
//  ERHotNewsDetailCell.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/22.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ERHotNewsDetail;
@interface ERHotNewsDetailCell : UITableViewCell
/** 模型数据 */
@property (nonatomic, strong) ERHotNewsDetail *hotNewsDetail;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
