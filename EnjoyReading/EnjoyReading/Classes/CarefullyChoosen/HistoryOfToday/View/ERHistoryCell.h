//
//  ERHistoryCell.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/9.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ERHistory;
@interface ERHistoryCell : UITableViewCell

/** 历史数据模型 */
@property (nonatomic, strong) ERHistory *history;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
