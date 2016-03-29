//
//  ERItemsView.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/7.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERItemsView.h"
#import "ERItemView.h"
#import "ERItem.h"

@interface ERItemsView()
/** 数据 */
@property (strong, nonatomic) NSArray *items;
@property (nonatomic, weak) ERItemView *selectedButton;
@end
@implementation ERItemsView

- (NSArray *)items
{
    if (_items == nil) {
        // 加载plist文件
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"topics.plist" ofType:nil];
        NSArray *dictArrary = [NSArray arrayWithContentsOfFile:filePath];
        NSMutableArray *itemArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArrary) {
            ERItem *item = [ERItem itemWithDict:dict];
            [itemArray addObject:item];
        }
        _items = itemArray;
    }
    return _items;
}

#pragma mark --初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        // 添加子控件
        int count = 8;
        for (NSInteger i = 0; i < count; i++) {
            
            ERItemView *itemView = [ERItemView itemViewWithItem:self.items[i]];
            itemView.tag = i;
            [itemView addTarget:self action:@selector(itemViewDidClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:itemView];
        
        }
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置按钮的frame
    NSInteger btnCount = self.subviews.count;
    CGFloat btnW = 80 ;
    CGFloat btnH = 100;
    for (int i = 0 ; i < btnCount; i++) {
        // 一行的列数
        NSInteger cols = 4;
        // 每一列之间的间距
        CGFloat colMargin = (self.frame.size.width - cols * btnW) / (cols + 1);
        
        // 每一行之间的间距
        CGFloat rowMargin = 10;
        
        // 图标的x值
        NSInteger col = i % cols;
        CGFloat btnX = col * (btnW + colMargin) + colMargin;
        
        // 图标的y值
        NSInteger row = i / cols;
        CGFloat btnY = row * (btnH + rowMargin) + rowMargin;
        
        ERItemView *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = btnX;
        btn.y = btnY;
 
    }
    
}

#pragma mark --私有方法
/**
 *  监听按钮的点击
 */
- (void)itemViewDidClick:(ERItemView *)button
{
    
    // 1.通知代理
    if ([self.delegate respondsToSelector:@selector(itemsView:didSelectedButtonIndex:)]) {
        [self.delegate itemsView:self didSelectedButtonIndex:button.tag];
    
//        ERLog(@"点击了%ld",button.tag);
       
    }
//    // 2.控制按钮的状态
//    self.selectedButton.selected = NO;
//    button.selected = YES;
//    self.selectedButton = button;
}

@end
