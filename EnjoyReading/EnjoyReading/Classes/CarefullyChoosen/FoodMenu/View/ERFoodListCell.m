//
//  ERFoodListCell.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/17.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERFoodListCell.h"
#import "ERFoodListFrame.h"
#import "ERFoodList.h"
#import "UIImageView+WebCache.h"
#import "M13ProgressViewRing.h"


#define NameFont [UIFont systemFontOfSize:16]
#define FoodFont [UIFont systemFontOfSize:14]
#define DescFont [UIFont systemFontOfSize:14]
#define keywordsFont [UIFont systemFontOfSize:12]
@interface ERFoodListCell()

/**  菜名 */
@property (nonatomic, weak) UILabel *nameLabel;
/**  材料 */
@property (nonatomic, weak) UILabel *foodLabel;
/**  做法 */
@property (nonatomic, weak) UILabel *foodDescriptionLabel;
/**  图片 */
@property (nonatomic, weak) UIImageView *iconView;
/**  关键字 */
@property (nonatomic, weak) UILabel *keywordsLabel;
/**  分隔线 */
@property (nonatomic, weak) UIView *spView;
/**  进度 */
@property (nonatomic, weak) M13ProgressViewRing *progressView;

@end

@implementation ERFoodListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //初始化子控件
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    // 菜名
    UILabel *nameLabel = [[UILabel alloc] init];
//    nameLabel.textColor = [UIColor redColor];
    nameLabel.font = NameFont;
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    // 材料
    UILabel *foodLabel = [[UILabel alloc] init];
    foodLabel.textColor = [UIColor orangeColor];
    foodLabel.font = FoodFont;
    foodLabel.numberOfLines = 0;
    [self.contentView addSubview:foodLabel];
    self.foodLabel = foodLabel;
    
    // 做法
    UILabel *foodDescriptionLabel = [[UILabel alloc] init];
    foodDescriptionLabel.font = DescFont;
    foodDescriptionLabel.numberOfLines = 0;
    [self.contentView addSubview:foodDescriptionLabel];
    self.foodDescriptionLabel = foodDescriptionLabel;
    
    // 图片
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    
    // 添加进度条
    M13ProgressViewRing *progressV = [[M13ProgressViewRing alloc] init];
    [self.iconView addSubview:progressV];
    self.progressView = progressV;

    // 关键字
    UILabel *keywordsLabel = [[UILabel alloc] init];
    keywordsLabel.font = keywordsFont;
    keywordsLabel.textColor = ERColor(78, 123, 177);
    [self.contentView addSubview:keywordsLabel];
    self.keywordsLabel = keywordsLabel;
    
    // 分隔线
    UIView *spView = [[UIView alloc] init];
    spView.backgroundColor = [UIColor grayColor];
    spView.alpha = 0.3;
    [self.contentView addSubview:spView];
    self.spView = spView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"foodList";
    ERFoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ERFoodListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setFoodListFrame:(ERFoodListFrame *)foodListFrame
{
    _foodListFrame = foodListFrame;
    
    _nameLabel.frame = foodListFrame.nameLabelFrame;
    _nameLabel.text = foodListFrame.foodList.name;
    
    _foodLabel.frame = foodListFrame.foodLabelFrame;
    _foodLabel.text = foodListFrame.foodList.food;
    
    _foodDescriptionLabel.frame = foodListFrame.foodDescriptionLabelFrame;
    _foodDescriptionLabel.text = foodListFrame.foodList.foodDescription;
    
    _progressView.frame = foodListFrame.progressFrame;
    
    _iconView.frame = foodListFrame.iconViewFrame;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:foodListFrame.foodList.icon] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        foodListFrame.foodList.pictureProgress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:foodListFrame.foodList.pictureProgress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
//    [_iconView sd_setImageWithURL:[NSURL URLWithString:foodListFrame.foodList.icon]];
//    // 移除添加uiactiveityindicatorview
//    [[_iconView.subviews lastObject] removeFromSuperview];
//    // 或者移除所有subview
//    [[_iconView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _keywordsLabel.frame = foodListFrame.keywordsLabelFrame;
    _keywordsLabel.text = foodListFrame.foodList.keywords;
    
    _spView.frame = foodListFrame.spViewFrame;

}



@end
