//
//  ERDreamCell.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/16.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERDreamCell.h"
#import "ERDream.h"
#define DreamTitle [UIFont boldSystemFontOfSize:18]
#define DreamContent [UIFont systemFontOfSize:15]
@interface ERDreamCell()
/**  标题 */
@property (nonatomic, weak) UILabel *titleLabel;
/**  内容 */
@property (nonatomic, weak) UILabel *contentLabel;
@end

@implementation ERDreamCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"dream";
    
    ERDreamCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ERDreamCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        // 初始化控件
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = DreamTitle;
        titleLabel.textColor = [UIColor yellowColor];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = DreamContent;
        contentLabel.textColor = [UIColor whiteColor];
        contentLabel.numberOfLines = 0;
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
    }

    return self;
}

- (void)setDream:(ERDream *)dream
{
    _dream = dream;

    
    self.titleLabel.text = dream.title;
    self.contentLabel.text = dream.content;
    [self setupFrame];
}

- (void)setupFrame
{
    CGFloat titleLabelX = 10;
    CGFloat titleLabelY = 10;
    CGSize titleLabelSize = [self.dream.title sizeWithAttributes:@{NSFontAttributeName:DreamTitle}];
    self.titleLabel.frame = (CGRect){{titleLabelX,titleLabelY},titleLabelSize};
    
    CGFloat contentLabelX = 10;
    CGFloat contentLabelY = CGRectGetMaxY(self.titleLabel.frame) + 10;
    CGFloat contentLabelW = ScreenW - 20;
    CGSize contentLabelSize = [self.dream.content boundingRectWithSize:CGSizeMake(contentLabelW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:DreamContent} context:nil].size;
    self.contentLabel.frame = (CGRect){{contentLabelX,contentLabelY},contentLabelSize};
    
    self.dream.cellHeight = CGRectGetMaxY(self.contentLabel.frame) + 10;
}

@end
