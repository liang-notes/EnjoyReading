//
//  ERItemsView.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/7.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ERItemsView;
@protocol ERItemsViewDelegate <NSObject>

@optional
- (void)itemsView:(ERItemsView *)menu didSelectedButtonIndex:(NSInteger)index;
@end
@interface ERItemsView : UIView
@property (nonatomic, weak) id<ERItemsViewDelegate>delegate;
@end
