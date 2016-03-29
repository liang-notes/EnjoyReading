//
//  ERHealthCell.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/18.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHealthCell.h"
#import "ERHealth.h"
#import "ERHealthFrame.h"
#import "UIImageView+WebCache.h"



#define HealthTitleFont [UIFont boldSystemFontOfSize:16]
#define HealthDescipFont [UIFont systemFontOfSize:14]
#define HealthTimeFont [UIFont systemFontOfSize:14]
#define HealthCountFont [UIFont systemFontOfSize:12]
@interface ERHealthCell()
/**  标题 */
@property (nonatomic, weak) UILabel *titleLabel;

/**  描述 */
@property (nonatomic, weak) UILabel *descripLabel;

/**  图片 */
@property (nonatomic, weak) UIImageView *imgView;

/**  收藏数 */
@property (nonatomic, weak) UILabel *fcountLabel;

/**  访问数 */
@property (nonatomic, weak) UILabel *countLabel;

/**  分隔线 */
@property (nonatomic, weak) UIView *spView;
@end

@implementation ERHealthCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"health";
    ERHealthCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ERHealthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        //添加子控件
        /**  标题 */
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        titleLabel.font = HealthTitleFont;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        /**  描述 */
        UILabel *descripLabel = [[UILabel alloc] init];
        descripLabel.numberOfLines = 0;
        descripLabel.font = HealthDescipFont;
        [self.contentView addSubview:descripLabel];
        self.descripLabel = descripLabel;

        /**  图片 */
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        self.imgView = imgView;
        
        /**  收藏数 */
        UILabel *fcountLabel = [[UILabel alloc] init];
        fcountLabel.textColor = [UIColor grayColor];
        fcountLabel.textAlignment = NSTextAlignmentCenter;
        fcountLabel.font = HealthCountFont;
        [self.contentView addSubview:fcountLabel];
        self.fcountLabel = fcountLabel;
        
        /**  访问数 */
        UILabel *countLabel = [[UILabel alloc] init];
        countLabel.textColor = [UIColor grayColor];
        countLabel.textAlignment = NSTextAlignmentCenter;
        countLabel.font = HealthCountFont;
        [self.contentView addSubview:countLabel];
        self.countLabel = countLabel;
        
        /**  分隔线 */
        UIView *spView = [[UIView alloc] init];
        spView.backgroundColor = [UIColor lightGrayColor];
        spView.alpha = 0.5;
        [self.contentView addSubview:spView];
        self.spView = spView;
    }
    return self;
}

- (void)setHealthFrame:(ERHealthFrame *)healthFrame
{
    _healthFrame = healthFrame;
    

    _titleLabel.frame = healthFrame.titleLabelFrame;
    _titleLabel.text = healthFrame.health.title;
    
    _descripLabel.frame = healthFrame.descripLabelFrame;
    _descripLabel.text = healthFrame.health.descrip;
    
    
    _imgView.frame = healthFrame.imgViewFrame;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:healthFrame.health.img] placeholderImage:[UIImage imageNamed:@"loadPicture"]];
    
    
    _fcountLabel.frame = healthFrame.fcountLabelFrame;
    _fcountLabel.text = healthFrame.health.fcount;
    
    _countLabel.frame = healthFrame.countLabelFrame;
    _countLabel.text = healthFrame.health.count;
    
    _spView.frame = healthFrame.spViewFrame;
    
}

@end
