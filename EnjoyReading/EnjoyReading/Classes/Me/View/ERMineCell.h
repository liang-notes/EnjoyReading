//
//  ERMineCell.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/14.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ERMineItem;
@interface ERMineCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(NSUInteger)rows;

/** cell对应的item数据 */
@property (nonatomic, strong) ERMineItem *item;
@end
