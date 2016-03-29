//
//  ERFoodDetailCell.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/19.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERFoodDetailCell.h"
#import "ERFoodDetail.h"
#import "UIImageView+WebCache.h"

#define DetailNameFont [UIFont systemFontOfSize:17]
#define DetailFoodFont [UIFont systemFontOfSize:15]
#define DetailDescipFont [UIFont systemFontOfSize:15]
#define DetailMessageFont [UIFont systemFontOfSize:14]
#define DetailKeywordsFont [UIFont systemFontOfSize:14]
#define DetailCountFont [UIFont systemFontOfSize:12]
#define Margin 10
@interface ERFoodDetailCell()
/**  标题 */
@property (nonatomic, weak) UILabel *nameLabel;
/**  材料 */
@property (nonatomic, weak) UILabel *foodLabel;
/**  描述 */
@property (nonatomic, weak) UILabel *descriptionLabel;
/**  图片 */
@property (nonatomic, weak) UIImageView *imgV;
/**  内容 */
@property (nonatomic, weak) UILabel *messageLabel;
/**  关键字 */
@property (nonatomic, weak) UILabel *keywordsLabel;
/**  访问数 */
@property (nonatomic, weak) UILabel *fcountLabel;
/**  回复数 */
@property (nonatomic, weak) UILabel *rcountLabel;
/**  收藏数 */
@property (nonatomic, weak) UILabel *countLabel;

@end

@implementation ERFoodDetailCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"foodDetail";
    ERFoodDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ERFoodDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.numberOfLines = 0;
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = DetailNameFont;
        nameLabel.textColor = ERColor(78, 123, 177);
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *foodLabel = [[UILabel alloc] init];
        foodLabel.numberOfLines = 0;
        foodLabel.textAlignment = NSTextAlignmentCenter;
        foodLabel.font = DetailFoodFont;
        foodLabel.textColor = [UIColor orangeColor];
        [self.contentView addSubview:foodLabel];
        self.foodLabel = foodLabel;
        
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

        UILabel *keywordsLabel = [[UILabel alloc] init];
        keywordsLabel.font = DetailKeywordsFont;
        keywordsLabel.numberOfLines = 0;
        keywordsLabel.textColor = ERColor(78, 123, 177);
        [self.contentView addSubview:keywordsLabel];
        self.keywordsLabel = keywordsLabel;
        
        UILabel *fcountLabel = [[UILabel alloc] init];
        fcountLabel.font = DetailCountFont;
        fcountLabel.textAlignment = NSTextAlignmentCenter;
        fcountLabel.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:fcountLabel];
        self.fcountLabel = fcountLabel;
        
        UILabel *rcountLabel = [[UILabel alloc] init];
        rcountLabel.font = DetailCountFont;
        rcountLabel.textAlignment = NSTextAlignmentCenter;
        rcountLabel.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:rcountLabel];
        self.rcountLabel = rcountLabel;
        
        UILabel *countLabel = [[UILabel alloc] init];
        countLabel.font = DetailCountFont;
        countLabel.textAlignment = NSTextAlignmentCenter;
        countLabel.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:countLabel];
        self.countLabel = countLabel;
    }
    return self;
}

- (void)setFoodDetail:(ERFoodDetail *)foodDetail
{
    _foodDetail = foodDetail;
    
    _nameLabel.text = foodDetail.name;
    _foodLabel.text = foodDetail.food;
    _descriptionLabel.text = foodDetail.descrip;
    [_imgV sd_setImageWithURL:[NSURL URLWithString:foodDetail.img]];
    _messageLabel.text = foodDetail.message;
    _keywordsLabel.text = foodDetail.keywords;
    _fcountLabel.text = foodDetail.fcount;
    _rcountLabel.text = foodDetail.rcount;
    _countLabel.text = foodDetail.count;
    
    [self setupFrame];
}

- (void)setupFrame
{
    CGFloat nameX = Margin;
    CGFloat nameY = Margin;
    CGFloat nameW = ScreenW - 2 * Margin;
    CGSize nameSize = [_foodDetail.name boundingRectWithSize:CGSizeMake(nameW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DetailNameFont} context:nil].size;
    _nameLabel.frame = (CGRect){{nameX, nameY}, nameSize};
    
    CGFloat foodX = nameX;
    CGFloat foodY = CGRectGetMaxY(_nameLabel.frame) + 0.5 * Margin;;
    CGFloat foodW = ScreenW - 2 * Margin;
    CGSize foodSize = [_foodDetail.food boundingRectWithSize:CGSizeMake(foodW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DetailFoodFont} context:nil].size;
    _foodLabel.frame = (CGRect){{foodX, foodY}, foodSize};
    
    CGFloat descriptX = foodX;
    CGFloat descriptY = CGRectGetMaxY(_foodLabel.frame) + 0.5 * Margin;
    CGFloat descriptW = ScreenW - 2 * Margin;
    CGSize descriptSize = [_foodDetail.descrip boundingRectWithSize:CGSizeMake(descriptW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DetailDescipFont} context:nil].size;
    _descriptionLabel.frame = (CGRect){{descriptX, descriptY}, descriptSize};
    
    CGFloat imgX = descriptX;
    CGFloat imgY = CGRectGetMaxY(_descriptionLabel.frame) + 0.5 * Margin;
    CGFloat imgW = ScreenW - 2 * Margin;
    CGFloat imgH = 0.25 * ScreenH;
    _imgV.frame = CGRectMake(imgX, imgY, imgW, imgH);
    
    CGFloat messageX = imgX;
    CGFloat messageY = CGRectGetMaxY(_imgV.frame) + 0.5 * Margin;
    CGFloat messageW = ScreenW - 2 * Margin;
    CGSize messageSize = [_foodDetail.message boundingRectWithSize:CGSizeMake(messageW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DetailMessageFont} context:nil].size;
    _messageLabel.frame = (CGRect){{messageX, messageY}, messageSize};
    
    CGFloat keywordsX = messageX;
    CGFloat keywordsY = CGRectGetMaxY(_messageLabel.frame) + 0.5 * Margin;
    CGFloat keywordsW = ScreenW - 2 * Margin;
    CGSize keywordsSize = [_foodDetail.keywords boundingRectWithSize:CGSizeMake(keywordsW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DetailKeywordsFont} context:nil].size;
    _keywordsLabel.frame = (CGRect){{keywordsX, keywordsY}, keywordsSize};

    CGFloat fcountX = keywordsX;
    CGFloat fcountY = CGRectGetMaxY(_keywordsLabel.frame) + 0.5 * Margin;
    CGFloat fcountW = (ScreenW - 2 * Margin)/3;
    CGFloat fcountH = 30;
    _fcountLabel.frame = CGRectMake(fcountX, fcountY, fcountW, fcountH);
    
    CGFloat rcountX = CGRectGetMaxX(_fcountLabel.frame);
    CGFloat rcountY = fcountY;
    CGFloat rcountW = fcountW;
    CGFloat rcountH = fcountH;
    _rcountLabel.frame = CGRectMake(rcountX, rcountY, rcountW, rcountH);
    
    CGFloat countX = CGRectGetMaxX(_rcountLabel.frame);
    CGFloat countY = fcountY;
    CGFloat countW = fcountW;
    CGFloat countH = fcountH;
    _countLabel.frame = CGRectMake(countX, countY, countW, countH);
    
    _foodDetail.cellHeight = CGRectGetMaxY(_countLabel.frame);
}

@end
