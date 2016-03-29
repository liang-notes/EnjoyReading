//
//  ERHotNewsCell.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/22.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERCollectionCell.h"
#import "ERHotNews.h"
#import "UIImageView+WebCache.h"



#define HotNewsTitleFont [UIFont systemFontOfSize:15]
#define HotNewsTimeFont [UIFont systemFontOfSize:13]
#define HotNewsFromnameFont [UIFont systemFontOfSize:13]
#define HotNewsCountFont [UIFont systemFontOfSize:13]
#define Margin 8

@interface ERCollectionCell()
/**  图片 */
@property (nonatomic, weak) UIImageView *imgView;

/**  标题 */
@property (nonatomic, weak) UILabel *titleLabel;

/**  来源 */
@property (nonatomic, weak) UILabel *fromnameLabel;

/**  时间 */
@property (nonatomic, weak) UILabel *timeLabel;

/**  收藏数 */
@property (nonatomic, weak) UILabel *countLabel;

/**  分隔线 */
@property (weak, nonatomic) UIView *spView;

@end

@implementation ERCollectionCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    static NSString *ID = @"hotNews";
    ERCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ERCollectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = ERColor(244, 244, 244);
        
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        _imgView = imgView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        titleLabel.font = HotNewsTitleFont;
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        UILabel *fromnameLabel = [[UILabel alloc] init];
        fromnameLabel.font = HotNewsFromnameFont;
        [self.contentView addSubview:fromnameLabel];
        _fromnameLabel = fromnameLabel;
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = HotNewsTimeFont;
        [self.contentView addSubview:timeLabel];
        _timeLabel = timeLabel;
        
        UILabel *countLabel = [[UILabel alloc] init];
        countLabel.font = HotNewsTimeFont;
        [self.contentView addSubview:countLabel];
        _countLabel = countLabel;
        
        
        //分隔线
        UIView *spView = [[UIView alloc] init];
        spView.backgroundColor = [UIColor grayColor];
        spView.alpha = 0.3;
        [self.contentView addSubview:spView];
        _spView = spView;
        
    }
    return self;
}


- (void)setHotNews:(ERHotNews *)hotNews
{
    _hotNews = hotNews;
    
    _titleLabel.text = hotNews.title;
    _fromnameLabel.text = hotNews.fromname;
    
//    _timeLabel.text = hotNews.time;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:hotNews.img]];
    [self setupFrame];
}

- (void)setupFrame
{
    // 图片
    CGFloat imgViewX = Margin;
    CGFloat imgViewY = Margin;
    CGFloat imgViewW = 50;
    CGFloat imgViewH = 50;
    _imgView.frame = CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH);
    
    // 标题
    CGFloat titleLabelX = CGRectGetMaxX(_imgView.frame) + 0.5 * Margin;
    CGFloat titleLabelY = imgViewY;
    CGFloat titleLabelW = ScreenW - Margin - titleLabelX;
    CGSize titleLabelSize = [_hotNews.title boundingRectWithSize:CGSizeMake(titleLabelW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:HotNewsTitleFont} context:nil].size;
    _titleLabel.frame = (CGRect){{titleLabelX,titleLabelY},titleLabelSize};
    
    // 来源
    CGSize fromnameLabelSize = [_hotNews.fromname sizeWithAttributes:@{NSFontAttributeName:HotNewsFromnameFont}];
    CGFloat fromnameLabelX = titleLabelX;
    CGFloat fromnameLabelY = CGRectGetMaxY(_imgView.frame) - fromnameLabelSize.height;

    _fromnameLabel.frame = (CGRect){{fromnameLabelX,fromnameLabelY},fromnameLabelSize};
    
    // 时间
    CGFloat timeLabelX = CGRectGetMaxX(_fromnameLabel.frame) + 0.5 * Margin;
    CGFloat timeLabelY = fromnameLabelY;
    CGSize timeLabelSize = [_hotNews.time sizeWithAttributes:@{NSFontAttributeName:HotNewsTimeFont}];
    _timeLabel.frame = (CGRect){{timeLabelX,timeLabelY},timeLabelSize};

    CGFloat spViewW = ScreenW;
    CGFloat spViewH = 1;
    CGFloat spViewX = 0;
    CGFloat spViewY = CGRectGetMaxY(_imgView.frame) +  Margin;
    _spView.frame = CGRectMake(spViewX, spViewY, spViewW, spViewH);
    
    _hotNews.cellHeight = CGRectGetMaxY(_spView.frame);
}

@end
