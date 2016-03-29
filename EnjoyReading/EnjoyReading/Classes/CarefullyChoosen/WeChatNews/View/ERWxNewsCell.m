//
//  ERWxNewsCell.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/7.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERWxNewsCell.h"
#import "ERWxNews.h"
#import "UIImageView+WebCache.h"

#define Margin 10
#define wxTitleFont [UIFont boldSystemFontOfSize:18]
#define wxSoureFont [UIFont systemFontOfSize:12]
#define wxTimeFont [UIFont systemFontOfSize:12]
@interface ERWxNewsCell()
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UIImageView *pictureView;
@property (weak, nonatomic) UILabel *timeLabel;
@property (weak, nonatomic) UILabel *soureLabel;
@property (weak, nonatomic) UIView *dividerView;
@end

@implementation ERWxNewsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        titleLabel.font = wxTitleFont;
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        UIImageView *pictureView = [[UIImageView alloc] init];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;

        UILabel *soureLabel = [[UILabel alloc] init];
        soureLabel.font = wxSoureFont;
        soureLabel.textColor = ERColor(78, 123, 177);
        [self.contentView addSubview:soureLabel];
        _soureLabel = soureLabel;
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = wxTimeFont;
        [self.contentView addSubview:timeLabel];
        _timeLabel = timeLabel;
        
        UIView *dividerView = [[UILabel alloc] init];
        dividerView.backgroundColor = [UIColor grayColor];
        dividerView.alpha = 0.5;
        [self.contentView addSubview:dividerView];
        _dividerView = dividerView;

    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"wxnews";
    ERWxNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell = [[ERWxNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID]  ;
    }
    return cell;
}
- (void)setWxNews:(ERWxNews *)wxNews
{
    _wxNews = wxNews;
    
    [self setupFrame];
    
    self.titleLabel.text = wxNews.title;
    self.timeLabel.text = wxNews.hottime;
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:wxNews.picUrl]];
    self.soureLabel.text = wxNews.er_description;

}

- (void)setupFrame
{
    CGFloat titleX = Margin;
    CGFloat titleY = Margin;
    CGFloat titleW = ScreenW - 2 * Margin;
    CGSize titleSize = [_wxNews.title boundingRectWithSize:CGSizeMake(titleW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:wxTitleFont} context:nil].size;
    _titleLabel.frame = (CGRect){{titleX,titleY},titleSize};
    
    CGFloat picX = titleX;
    CGFloat picY = CGRectGetMaxY(_titleLabel.frame) + 0.5 * Margin;
    CGFloat picW = 0.8 * ScreenW;
    CGFloat picH = 0.25 * ScreenH;
    _pictureView.frame = CGRectMake(picX, picY, picW, picH);
    
    CGFloat sourceX = picX;
    CGFloat sourceY = CGRectGetMaxY(_pictureView.frame) + 0.5 * Margin;
    CGSize sourceSize = [_wxNews.er_description sizeWithAttributes:@{NSFontAttributeName:wxSoureFont}];
    _soureLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};
    
    CGFloat timeX = CGRectGetMaxX(_soureLabel.frame) + 0.5 * Margin;
    CGFloat timeY = sourceY;
    CGSize timeSize = [_wxNews.hottime sizeWithAttributes:@{NSFontAttributeName:wxTimeFont}];
    _timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
    
    CGFloat divX = 0;
    CGFloat divY = CGRectGetMaxY(_soureLabel.frame) + 0.5 * Margin;
    CGFloat divW = ScreenW;
    CGFloat divH = 1;
    _dividerView.frame = CGRectMake(divX, divY, divW, divH);
    
    _wxNews.cellHeight = CGRectGetMaxY(self.dividerView.frame);
}

@end
