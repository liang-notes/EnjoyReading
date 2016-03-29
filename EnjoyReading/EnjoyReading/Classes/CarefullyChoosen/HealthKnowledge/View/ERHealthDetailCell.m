//
//  ERHealthDetailView.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/18.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHealthDetailCell.h"
#import "ERHealthDetail.h"
#import "UIImageView+WebCache.h"

@interface ERHealthDetailCell()

/**  标题 */
@property (nonatomic, weak) UILabel *titleLabel;
/**  描述 */
@property (nonatomic, weak) UILabel *descriptionLabel;
/**  图片 */
@property (nonatomic, weak) UIImageView *imgV;
/**  内容 */
@property (nonatomic, weak) UILabel *messageLabel;
/**  时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/**  关键字 */
@property (nonatomic, weak) UILabel *keywordsLabel;
/**  访问数 */
@property (nonatomic, weak) UILabel *fcountLabel;
/**  收藏数 */
@property (nonatomic, weak) UILabel *countLabel;

@end

#define DetailTitleFont [UIFont systemFontOfSize:17]
#define DetailDescipFont [UIFont systemFontOfSize:15]
#define DetailMessageFont [UIFont systemFontOfSize:14]
#define DetailKeywordsFont [UIFont systemFontOfSize:14]
#define DetailTimeFont [UIFont systemFontOfSize:14]
#define DetailCountFont [UIFont systemFontOfSize:12]
#define Margin 10
@implementation ERHealthDetailCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"healthDtail";
    ERHealthDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ERHealthDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
//        titleLabel.backgroundColor = ERRandomColor;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *descriptionLabel = [[UILabel alloc] init];
        descriptionLabel.numberOfLines = 0;
        descriptionLabel.font = DetailDescipFont;
//        descriptionLabel.backgroundColor = ERRandomColor;
        [self.contentView addSubview:descriptionLabel];
        self.descriptionLabel = descriptionLabel;
        
        UIImageView *imgV = [[UIImageView alloc] init];
//        imgV.backgroundColor = ERRandomColor;
        [self.contentView addSubview:imgV];
        self.imgV = imgV;
        
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = 0;
        messageLabel.font = DetailMessageFont;
//        messageLabel.backgroundColor = ERRandomColor;
        [self.contentView addSubview:messageLabel];
        self.messageLabel = messageLabel;
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = DetailTimeFont;
//        timeLabel.backgroundColor = ERRandomColor;
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UILabel *keywordsLabel = [[UILabel alloc] init];
        keywordsLabel.font = DetailKeywordsFont;
        keywordsLabel.numberOfLines = 0;
        keywordsLabel.textColor = ERColor(78, 123, 177);
//        keywordsLabel.backgroundColor = ERRandomColor;
        [self.contentView addSubview:keywordsLabel];
        self.keywordsLabel = keywordsLabel;
        
        UILabel *fcountLabel = [[UILabel alloc] init];
        fcountLabel.font = DetailCountFont;
        fcountLabel.textAlignment = NSTextAlignmentCenter;
        fcountLabel.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:fcountLabel];
        self.fcountLabel = fcountLabel;
        
        UILabel *countLabel = [[UILabel alloc] init];
        countLabel.font = DetailCountFont;
        countLabel.textAlignment = NSTextAlignmentCenter;
        countLabel.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:countLabel];
        self.countLabel = countLabel;

    }
    return self;
}

- (void)setHealthDtail:(ERHealthDetail *)healthDtail
{
    _healthDtail = healthDtail;
    
    _titleLabel.text = healthDtail.title;
    _descriptionLabel.text = healthDtail.descrip;
    [_imgV sd_setImageWithURL:[NSURL URLWithString:healthDtail.img]];
    _messageLabel.text = healthDtail.message;
    _timeLabel.text = healthDtail.time;
    _keywordsLabel.text = healthDtail.keywords;
    _fcountLabel.text = healthDtail.fcount;
    _countLabel.text = healthDtail.count;

    [self setupFrame];
}

- (void)setupFrame
{
    CGFloat titleX = Margin;
    CGFloat titleY = Margin;
    CGFloat titleW = ScreenW - 2 * Margin;
    CGSize titleSize = [_healthDtail.title boundingRectWithSize:CGSizeMake(titleW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DetailTitleFont} context:nil].size;
    _titleLabel.frame = (CGRect){{titleX, titleY}, titleSize};
    
    CGFloat descriptX = titleX;
    CGFloat descriptY = CGRectGetMaxY(_titleLabel.frame) + 0.5 * Margin;
    CGFloat descriptW = ScreenW - 2 * Margin;
    CGSize descriptSize = [_healthDtail.descrip boundingRectWithSize:CGSizeMake(descriptW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DetailDescipFont} context:nil].size;
    _descriptionLabel.frame = (CGRect){{descriptX, descriptY}, descriptSize};
    
    CGFloat imgX = descriptX;
    CGFloat imgY = CGRectGetMaxY(_descriptionLabel.frame) + 0.5 * Margin;
    CGFloat imgW = ScreenW - 2 * Margin;
    CGFloat imgH = 0.25 * ScreenH;
    _imgV.frame = CGRectMake(imgX, imgY, imgW, imgH);
    
    CGFloat messageX = imgX;
    CGFloat messageY = CGRectGetMaxY(_imgV.frame) + 0.5 * Margin;
    CGFloat messageW = ScreenW - 2 * Margin;
    CGSize messageSize = [_healthDtail.message boundingRectWithSize:CGSizeMake(messageW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DetailMessageFont} context:nil].size;
    _messageLabel.frame = (CGRect){{messageX, messageY}, messageSize};
    
    CGFloat keywordsX = messageX;
    CGFloat keywordsY = CGRectGetMaxY(_messageLabel.frame) + 0.5 * Margin;
    CGFloat keywordsW = ScreenW - 2 * Margin;
    CGSize keywordsSize = [_healthDtail.keywords boundingRectWithSize:CGSizeMake(keywordsW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DetailKeywordsFont} context:nil].size;
    _keywordsLabel.frame = (CGRect){{keywordsX, keywordsY}, keywordsSize};
    
    CGFloat timeX = keywordsX;
    CGFloat timeY = CGRectGetMaxY(_keywordsLabel.frame) + 0.5 * Margin;
    CGSize timeSize = [_healthDtail.time sizeWithAttributes:@{NSFontAttributeName:DetailTimeFont}];
    _timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    
    CGFloat fcountX = timeX;
    CGFloat fcountY = CGRectGetMaxY(_timeLabel.frame) + 0.5 * Margin;
    CGFloat fcountW = 0.5 * ScreenW - Margin;
    CGFloat fcountH = 30;
    _fcountLabel.frame = CGRectMake(fcountX, fcountY, fcountW, fcountH);
    
    CGFloat countX = CGRectGetMaxX(_fcountLabel.frame);
    CGFloat countY = fcountY;
    CGFloat countW = 0.5 * ScreenW - Margin;
    CGFloat countH = fcountH;
    _countLabel.frame = CGRectMake(countX, countY, countW, countH);
    
    _healthDtail.cellHeight = CGRectGetMaxY(_countLabel.frame);
}
@end
