//
//  ERCurrenrNewsCell.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/13.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERCurrenrNewsCell.h"
#import "ERCurrentNewsFrame.h"
#import "ERCurrentNews.h"
#import "UIImageView+WebCache.h"

@interface ERCurrenrNewsCell()
/**  标题 */
@property (nonatomic, weak) UILabel *titleLabel;
/**  内容 */
@property (nonatomic, weak) UILabel *contentLabel;
/**  来源 */
@property (nonatomic, weak) UILabel *scrLabel;
/**  时间 */
@property (nonatomic, weak) UILabel *pdateLabel;
/**  图片 */
@property (nonatomic, weak) UIImageView *imgView;
/**  分隔线 */
@property (nonatomic, weak) UIView *spView;
@end

@implementation ERCurrenrNewsCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"current";
    ERCurrenrNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ERCurrenrNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.backgroundColor = [UIColor clearColor];
        // 初始化子控件
        [self setupAllChildView];
    }
    return self;
}

- (void)setupAllChildView
{
    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.backgroundColor = ERRandomColor;
    titleLabel.font = NewsTitleFont;
    titleLabel.numberOfLines = 0;
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *contentLabel = [[UILabel alloc] init];
//    contentLabel.backgroundColor = ERRandomColor;
    contentLabel.font = NewsContentFont;
    contentLabel.numberOfLines = 0;
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UILabel *scrLabel = [[UILabel alloc] init];
//    scrLabel.backgroundColor = ERRandomColor;
    scrLabel.font = NewsErdescriptionFont;
    scrLabel.textColor = ERColor(78, 123, 177);
    [self.contentView addSubview:scrLabel];
    self.scrLabel = scrLabel;
    
    UILabel *pdateLabel = [[UILabel alloc] init];
//    pdateLabel.backgroundColor = ERRandomColor;
    pdateLabel.font = NewsCtimeFont;
    pdateLabel.textColor = ERColor(78, 123, 177);
    [self.contentView addSubview:pdateLabel];
    self.pdateLabel = pdateLabel;
    
    UIImageView *imgView = [[UIImageView alloc] init];
//    imgView.backgroundColor = ERRandomColor;
    [self.contentView addSubview:imgView];
    self.imgView = imgView;
    
    UIView *spView = [[UIView alloc] init];
    spView.alpha = 0.4;
    spView.backgroundColor = ERColor(78, 123, 177);
    [self.contentView addSubview:spView];
    self.spView = spView;

}


- (void)setCurrentNewsF:(ERCurrentNewsFrame *)currentNewsF
{
    _currentNewsF = currentNewsF;
    
    // 设置数据
    self.titleLabel.frame = currentNewsF.titleFrame;
    self.titleLabel.text = currentNewsF.currentNews.title;
    
    self.contentLabel.frame = currentNewsF.contentFrame;
    self.contentLabel.text = currentNewsF.currentNews.content;
    
    self.scrLabel.frame = currentNewsF.srcFrame;
    self.scrLabel.text = currentNewsF.currentNews.src;
    
    self.pdateLabel.frame = currentNewsF.pdateFrame;
    self.pdateLabel.text = currentNewsF.currentNews.pdate;
    
    self.imgView.frame = currentNewsF.imgFrame;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:currentNewsF.currentNews.img]];
    
    self.spView.frame = currentNewsF.spFrame;
    
}

@end
