//
//  ERItemView.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/7.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ERItem;
@interface ERItemView : UIButton
/** item模型 */
@property (nonatomic, strong) ERItem *item;
/** item的位置 */
@property (nonatomic, assign) NSInteger index;
+(instancetype)itemViewWithItem:(ERItem *)item;

@end
