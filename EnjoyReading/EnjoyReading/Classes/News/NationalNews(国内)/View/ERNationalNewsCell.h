//
//  ERNationalNewsCell.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/10.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ERNationalNews;
@interface ERNationalNewsCell : UITableViewCell
/** 国内新闻模型 */
@property (nonatomic, strong) ERNationalNews *nationalNews;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
