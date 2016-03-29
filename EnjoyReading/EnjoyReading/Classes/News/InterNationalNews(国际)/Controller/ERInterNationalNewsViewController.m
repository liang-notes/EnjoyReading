//
//  ERInterNationalNewsViewController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/11.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERInterNationalNewsViewController.h"
#import "ERInterNationalNews.h"
#import "ERInterNationalNewsCell.h"
#import "ERHttpTool.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "ERNewsDetailViewController.h"
#import "MBProgressHUD+MJ.h"

@interface ERInterNationalNewsViewController ()

/** 模型数组 */
@property (nonatomic, strong) NSMutableArray *interNationalNewses;

/**  当前页码 */
@property (nonatomic, assign) NSInteger currentPage;
@end

@implementation ERInterNationalNewsViewController
- (NSMutableArray *)interNationalNewses
{
    if (_interNationalNewses == nil) {
        _interNationalNewses = [NSMutableArray array];
    }
    return _interNationalNewses;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ERColor(245, 245, 245);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.title = @"国际新闻";

    // 添加刷新控件
    [self setupRefresh];
    self.tableView.mj_footer.hidden = YES;
    [self.tableView.mj_header beginRefreshing];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewInterNationalNews)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreInterNationalNews)];
}
- (void)loadNewInterNationalNews
{
    self.currentPage = 1;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"key"] = @"e32e16fac9894f3a9857f8664fb449d7";
    param[@"page"] = @(self.currentPage);
    param[@"rows"] = @"20";
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [ERHttpTool GET:@"http://api.avatardata.cn/WorldNews/Query" parameters:param success:^(id responseObject) {
//        ERLog(@"%@",responseObject);
        
        NSMutableArray *nationalNewsArray = [NSMutableArray array];
        NSArray *dictArr = responseObject[@"result"];
        for (NSDictionary *dict in dictArr) {
            ERInterNationalNews *interNationalNews = [ERInterNationalNews interNationalNewsWithDict:dict];
            [nationalNewsArray addObject:interNationalNews];
        }
        [self.interNationalNewses removeAllObjects];
        [self.interNationalNewses addObjectsFromArray:nationalNewsArray];

        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.tableView.mj_footer.hidden = NO;
        
    } failure:^(NSError *error) {
        ERLog(@"%@",error);
        [MBProgressHUD showError:@"数据加载失败...请重试"];
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)loadMoreInterNationalNews
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"key"] = @"e32e16fac9894f3a9857f8664fb449d7";
    param[@"page"] = @(++self.currentPage);
    param[@"rows"] = @"20";
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [ERHttpTool GET:@"http://api.avatardata.cn/WorldNews/Query" parameters:param success:^(id responseObject) {
//        ERLog(@"%@",responseObject);
        
        NSMutableArray *nationalNewsArray = [NSMutableArray array];
        NSArray *dictArr = responseObject[@"result"];
        for (NSDictionary *dict in dictArr) {
            ERInterNationalNews *interNationalNews = [ERInterNationalNews interNationalNewsWithDict:dict];
            [nationalNewsArray addObject:interNationalNews];
        }
        [self.interNationalNewses addObjectsFromArray:nationalNewsArray];

        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        self.tableView.mj_footer.hidden = NO;
    } failure:^(NSError *error) {
        ERLog(@"%@",error);
        [MBProgressHUD showError:@"数据加载失败...请重试"];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.interNationalNewses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ERInterNationalNewsCell *cell = [ERInterNationalNewsCell cellWithTableView:tableView];
    
    cell.interNationalNews = self.interNationalNewses[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERInterNationalNews *interNationalNews = self.interNationalNewses[indexPath.row];
    return interNationalNews.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERInterNationalNews *interNationalNews = self.interNationalNewses[indexPath.row];
    
    ERNewsDetailViewController *detailVc = [[ERNewsDetailViewController alloc] init];
    detailVc.url = interNationalNews.url;
    [self.navigationController pushViewController:detailVc animated:YES];
}

@end
