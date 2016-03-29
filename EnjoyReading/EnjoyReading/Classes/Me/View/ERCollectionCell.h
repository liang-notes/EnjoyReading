//
//  ERHotNewsCell.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/22.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ERHotNews;
@interface ERCollectionCell : UITableViewCell
/** 模型数据 */
@property (nonatomic, strong) ERHotNews *hotNews;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end