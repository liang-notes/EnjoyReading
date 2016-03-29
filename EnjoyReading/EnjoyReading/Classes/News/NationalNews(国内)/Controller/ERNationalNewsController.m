//
//  ERNationalNewsController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/10.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERNationalNewsController.h"
#import "ERNationalNews.h"
#import "ERNationalNewsCell.h"
#import "ERHttpTool.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "ERNewsDetailViewController.h"
#import "MBProgressHUD+MJ.h"

@interface ERNationalNewsController ()

/** ERNationalNews模型数组 */
@property (nonatomic, strong) NSMutableArray *nationalNewses;

/**  当前页码 */
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation ERNationalNewsController
- (NSMutableArray *)nationalNewses
{
    if (_nationalNewses == nil) {
        _nationalNewses = [NSMutableArray array];
    }
    return _nationalNewses;
}
- (void)viewDidLoad {
    [super viewDidLoad];
      self.view.backgroundColor = ERColor(245, 245, 245);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"国内新闻";
    // 添加刷新控件
    [self setupRefresh];
    self.tableView.mj_footer.hidden = YES;
    [self.tableView.mj_header beginRefreshing];

}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewNationalNews)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreNationalNews)];
}
- (void)loadNewNationalNews
{
    self.currentPage = 1;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"key"] = @"b95675f7e7494c85972a3df0682ee49d";
    param[@"page"] = @(self.currentPage);
    param[@"rows"] = @"20";
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [ERHttpTool GET:@"http://api.avatardata.cn/GuoNeiNews/Query" parameters:param success:^(id responseObject) {
        ERLog(@"%@",responseObject);
        
        NSMutableArray *nationalNewsArray = [NSMutableArray array];
        NSArray *dictArr = responseObject[@"result"];
        for (NSDictionary *dict in dictArr) {
            ERNationalNews *nationalNews = [ERNationalNews nationalNewsWithDict:dict];
            [nationalNewsArray addObject:nationalNews];
        }
        [self.nationalNewses removeAllObjects];
        [self.nationalNewses addObjectsFromArray:nationalNewsArray];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.tableView.mj_footer.hidden = NO;
    } failure:^(NSError *error) {
        ERLog(@"%@",error);
        [MBProgressHUD showError:@"数据加载失败...请重试"];
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)loadMoreNationalNews
{

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"key"] = @"b95675f7e7494c85972a3df0682ee49d";
    param[@"page"] = @(++self.currentPage);
    param[@"rows"] = @"20";

    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [ERHttpTool GET:@"http://api.avatardata.cn/GuoNeiNews/Query" parameters:param success:^(id responseObject) {
//        ERLog(@"%@",responseObject);
        
        NSMutableArray *nationalNewsArray = [NSMutableArray array];
        NSArray *dictArr = responseObject[@"result"];
        for (NSDictionary *dict in dictArr) {
            ERNationalNews *nationalNews = [ERNationalNews nationalNewsWithDict:dict];
            [nationalNewsArray addObject:nationalNews];
        }
        [self.nationalNewses addObjectsFromArray:nationalNewsArray];

        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        ERLog(@"%@",error);
        [MBProgressHUD showError:@"数据加载失败...请重试"];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.nationalNewses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ERNationalNewsCell *cell = [ERNationalNewsCell cellWithTableView:tableView];
    
    cell.nationalNews = self.nationalNewses[indexPath.row];
    
    
    return cell;
}

// 返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERNationalNews *natinalNews = self.nationalNewses[indexPath.row];
    return natinalNews.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERNationalNews *nationalNews = self.nationalNewses[indexPath.row];
    
    ERNewsDetailViewController *detailVc = [[ERNewsDetailViewController alloc] init];
    detailVc.url = nationalNews.url;
    [self.navigationController pushViewController:detailVc animated:YES];
}
@end
