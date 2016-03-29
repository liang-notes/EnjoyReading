//
//  ERHealthDetailView.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/18.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ERHealthDetail;
@interface ERHealthDetailCell : UITableViewCell
/** 模型 */
@property (nonatomic, strong) ERHealthDetail *healthDtail;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
