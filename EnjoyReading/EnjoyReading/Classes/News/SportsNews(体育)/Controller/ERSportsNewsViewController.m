//
//  ERSportsNewsViewController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/11.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERSportsNewsViewController.h"
#import "ERSportsNews.h"
#import "ERSportsNewsCell.h"
#import "ERHttpTool.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "ERNewsDetailViewController.h"
#import "MBProgressHUD+MJ.h"

@interface ERSportsNewsViewController ()
/** 模型数组 */
@property (nonatomic, strong) NSMutableArray *sportsNewses;
/**  当前页码 */
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation ERSportsNewsViewController
- (NSMutableArray *)sportsNewses
{
    if (_sportsNewses == nil) {
        _sportsNewses = [NSMutableArray array];
    }
    return _sportsNewses;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ERColor(245, 245, 245);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.title = @"体育新闻";
    // 添加刷新控件
    [self setupRefresh];
    self.tableView.mj_footer.hidden = YES;

    [self.tableView.mj_header beginRefreshing];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewSportsNews)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreSportsNews)];
}
- (void)loadNewSportsNews
{
    self.currentPage = 1;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"key"] = @"55b123ababa54099a272b92f05ff8dac";
    param[@"page"] = @(self.currentPage);
    param[@"rows"] = @"20";
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [ERHttpTool GET:@"http://api.avatardata.cn/SportsNews/Query" parameters:param success:^(id responseObject) {
//        ERLog(@"%@",responseObject);
        
        NSMutableArray *newsArray = [NSMutableArray array];
        NSArray *dictArr = responseObject[@"result"];
        for (NSDictionary *dict in dictArr) {
            ERSportsNews *sportsNews = [ERSportsNews sportsNewsWithDict:dict];
            [newsArray addObject:sportsNews];
        }
        [self.sportsNewses removeAllObjects];
        [self.sportsNewses addObjectsFromArray:newsArray];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.tableView.mj_footer.hidden = NO;
    } failure:^(NSError *error) {
        ERLog(@"%@",error);
        [MBProgressHUD showError:@"数据加载失败...请重试"];
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)loadMoreSportsNews
{

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"key"] = @"55b123ababa54099a272b92f05ff8dac";
    param[@"page"] = @(++self.currentPage);
    param[@"rows"] = @"20";
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [ERHttpTool GET:@"http://api.avatardata.cn/SportsNews/Query" parameters:param success:^(id responseObject) {
//        ERLog(@"%@",responseObject);
        
        NSMutableArray *nationalNewsArray = [NSMutableArray array];
        NSArray *dictArr = responseObject[@"result"];
        for (NSDictionary *dict in dictArr) {
            ERSportsNews *sportsNews = [ERSportsNews sportsNewsWithDict:dict];
            [nationalNewsArray addObject:sportsNews];
        }
        [self.sportsNewses addObjectsFromArray:nationalNewsArray];
        
        
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
    
    return self.sportsNewses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ERSportsNewsCell *cell = [ERSportsNewsCell cellWithTableView:tableView];
    
    cell.sportsNews = self.sportsNewses[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERSportsNews *sportsNews = self.sportsNewses[indexPath.row];
    return sportsNews.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERSportsNews *sportsNews = self.sportsNewses[indexPath.row];
    
    ERNewsDetailViewController *detailVc = [[ERNewsDetailViewController alloc] init];
    detailVc.url = sportsNews.url;
    [self.navigationController pushViewController:detailVc animated:YES];
}

@end
