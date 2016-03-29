//
//  ERPageBookCell.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/23.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERPageBookCell.h"
#import "ERPageBook.h"

#define PageBookTitleFont [UIFont systemFontOfSize:17]
#define PageBookMessageFont [UIFont systemFontOfSize:15]

#define Margin 10
@interface ERPageBookCell()
/**  标题 */
@property (nonatomic, weak) UILabel *titleLabel;

/**  详情 */
@property (nonatomic, weak) UILabel *messageLabel;

@end
@implementation ERPageBookCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"pageBook";
    ERPageBookCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ERPageBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = PageBookTitleFont;
        titleLabel.textColor = ERColor(78, 123, 177);
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = 0;
        messageLabel.font = PageBookMessageFont;
        [self.contentView addSubview:messageLabel];
        self.messageLabel = messageLabel;
        
    }
    return self;
}

- (void)setPageBook:(ERPageBook *)pageBook
{
    _pageBook = pageBook;
    
    _titleLabel.text = pageBook.title;
    _messageLabel.text = pageBook.message;
    
    [self setupFrame];
}

- (void)setupFrame
{
    // 标题
    CGFloat titleLabelX = Margin;
    CGFloat titleLabelY = Margin;
    CGFloat titleLabelW = ScreenW - 2 * Margin;
    CGSize titleLabelSize = [_pageBook.title boundingRectWithSize:CGSizeMake(titleLabelW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:PageBookTitleFont} context:nil].size;
    _titleLabel.frame = (CGRect){{titleLabelX,titleLabelY},titleLabelSize};
    
    // 详情
    CGFloat messageLabelX = titleLabelX;
    CGFloat messageLabelY = CGRectGetMaxY(_titleLabel.frame) + 0.5 * Margin;
    CGFloat messageLabelW = ScreenW - 2 * Margin;
    CGSize messageLabelSize = [_pageBook.message boundingRectWithSize:CGSizeMake(messageLabelW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:PageBookMessageFont} context:nil].size;
    _messageLabel.frame = (CGRect){{messageLabelX,messageLabelY},messageLabelSize};
    
    _pageBook.cellHeight = CGRectGetMaxY(_messageLabel.frame);
}

@end
