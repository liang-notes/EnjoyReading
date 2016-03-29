//
//  ERJokeCell.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/8.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ERJoke;
@interface ERJokeCell : UITableViewCell
/** 笑话模型 */
@property (nonatomic, strong) ERJoke *joke;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
