//
//  ERBgView.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/15.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ERBgView;

@protocol ERBgViewDelegate <NSObject>
@optional
- (void)bgView:(ERBgView *)bgView didSelectedButtonAtIndex:(NSInteger)index;
@end
@interface ERBgView : UIView
@property (nonatomic, weak) id<ERBgViewDelegate>delegate;
@end
