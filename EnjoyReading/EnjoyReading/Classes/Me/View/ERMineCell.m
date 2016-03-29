//
//  ERMineCell.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/14.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERMineCell.h"
#import "ERMineItem.h"
#import "ERArrowItem.h"
#import "ERLabelItem.h"
#import "ERSwichItem.h"

@interface ERMineCell()
/**
 *  箭头
 */
@property (strong, nonatomic) UIImageView *rightArrow;
/**
 *  开关
 */
@property (strong, nonatomic) UISwitch *rightSwitch;
/**
 *  标签
 */
@property (strong, nonatomic) UILabel *rightLabel;

@end

@implementation ERMineCell

- (UIImageView *)rightArrow
{
    if (_rightArrow == nil) {
        self.rightArrow = [[UIImageView alloc] initWithImage:[UIImage  imageNamed:@"common_icon_arrow"]];
    }
    return _rightArrow;
}

- (UISwitch *)rightSwitch
{
    if (_rightSwitch == nil) {
        self.rightSwitch = [[UISwitch alloc] init];
    }
    return _rightSwitch;
}

- (UILabel *)rightLabel
{
    if (_rightLabel == nil) {
        self.rightLabel = [[UILabel alloc] init];
        self.rightLabel.textColor = [UIColor lightGrayColor];
        self.rightLabel.font = [UIFont systemFontOfSize:13];
    }
    return _rightLabel;
}

#pragma mark - 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"me";
    ERMineCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ERMineCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 设置标题的字体
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:11];
        
        // 去除cell的默认背景色
        self.backgroundColor = [UIColor clearColor];
        
        // 设置背景view
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
    }
    return self;
}

#pragma mark - 调整子控件的位置
- (void)layoutSubviews
{
    [super layoutSubviews];

    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 5;
}
#pragma mark - setter
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(NSUInteger)rows
{
    // 1.取出背景view
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selectedBgView = (UIImageView *)self.selectedBackgroundView;
    
    // 2.设置背景图片
    if (rows == 1) {
        bgView.image = [UIImage imageWithStretchableName:@"common_card_background"];
        selectedBgView.image = [UIImage imageWithStretchableName:@"common_card_background_highlighted"];
    } else if (indexPath.row == 0) { // 首行
        bgView.image = [UIImage imageWithStretchableName:@"common_card_top_background"];
        selectedBgView.image = [UIImage imageWithStretchableName:@"common_card_top_background_highlighted"];
    } else if (indexPath.row == rows - 1) { // 末行
        bgView.image = [UIImage imageWithStretchableName:@"common_card_bottom_background"];
        selectedBgView.image = [UIImage imageWithStretchableName:@"common_card_bottom_background_highlighted"];
    } else { // 中间
        bgView.image = [UIImage imageWithStretchableName:@"common_card_middle_background"];
        selectedBgView.image = [UIImage imageWithStretchableName:@"common_card_middle_background_highlighted"];
    }
}

- (void)setItem:(ERMineItem *)item
{
    _item = item;
    
    // 1.设置基本数据
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
    
    // 2.设置右边的内容
     if ([item isKindOfClass:[ERArrowItem class]]) {
        self.accessoryView = self.rightArrow;
    } else if ([item isKindOfClass:[ERSwichItem class]]) {
        self.accessoryView = self.rightSwitch;
    } else if ([item isKindOfClass:[ERLabelItem class]]) {
        ERLabelItem *labelItem = (ERLabelItem *)item;
        // 设置文字
        self.rightLabel.text = labelItem.text;
        // 根据文字计算尺寸
        self.rightLabel.size = [labelItem.text sizeWithAttributes:@{NSFontAttributeName:self.rightLabel.font}];
        /** 此方法过期，由上面的方法替代 */
        //        [labelItem.text sizeWithFont:self.rightLabel.font];
        self.accessoryView = self.rightLabel;
    } else { // 取消右边的内容
        self.accessoryView = nil;
    }
}

@end
