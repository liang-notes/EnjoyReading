//
//  ERBookListCell.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/23.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERBookListCell.h"
#import "ERBookList.h"
#import "UIImageView+WebCache.h"
#define BookListNameFont [UIFont systemFontOfSize:14]
#define BookListSummaryFont [UIFont systemFontOfSize:12]
#define BookListAuthorFont [UIFont systemFontOfSize:12]
#define BookListCountFont [UIFont systemFontOfSize:12]

#define Margin 10
@interface ERBookListCell()

/**  封面 */
@property (nonatomic, weak) UIImageView *imgV;

/**  书名 */
@property (nonatomic, weak) UILabel *nameLabel;

/**  简介 */
@property (nonatomic, weak) UILabel *summaryLabel;

/**  作者 */
@property (nonatomic, weak) UILabel *authorLabel;

/**  收藏数 */
@property (nonatomic, weak) UILabel *countLabel;

@end
@implementation ERBookListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"bookList";
    ERBookListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ERBookListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *imgV = [[UIImageView alloc] init];
        [self.contentView addSubview:imgV];
        self.imgV = imgV;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.numberOfLines = 0;
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = BookListNameFont;
        nameLabel.textColor = ERColor(78, 123, 177);
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *summaryLabel = [[UILabel alloc] init];
        summaryLabel.numberOfLines = 0;
        summaryLabel.font = BookListSummaryFont;
        [self.contentView addSubview:summaryLabel];
        self.summaryLabel = summaryLabel;
        
        UILabel *authorLabel = [[UILabel alloc] init];
        authorLabel.font = BookListAuthorFont;
        [self.contentView addSubview:authorLabel];
        self.authorLabel = authorLabel;
        
        UILabel *countLabel = [[UILabel alloc] init];
        countLabel.font = BookListCountFont;
        [self.contentView addSubview:countLabel];
        self.countLabel = countLabel;
        
    }
    return self;
}

- (void)setBookList:(ERBookList *)bookList
{
    _bookList = bookList;
    
     [_imgV sd_setImageWithURL:[NSURL URLWithString:bookList.img]];
    _nameLabel.text = bookList.name;
    _authorLabel.text = bookList.author;
    _summaryLabel.text = bookList.summary;
    _countLabel.text = bookList.count;
    
    [self setupFrame];

}

- (void)setupFrame
{
    
    // 封面
    CGFloat imgX = Margin;
    CGFloat imgY = Margin;
    CGFloat imgW = 120;
    CGFloat imgH = 180;
    _imgV.frame = CGRectMake(imgX,imgY,imgW,imgH);
    
    // 标题
    CGFloat nameLabelX = CGRectGetMaxX(_imgV.frame) + 0.5 * Margin;
    CGFloat nameLabelY = imgY;
    CGFloat nameLabelW = ScreenW - nameLabelX - Margin;
    CGSize nameLabelSize = [_bookList.name boundingRectWithSize:CGSizeMake(nameLabelW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:BookListNameFont} context:nil].size;
    _nameLabel.frame = (CGRect){{nameLabelX,nameLabelY},nameLabelSize};
    
    // 作者
    CGFloat authorLabelX = nameLabelX;
    CGFloat authorLabelY = CGRectGetMaxY(_nameLabel.frame) + 0.5 * Margin;
    CGSize authorLabelSize = [_bookList.author sizeWithAttributes:@{NSFontAttributeName:BookListAuthorFont}];
    _authorLabel.frame = (CGRect){{authorLabelX,authorLabelY},authorLabelSize};
    
    // 简介
    CGFloat summaryLabelX = authorLabelX;
    CGFloat summaryLabelY = CGRectGetMaxY(_authorLabel.frame) + 0.5 * Margin;
    CGFloat summaryLabelW = ScreenW - summaryLabelX - Margin;
    CGFloat summaryLabelH = 125;
    _summaryLabel.frame = CGRectMake(summaryLabelX,summaryLabelY,summaryLabelW,summaryLabelH);

    // 阅读数
    CGSize countLabelSize = [_bookList.count sizeWithAttributes:@{NSFontAttributeName:BookListAuthorFont}];
    CGFloat countLabelX = summaryLabelX;
    CGFloat countLabelY = CGRectGetMaxY(_imgV.frame) - countLabelSize.height;
    _countLabel.frame = (CGRect){{countLabelX,countLabelY},countLabelSize};
    
    _bookList.cellHeight = 200;
}



@end
