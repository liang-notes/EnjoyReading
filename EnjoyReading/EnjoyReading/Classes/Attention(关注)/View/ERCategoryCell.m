//
//  ERCategoryCell.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/21.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERCategoryCell.h"
#import "ERAttentionCategory.h"

#define AttentionNameFont [UIFont boldSystemFontOfSize:18]

@interface ERCategoryCell()
/**  标题 */
@property (nonatomic, weak) UILabel *nameLabel;

/**  选中时的指示器 */
@property (weak, nonatomic) UIView *selectedIndicator;

/**  分隔线 */
@property (weak, nonatomic) UIView *spView;

@end

@implementation ERCategoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = ERColor(244, 244, 244);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //标题
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = AttentionNameFont;
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        
        //指示器
        UIView *selectedIndicator = [[UIView alloc] init];
        selectedIndicator.backgroundColor = ERColor(219, 21, 26);
        [self.contentView addSubview:selectedIndicator];
        _selectedIndicator = selectedIndicator;
        
        //分隔线
        UIView *spView = [[UIView alloc] init];
        spView.backgroundColor = [UIColor whiteColor];
        spView.alpha = 0.5;
        [self.contentView addSubview:spView];
        _spView = spView;
        
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"category";
    ERCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ERCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setCategory:(ERAttentionCategory *)category
{
    _category = category;

    _nameLabel.frame = CGRectMake(0, 0, CategoryTableViewW, self.contentView.height);
    _nameLabel.text = category.name;
    
    _spView.frame = CGRectMake(0, _nameLabel.height, self.contentView.width, 1);
    
    _selectedIndicator.frame = CGRectMake(0, 0, 5, self.contentView.height);
    
    
    _category.cellHeight = self.contentView.height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    self.nameLabel.textColor = selected ?  self.selectedIndicator.backgroundColor :ERColor(78, 78, 78);
}

@end
