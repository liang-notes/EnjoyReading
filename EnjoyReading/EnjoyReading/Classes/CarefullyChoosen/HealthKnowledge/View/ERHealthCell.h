//
//  ERHealthCell.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/18.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ERHealthFrame;
@interface ERHealthCell : UITableViewCell

/** VM模型 */
@property (nonatomic, strong) ERHealthFrame *healthFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
