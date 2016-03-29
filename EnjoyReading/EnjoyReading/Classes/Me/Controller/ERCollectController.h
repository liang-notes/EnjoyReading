//
//  ERCollectController.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/14.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ERCollectController : UITableViewController

/**  id */
@property (nonatomic, copy) NSString *id;

/** 接收模型的数组 */
@property (nonatomic, strong) NSMutableArray *smodels;

@end
