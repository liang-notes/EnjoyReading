//
//  ERXiangQingViewController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/18.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERXiangQingViewController.h"
#import "ERHttpTool.h"
#import "ERHealthDetailCell.h"
#import "ERHealthDetail.h"
#import "UIImageView+WebCache.h"

@interface ERXiangQingViewController ()

/** 模型数组 */
@property (nonatomic, strong) NSMutableArray *healthDetails;
@property (nonatomic, weak) UIActivityIndicatorView *circle;
@end

@implementation ERXiangQingViewController
-(NSMutableArray *)healthDetails
{
    if (_healthDetails == nil) {
        _healthDetails = [NSMutableArray array];
    }
    return _healthDetails;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ERColor(245, 245, 245);
//    self.view.backgroundColor = [UIColor grayColor];

    self.title = @"健康知识正文";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIActivityIndicatorView *circle = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    circle.centerX = 0.5 * ScreenW;
    circle.centerY = 0.5 * ScreenH;
    [self.view addSubview:circle];
    self.circle = circle;
    [self.circle startAnimating];

    [self loadHealthDetailKnowledge];
    

    
}
- (void)loadHealthDetailKnowledge
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"key"] = @"ffe8a0409afc49139c3e541f4193481e";
    param[@"id"] = self.idstr;
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [ERHttpTool GET:@"http://api.avatardata.cn/Lore/Show" parameters:param success:^(id responseObject) {
        ERLog(@"%@",responseObject);
        NSDictionary *dict = responseObject[@"result"];
        ERLog(@"%@",[responseObject[@"result"] class]);
        ERHealthDetail *healthDetail = [ERHealthDetail healthDetailWithDict:dict];
        [self.healthDetails addObject:healthDetail];
        
        if (self.healthDetails.count > 0) {
                
            [self.tableView reloadData];
            [self.circle stopAnimating];
        }
        
    } failure:^(NSError *error) {
        ERLog(@"%@",error);
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.healthDetails.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ERHealthDetailCell *cell = [ERHealthDetailCell cellWithTableView:tableView];
    
    ERHealthDetail *h = self.healthDetails[indexPath.row];
    cell.healthDtail = h;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERHealthDetail *h = self.healthDetails[indexPath.row];
    return h.cellHeight;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
  
}


@end
