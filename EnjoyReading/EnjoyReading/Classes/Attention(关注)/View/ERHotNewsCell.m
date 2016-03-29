//
//  ERHotNewsCell.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/22.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHotNewsCell.h"
#import "ERHotNews.h"
#import "UIImageView+WebCache.h"
#import "LHDB.h"

#define HotNewsTitleFont [UIFont systemFontOfSize:15]
#define HotNewsTimeFont [UIFont systemFontOfSize:13]
#define HotNewsFromnameFont [UIFont systemFontOfSize:13]
#define HotNewsCountFont [UIFont systemFontOfSize:13]
#define Margin 8

@interface ERHotNewsCell()
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

/**  按钮 */
@property (nonatomic, weak) UIButton *collectButton;

/**  分隔线 */
@property (weak, nonatomic) UIView *spView;

@end

@implementation ERHotNewsCell
{
    LHDBQueue* queue;
}

- (NSMutableArray *)collects{
    if (_collects == nil) {
        _collects = [NSMutableArray array];
    }
    return _collects;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{

    static NSString *ID = @"hotNews";
    ERHotNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ERHotNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
 
        UIButton *collectButton = [[UIButton alloc] init];
        [self.contentView addSubview:collectButton];
        [collectButton setTitle:@"+收藏" forState:UIControlStateNormal];
        collectButton.titleLabel.font = HotNewsFromnameFont;

        [collectButton setBackgroundImage:[UIImage imageNamed:@"FollowBtnBg"] forState:UIControlStateNormal];
        [collectButton setBackgroundImage:[UIImage imageNamed:@"FollowBtnClickBg"] forState:UIControlStateHighlighted];
        [collectButton setTitleColor:ERColor(78, 123, 177) forState:UIControlStateNormal];
        [collectButton addTarget:self action:@selector(collectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.collectButton = collectButton;
        
        //分隔线
        UIView *spView = [[UIView alloc] init];
        spView.backgroundColor = [UIColor grayColor];
        spView.alpha = 0.3;
        [self.contentView addSubview:spView];
        _spView = spView;
        
    }
    return self;
}

- (void)collectButtonClick:(UIButton *)button
{
    [self.collectButton setTitle:@"已收藏" forState:UIControlStateNormal];
    [self.collectButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.collectButton.enabled = NO;
    [ERHotNews createTable];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"内容已添加到我的收藏" message:nil delegate:self cancelButtonTitle:@"谢谢" otherButtonTitles:nil, nil];
    [alert show];
    
    ERHotNews *hot = [[ERHotNews alloc] init];
    hot.title = _hotNews.title;
    hot.fromname = _hotNews.fromname;
    hot.time = _hotNews.time;
    hot.img = _hotNews.img;
    hot.fromurl = _hotNews.fromurl;
    [hot save];
    
    
//    NSMutableArray *collect = [NSMutableArray array];
//    [collect addObject:_hotNews];
//    [self.collects addObjectsFromArray:collect];

//    [ERNewsTool saveHotNews:_hotNews];

    [alert removeFromSuperview];
    ERLog(@"点击了按钮");
}

- (void)setHotNews:(ERHotNews *)hotNews
{
    _hotNews = hotNews;
    
    _titleLabel.text = hotNews.title;
    _fromnameLabel.text = hotNews.fromname;
    _timeLabel.text = hotNews.time;
//    _countLabel.text = hotNews.count;
    _countLabel.text = [NSString stringWithFormat:@"%@万人关注",hotNews.count];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:hotNews.img]];
    [self setupFrame];
}

- (void)setupFrame
{
    // 图片
    CGFloat imgViewX = Margin;
    CGFloat imgViewY = Margin;
    CGFloat imgViewW = 50;
    CGFloat imgViewH = 55;
    _imgView.frame = CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH);
    
    // 标题
    CGFloat titleLabelX = CGRectGetMaxX(_imgView.frame) + 0.5 * Margin;
    CGFloat titleLabelY = imgViewY;
    CGFloat titleLabelW = HotNewsTableViewW - Margin - titleLabelX;
    CGSize titleLabelSize = [_hotNews.title boundingRectWithSize:CGSizeMake(titleLabelW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:HotNewsTitleFont} context:nil].size;
    _titleLabel.frame = (CGRect){{titleLabelX,titleLabelY},titleLabelSize};
    
    // 来源
    CGFloat fromnameLabelX = titleLabelX;
    CGFloat fromnameLabelY = CGRectGetMaxY(_titleLabel.frame) + 0.5 * Margin;
    CGSize fromnameLabelSize = [_hotNews.fromname sizeWithAttributes:@{NSFontAttributeName:HotNewsFromnameFont}];
    _fromnameLabel.frame = (CGRect){{fromnameLabelX,fromnameLabelY},fromnameLabelSize};
    
    // 时间
    CGFloat timeLabelX = CGRectGetMaxX(_fromnameLabel.frame) + 0.5 * Margin;
    CGFloat timeLabelY = fromnameLabelY;
    CGSize timeLabelSize = [_hotNews.time sizeWithAttributes:@{NSFontAttributeName:HotNewsTimeFont}];
    _timeLabel.frame = (CGRect){{timeLabelX,timeLabelY},timeLabelSize};
    
    // 收藏数
    CGFloat countLabelX = Margin;
    CGFloat countLabelY = CGRectGetMaxY(_imgView.frame) + 0.5 * Margin;
    CGFloat countLabelW = 100;
    CGFloat countLabelH = 25;
    _countLabel.frame = CGRectMake(countLabelX, countLabelY, countLabelW, countLabelH);
    
    CGFloat collectButtonW = 40;
    CGFloat collectButtonH = 25;
    CGFloat collectButtonX = HotNewsTableViewW - Margin - collectButtonW;
    CGFloat collectButtonY = countLabelY;
    _collectButton.frame = CGRectMake(collectButtonX, collectButtonY, collectButtonW, collectButtonH);
    
    CGFloat spViewW = HotNewsTableViewW;
    CGFloat spViewH = 1;
    CGFloat spViewX = 0;
    CGFloat spViewY = CGRectGetMaxY(_countLabel.frame) + 0.5 * Margin;
    _spView.frame = CGRectMake(spViewX, spViewY, spViewW, spViewH);

    _hotNews.cellHeight = CGRectGetMaxY(_countLabel.frame);
}

@end
