//
//  ERPopMenu.h
//  
//
//  Created by 王亮 on 15/11/10.
//  Copyright (c) 2015年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ERPopMenuArrowPositionCenter = 0,
    ERPopMenuArrowPositionLeft = 1,
    ERPopMenuArrowPositionRight = 2
} ERPopMenuArrowPosition;

@class ERPopMenu;

@protocol ERPopMenuDelegate <NSObject>

@optional
- (void)popMenuDidDismissed:(ERPopMenu *)popMenu;
@end

@interface ERPopMenu : UIView
@property (nonatomic, weak) id<ERPopMenuDelegate> delegate;

@property (nonatomic, assign, getter = isDimBackground) BOOL dimBackground;

@property (nonatomic, assign) ERPopMenuArrowPosition arrowPosition;

/**
 *  初始化方法
 */
- (instancetype)initWithContentView:(UIView *)contentView;
+ (instancetype)popMenuWithContentView:(UIView *)contentView;

/**
 *  设置菜单的背景图片
 */
- (void)setBackground:(UIImage *)background;

/**
 *  显示菜单
 */
- (void)showInRect:(CGRect)rect;

/**
 *  关闭菜单
 */
- (void)dismiss;
@end
