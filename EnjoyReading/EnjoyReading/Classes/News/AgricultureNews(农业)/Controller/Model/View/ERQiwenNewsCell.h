//
//  ERQiwenNewsCell.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/25.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ERQiwenNews;
@interface ERQiwenNewsCell : UITableViewCell
/** 国内新闻模型 */
@property (nonatomic, strong) ERQiwenNews *qiwenNews;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
