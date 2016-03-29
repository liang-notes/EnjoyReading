//
//  ERWxNewsCell.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/7.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ERWxNews;
@interface ERWxNewsCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 微博模型数据 */
@property (nonatomic, strong) ERWxNews *wxNews;
@end
