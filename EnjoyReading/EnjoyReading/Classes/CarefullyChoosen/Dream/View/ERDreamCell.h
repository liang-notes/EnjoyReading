//
//  ERDreamCell.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/16.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ERDream;
@interface ERDreamCell : UITableViewCell

/** dream模型 */
@property (nonatomic, strong) ERDream *dream;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
