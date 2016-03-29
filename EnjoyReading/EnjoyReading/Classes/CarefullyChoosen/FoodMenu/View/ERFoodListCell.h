//
//  ERFoodListCell.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/17.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ERFoodListFrame;
@interface ERFoodListCell : UITableViewCell
/** VM模型数据 */
@property (nonatomic, strong) ERFoodListFrame *foodListFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
