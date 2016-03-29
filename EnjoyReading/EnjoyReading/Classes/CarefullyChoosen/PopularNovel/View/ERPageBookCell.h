//
//  ERPageBookCell.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/23.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ERPageBook;
@interface ERPageBookCell : UITableViewCell
/** 模型 */
@property (nonatomic, strong) ERPageBook *pageBook;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
