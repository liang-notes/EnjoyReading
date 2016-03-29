//
//  ERHistoryCell.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/9.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHistoryCell.h"
#import "ERHistory.h"

#define yearFont [UIFont boldSystemFontOfSize:16]
#define titleFont [UIFont systemFontOfSize:16]
#define cellMargin 10

@interface ERHistoryCell()
/**  时间 */
@property (nonatomic, weak) UILabel *yearLabel;
/**  事件 */
@property (nonatomic, weak) UILabel *titleLabel;

/**  分隔线 */
@property (nonatomic, weak) UIView *separator;
@property (nonatomic,strong)UIView *bgView;
@end
@implementation ERHistoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.bgView  = [[UIView alloc] initWithFrame:CGRectMake(10, 5, [UIScreen mainScreen].bounds.size.width - 20, 80)];
        self.bgView.backgroundColor = [UIColor whiteColor];
        //给bgView边框设置阴影
        self.bgView.layer.shadowOffset = CGSizeMake(2,2);
        self.bgView.layer.shadowOpacity = 0.5;
        self.bgView.layer.shadowColor = ERColor(78, 123, 177).CGColor;
        [self.contentView addSubview:self.bgView];
        // 初始化子控件
        UILabel * yearLabel = [[UILabel alloc] init];
        yearLabel.font = yearFont;
        yearLabel.textAlignment = NSTextAlignmentCenter;
        yearLabel.textColor = [UIColor brownColor];
        [self.bgView addSubview:yearLabel];
        self.yearLabel = yearLabel;
        
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.font = titleFont;
        titleLabel.numberOfLines = 0;
        [self.bgView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
//        UIView *separator = [[UIView alloc] init];
//        separator.alpha = 0.2;
//        separator.backgroundColor = [UIColor lightGrayColor];
//        [self.bgView addSubview:separator];
//        self.separator = separator;
        
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"history";
    ERHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ERHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setHistory:(ERHistory *)history
{
    _history = history;
//    self.titleLabel.text = @"一千年以后一千年以后一千年以后一千年以后一千年以后一千年以后一千年以后一千年以后一千年以后一千年以后一千年以后一千年以后";
    self.yearLabel.text = [NSString stringWithFormat:@"%@年" ,history.year];
    self.titleLabel.text = history.title;
    
    [self setupFrame];
}
- (void)setupFrame
{
    // 时间
    CGFloat yearLabelW = 60;
    CGFloat yearLabelH = 80;
    CGFloat yearLabelX = 0;
    CGFloat yearLabelY = 0;
    self.yearLabel.frame = CGRectMake(yearLabelX, yearLabelY, yearLabelW, yearLabelH);
    
//    CGFloat yearLabelX = cellMargin;
//    CGFloat yearLabelY = yearLabelX;
//    CGSize yearLabelSize = [_history.year sizeWithAttributes:@{NSFontAttributeName:yearFont}];
//    self.yearLabel.frame = (CGRect){{yearLabelX, yearLabelY}, yearLabelSize};

    // 内容
    CGFloat titleLabelX = CGRectGetMaxX(self.yearLabel.frame) + cellMargin;
    CGFloat titleLabelY = yearLabelY;
    CGFloat titleLabelW = [UIScreen mainScreen].bounds.size.width - yearLabelW -  3 * cellMargin;
    CGFloat titleLabelH = 80;
    self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
//   CGSize titleLabelSize = [_history.title boundingRectWithSize:CGSizeMake(titleLabelW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:titleFont} context:nil].size;
//    ;
//    self.titleLabel.frame = (CGRect){{titleLabelX, titleLabelY}, titleLabelSize};

    // 分隔线
//    self.separator.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), [UIScreen mainScreen].bounds.size.width, 1);
    
//    self.history.cellHeight = CGRectGetMaxY(self.separator.frame);
        self.history.cellHeight = 80;
}
@end
