//
//  ERCurrenrNewsCell.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/13.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ERCurrentNewsFrame.h"

@interface ERCurrenrNewsCell : UITableViewCell
/** 新闻 */
@property (nonatomic, strong) ERCurrentNewsFrame *currentNewsF;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
