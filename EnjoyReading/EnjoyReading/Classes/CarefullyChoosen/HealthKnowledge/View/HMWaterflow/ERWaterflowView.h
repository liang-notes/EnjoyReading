//
//  ERWaterflowView.h
//  06-瀑布流
//
//  Created by apple on 14-7-28.
//  Copyright (c) 2014年 heima. All rights reserved.
//  使用瀑布流形式展示内容的控件

#import <UIKit/UIKit.h>

typedef enum {
    ERWaterflowViewMarginTypeTop,
    ERWaterflowViewMarginTypeBottom,
    ERWaterflowViewMarginTypeLeft,
    ERWaterflowViewMarginTypeRight,
    ERWaterflowViewMarginTypeColumn, // 每一列
    ERWaterflowViewMarginTypeRow, // 每一行
} ERWaterflowViewMarginType;

@class ERWaterflowView, ERWaterflowViewCell;

/**
 *  数据源方法
 */
@protocol ERWaterflowViewDataSource <NSObject>
@required
/**
 *  一共有多少个数据
 */
- (NSUInteger)numberOfCellsInWaterflowView:(ERWaterflowView *)waterflowView;
/**
 *  返回index位置对应的cell
 */
- (ERWaterflowViewCell *)waterflowView:(ERWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index;

@optional
/**
 *  一共有多少列
 */
- (NSUInteger)numberOfColumnsInWaterflowView:(ERWaterflowView *)waterflowView;
@end

/**
 *  代理方法
 */
@protocol ERWaterflowViewDelegate <UIScrollViewDelegate>
@optional
/**
 *  第index位置cell对应的高度
 */
- (CGFloat)waterflowView:(ERWaterflowView *)waterflowView heightAtIndex:(NSUInteger)index;
/**
 *  选中第index位置的cell
 */
- (void)waterflowView:(ERWaterflowView *)waterflowView didSelectAtIndex:(NSUInteger)index;
/**
 *  返回间距
 */
- (CGFloat)waterflowView:(ERWaterflowView *)waterflowView marginForType:(ERWaterflowViewMarginType)type;
@end

/**
 *  瀑布流控件
 */
@interface ERWaterflowView : UIScrollView
/**
 *  数据源
 */
@property (nonatomic, weak) id<ERWaterflowViewDataSource> dataSource;
/**
 *  代理
 */
@property (nonatomic, weak) id<ERWaterflowViewDelegate> delegate;

/**
 *  刷新数据（只要调用这个方法，会重新向数据源和代理发送请求，请求数据）
 */
- (void)reloadData;

/**
 *  cell的宽度
 */
- (CGFloat)cellWidth;

/**
 *  根据标识去缓存池查找可循环利用的cell
 */
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
@end
