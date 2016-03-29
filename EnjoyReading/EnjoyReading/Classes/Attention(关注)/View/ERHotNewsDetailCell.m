//
//  ERHotNewsDetailCell.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/22.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHotNewsDetailCell.h"
#import "ERHotNewsDetail.h"
#import "UIImageView+WebCache.h"


#define DetailTitleFont [UIFont systemFontOfSize:17]
#define DetailDescipFont [UIFont systemFontOfSize:15]
#define DetailMessageFont [UIFont systemFontOfSize:14]
#define DetailKeywordsFont [UIFont systemFontOfSize:14]
#define DetailTimeFont [UIFont systemFontOfSize:12]
#define DetailFromnameFont [UIFont systemFontOfSize:12]
#define DetailFromurlFont [UIFont systemFontOfSize:12]
#define Margin 10
@interface ERHotNewsDetailCell()
/**  标题 */
@property (nonatomic, weak) UILabel *titleLabel;
/**  简介 */
@property (nonatomic, weak) UILabel *descriptionLabel;
/**  图片 */
@property (nonatomic, weak) UIImageView *imgV;

/**  详情 */
@property (nonatomic, weak) UILabel *messageLabel;

/**  来源 */
@property (nonatomic, weak) UILabel *fromnameLabel;

/**  时间 */
@property (nonatomic, weak) UILabel *timeLabel;


/**  关键字 */
@property (nonatomic, weak) UILabel *keywordsLabel;

/**  链接 */
@property (nonatomic, weak) UILabel *fromurlLabel;

/**  分隔线 */
@property (nonatomic, weak) UIView *spView;

@end

@implementation ERHotNewsDetailCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    static NSString *ID = @"hotNewsDetail";
    ERHotNewsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ERHotNewsDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
        titleLabel.font = DetailTitleFont;
        titleLabel.textColor = ERColor(78, 123, 177);
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *descriptionLabel = [[UILabel alloc] init];
        descriptionLabel.numberOfLines = 0;
        descriptionLabel.font = DetailDescipFont;
        [self.contentView addSubview:descriptionLabel];
        self.descriptionLabel = descriptionLabel;
        
        UIImageView *imgV = [[UIImageView alloc] init];
        [self.contentView addSubview:imgV];
        self.imgV = imgV;
        
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = 0;
        messageLabel.font = DetailMessageFont;
        [self.contentView addSubview:messageLabel];
        self.messageLabel = messageLabel;
        
        UILabel *fromnameLabel = [[UILabel alloc] init];
        fromnameLabel.font = DetailFromnameFont;
        [self.contentView addSubview:fromnameLabel];
        self.fromnameLabel = fromnameLabel;
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = DetailTimeFont;
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UILabel *keywordsLabel = [[UILabel alloc] init];
        keywordsLabel.font = DetailKeywordsFont;
        keywordsLabel.numberOfLines = 0;
        keywordsLabel.textColor = ERColor(78, 123, 177);
        [self.contentView addSubview:keywordsLabel];
        self.keywordsLabel = keywordsLabel;
        
        UILabel *fromurlLabel = [[UILabel alloc] init];
        fromurlLabel.font = DetailFromurlFont;
        fromurlLabel.textAlignment = NSTextAlignmentCenter;
        fromurlLabel.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:fromurlLabel];
        self.fromurlLabel = fromurlLabel;
        
        //分隔线
        UIView *spView = [[UIView alloc] init];
        spView.backgroundColor = [UIColor grayColor];
        spView.alpha = 0.3;
        [self.contentView addSubview:spView];
        _spView = spView;
        
    }
    return self;
}

- (void)setHotNewsDetail:(ERHotNewsDetail *)hotNewsDetail
{
    _hotNewsDetail = hotNewsDetail;
    
    _titleLabel.text = hotNewsDetail.title;
    _descriptionLabel.text = hotNewsDetail.descript;
    [_imgV sd_setImageWithURL:[NSURL URLWithString:hotNewsDetail.img]];
    _messageLabel.text = hotNewsDetail.message;
    _fromnameLabel.text = hotNewsDetail.fromname;
    _timeLabel.text = hotNewsDetail.time;
    _keywordsLabel.text = hotNewsDetail.keywords;
    _fromurlLabel.text = hotNewsDetail.fromurl;
    [self setupFrame];
}

- (void)setupFrame
{
    // 标题
    CGFloat titleLabelX = Margin;
    CGFloat titleLabelY = Margin;
    CGFloat titleLabelW = ScreenW - 2 * Margin;
    CGSize titleLabelSize = [_hotNewsDetail.title boundingRectWithSize:CGSizeMake(titleLabelW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DetailTitleFont} context:nil].size;
    _titleLabel.frame = (CGRect){{titleLabelX,titleLabelY},titleLabelSize};
    
    // 描述
    CGFloat descripLabelX = titleLabelX;
    CGFloat descripLabelY = CGRectGetMaxY(_titleLabel.frame) + 0.5 * Margin;
    CGFloat descripLabelW = ScreenW - 2 * Margin;
    CGSize descripLabelSize = [_hotNewsDetail.descript boundingRectWithSize:CGSizeMake(descripLabelW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DetailDescipFont} context:nil].size;
    _descriptionLabel.frame = (CGRect){{descripLabelX,descripLabelY},descripLabelSize};
    
    // 图片
    CGFloat imgViewX = descripLabelX;
    CGFloat imgViewY = CGRectGetMaxY( _descriptionLabel.frame) + 0.5 * Margin;
    CGFloat imgViewW =  ScreenW - 2 * Margin;
    CGFloat imgViewH = 0.25 * ScreenH;
    _imgV.frame = CGRectMake(imgViewX, imgViewY, imgViewW, imgViewH);
    
    // 详情
    CGFloat messageLabelX = imgViewX;
    CGFloat messageLabelY = CGRectGetMaxY(_imgV.frame) + 0.5 * Margin;
    CGFloat messageLabelW = ScreenW - 2 * Margin;
    CGSize messageLabelSize = [_hotNewsDetail.message boundingRectWithSize:CGSizeMake(messageLabelW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DetailMessageFont} context:nil].size;
    _messageLabel.frame = (CGRect){{messageLabelX,messageLabelY},messageLabelSize};
    
    CGFloat fromnameX = messageLabelX;
    CGFloat fromnameY = CGRectGetMaxY(_messageLabel.frame) + 0.5 * Margin;
    CGSize fromnameSize = [_hotNewsDetail.fromname sizeWithAttributes:@{NSFontAttributeName:DetailFromnameFont}];
    _fromnameLabel.frame = (CGRect){{fromnameX, fromnameY}, fromnameSize};
    
    CGFloat timeX = CGRectGetMaxX(_fromnameLabel.frame) + 0.5 * Margin;
;
    CGFloat timeY = fromnameY;
    CGSize timeSize = [_hotNewsDetail.time sizeWithAttributes:@{NSFontAttributeName:DetailTimeFont}];
    _timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};

    
    CGFloat keywordsX = fromnameX;
    CGFloat keywordsY = CGRectGetMaxY(_timeLabel.frame) + 0.5 * Margin;
    CGFloat keywordsW = ScreenW - 2 * Margin;
    CGSize keywordsSize = [_hotNewsDetail.keywords boundingRectWithSize:CGSizeMake(keywordsW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DetailKeywordsFont} context:nil].size;
    _keywordsLabel.frame = (CGRect){{keywordsX, keywordsY}, keywordsSize};
    
    
    CGFloat fromurlX = keywordsX;
    CGFloat fromurlY = CGRectGetMaxY(_keywordsLabel.frame) + 0.5 * Margin;
    CGFloat fcountW = ScreenW - 2 * Margin;
    CGFloat fcountH = 30;
    _fromurlLabel.frame = CGRectMake(fromurlX, fromurlY, fcountW, fcountH);
  
    // 分隔线
    CGFloat spViewX = 0;
    CGFloat spViewY = CGRectGetMaxY(_fromurlLabel.frame) + 0.5 * Margin;
    CGFloat spViewW = ScreenW;
    CGFloat spViewH = 1;
    _spView.frame = CGRectMake(spViewX, spViewY, spViewW, spViewH);
    
    _hotNewsDetail.cellHeight = CGRectGetMaxY(_spView.frame);

}
@end
