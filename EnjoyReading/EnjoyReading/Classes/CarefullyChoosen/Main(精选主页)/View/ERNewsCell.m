//
//  ERNewsCell.m
//  08-无限滚动
//
//  Created by apple on 14-5-31.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ERNewsCell.h"
#import "ERNews.h"

@interface ERNewsCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@end

@implementation ERNewsCell
- (void)setNews:(ERNews *)news
{
    _news = news;
    
    self.iconView.image = [UIImage imageNamed:news.icon];
    self.titleLabel.text = [NSString stringWithFormat:@"  %@", news.title];
}

@end
