//
//  ERHoroBgView.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/16.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ERHoroBgView;
@protocol ERHoroBgViewDelegate <NSObject>

@optional
- (void)horoBgView:(ERHoroBgView *)horoBgView didSelectedButtonIndex:(NSInteger)index;
@end
@interface ERHoroBgView : UIView
/**  代理 */
@property (nonatomic, weak) id<ERHoroBgViewDelegate>delegate;
@end
