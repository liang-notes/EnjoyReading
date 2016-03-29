//
//  ERHealthTypeCell.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/18.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHealthTypeCell.h"
#import "ERWaterflowView.h"
#import "ERHealthType.h"

@interface ERHealthTypeCell()
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UILabel *nameLabel;
@end
@implementation ERHealthTypeCell

+ (instancetype)cellWithWaterflowView:(ERWaterflowView *)waterflowView
{
    static NSString *ID = @"SHOP";
    ERHealthTypeCell *cell = [waterflowView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ERHealthTypeCell alloc] init];
        cell.identifier = ID;
    }
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        self.imageView = imageView;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.textColor = [UIColor whiteColor];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;

    }
    return self;
}

- (void)setHealthType:(ERHealthType *)healthType
{
    _healthType = healthType;
    self.imageView.image = [UIImage imageNamed:healthType.icon];
    self.nameLabel.text = healthType.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
    CGFloat nameLabelX = 0;
    CGFloat nameLabelH = 25;
    CGFloat nameLabelY = self.bounds.size.height - nameLabelH;
    CGFloat nameLabelW = self.bounds.size.width;
    self.nameLabel.frame = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
}
@end
