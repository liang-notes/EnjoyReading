//
//  ERTechnologyNewsViewController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/11.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERTechnologyNewsViewController.h"
#import "ERTechnologyNews.h"
#import "ERTechnologyNewsCell.h"
#import "ERHttpTool.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "ERNewsDetailViewController.h"
#import "MBProgressHUD+MJ.h"

@interface ERTechnologyNewsViewController ()
/** 模型数组 */
@property (nonatomic, strong) NSMutableArray *technologyNewses;

/**  当前页码 */
@property (nonatomic, assign) NSInteger currentPage;
@end

@implementation ERTechnologyNewsViewController
- (NSMutableArray *)technologyNewses
{
    if (_technologyNewses == nil) {
        _technologyNewses = [NSMutableArray array];
    }
    return _technologyNewses;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ERColor(245, 245, 245);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.title = @"科技新闻";

    // 添加刷新控件
    [self setupRefresh];
    self.tableView.mj_footer.hidden = YES;
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTechnologyNews)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTechnologyNews)];
}
- (void)loadNewTechnologyNews
{
    self.currentPage = 1;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"key"] = @"5cc6f544aee14ca5ab8ccc781e967f05";
    param[@"page"] = @(self.currentPage);
    param[@"rows"] = @"20";
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [ERHttpTool GET:@"http://api.avatardata.cn/TechNews/Query" parameters:param success:^(id responseObject) {
//        ERLog(@"%@",responseObject);
        
        NSMutableArray *nationalNewsArray = [NSMutableArray array];
        NSArray *dictArr = responseObject[@"result"];
        for (NSDictionary *dict in dictArr) {
            ERTechnologyNews *technologyNews = [ERTechnologyNews technologyNewsWithDict:dict];
            [nationalNewsArray addObject:technologyNews];
        }
        [self.technologyNewses removeAllObjects];
        [self.technologyNewses addObjectsFromArray:nationalNewsArray];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.tableView.mj_footer.hidden = NO;
    } failure:^(NSError *error) {
//        ERLog(@"%@",error);
        [MBProgressHUD showError:@"数据加载失败...请重试"];
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)loadMoreTechnologyNews
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"key"] = @"5cc6f544aee14ca5ab8ccc781e967f05";
    param[@"page"] = @(++self.currentPage);
    param[@"rows"] = @"20";
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [ERHttpTool GET:@"http://api.avatardata.cn/TechNews/Query" parameters:param success:^(id responseObject) {
//        ERLog(@"%@",responseObject);
        
        NSMutableArray *nationalNewsArray = [NSMutableArray array];
        NSArray *dictArr = responseObject[@"result"];
        for (NSDictionary *dict in dictArr) {
            ERTechnologyNews *technologyNews = [ERTechnologyNews technologyNewsWithDict:dict];
            [nationalNewsArray addObject:technologyNews];
        }
        [self.technologyNewses addObjectsFromArray:nationalNewsArray];
        
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
    
    return self.technologyNewses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ERTechnologyNewsCell *cell = [ERTechnologyNewsCell cellWithTableView:tableView];
    
    cell.technologyNews = self.technologyNewses[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERTechnologyNews *technologyNews = self.technologyNewses[indexPath.row];
    return technologyNews.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERTechnologyNews *technologyNews = self.technologyNewses[indexPath.row];
    
    ERNewsDetailViewController *detailVc = [[ERNewsDetailViewController alloc] init];
    detailVc.url = technologyNews.url;
    [self.navigationController pushViewController:detailVc animated:YES];
}

@end
