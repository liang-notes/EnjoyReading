//
//  ERCategoryCell.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/21.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ERAttentionCategory;
@interface ERCategoryCell : UITableViewCell
/** 类别数据 */
@property (nonatomic, strong) ERAttentionCategory *category;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
