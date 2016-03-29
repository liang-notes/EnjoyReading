//
//  ERItemView.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/7.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERItemView.h"
#import "ERItem.h"

@interface ERItemView()

/** 被点击的按钮 */
//@property (nonatomic, strong)  UIButton *itemView;
@end

@implementation ERItemView

+ (instancetype)itemViewWithItem:(ERItem *)item
{
    ERItemView *itemView = [[self alloc] init];
//    itemView.backgroundColor = [UIColor redColor];
    itemView.item = item;
    return itemView;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.backgroundColor = ERGlobalBackground;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    return self;
}
- (void)setItem:(ERItem *)item
{
    _item = item;
    
    // 设置子控件的数据
    if (item.icon) {
        [self setImage:[UIImage imageNamed:item.icon] forState:UIControlStateNormal];
    }
    [self setTitle:item.title forState:UIControlStateNormal];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat buttonW = self.frame.size.width;
    CGFloat buttonH = self.frame.size.height;
    
    CGFloat imageH = buttonW ;
    self.imageView.frame = CGRectMake(0, 0, buttonW, imageH);
    self.titleLabel.frame = CGRectMake(0, imageH, buttonW, buttonH - imageH);
}



@end
