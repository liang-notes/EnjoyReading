//
//  ERJokeCell.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/8.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERJokeCell.h"
#import "ERJoke.h"
#define cellMargin 10
#define timeFont [UIFont systemFontOfSize:14]
#define contentFont [UIFont systemFontOfSize:16]

@interface ERJokeCell()
/**  时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/**  内容 */
@property (nonatomic, weak) UILabel *contentLabel;

/**  分隔线 */
@property (nonatomic, weak) UIView *separator;

@end

@implementation ERJokeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        // 初始化子控件
        UILabel * timeLabel = [[UILabel alloc] init];
        timeLabel.font = timeFont;
        timeLabel.textColor = ERColor(78, 123, 177);
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UILabel * contentLabel = [[UILabel alloc] init];
        contentLabel.font = contentFont;
        contentLabel.numberOfLines = 0;
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        UIView *separator = [[UIView alloc] init];
        separator.backgroundColor = [UIColor lightGrayColor];
        separator.alpha = 0.5;
        [self.contentView addSubview:separator];
        self.separator = separator;
        
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"joke";
    ERJokeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setJoke:(ERJoke *)joke
{
    _joke = joke;
    
    // 数据赋值
    self.timeLabel.text = joke.updatetime;
    self.contentLabel.text = joke.content;
    // 尺寸计算以及赋值
    [self setupFrames];
}

/**
 *  尺寸计算以及赋值
 */
- (void)setupFrames
{
    // 时间
    CGFloat timeLabelX = cellMargin;
    CGFloat timeLabelY = timeLabelX;
    CGSize timeLabelSize = [_joke.updatetime sizeWithAttributes:@{NSFontAttributeName:timeFont}];
    self.timeLabel.frame = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    // 内容
    CGFloat contentLabelX = timeLabelX;
    CGFloat contentLabelY = CGRectGetMaxY(self.timeLabel.frame) + cellMargin * 0.5;
    CGFloat contentLabelW = [UIScreen mainScreen].bounds.size.width - 2 * cellMargin;
    CGSize contentLabelSize = [_joke.content boundingRectWithSize:CGSizeMake(contentLabelW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:contentFont} context:nil].size;
    ;
    self.contentLabel.frame = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    
    // 分隔线
    self.separator.frame = CGRectMake(0, CGRectGetMaxY(self.contentLabel.frame) + cellMargin * 0.5, [UIScreen mainScreen].bounds.size.width, 1);
    
    self.joke.cellHeight = CGRectGetMaxY(self.separator.frame);

}

@end
