//
//  ERTravelNewsViewController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/11.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERTravelNewsViewController.h"
#import "ERTravelNews.h"
#import "ERTravelNewsCell.h"
#import "ERHttpTool.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "ERNewsDetailViewController.h"
#import "MBProgressHUD+MJ.h"

@interface ERTravelNewsViewController ()
/** 模型数组 */
@property (nonatomic, strong) NSMutableArray *travelNewses;

/**  当前页码 */
@property (nonatomic, assign) NSInteger currentPage;
@end

@implementation ERTravelNewsViewController
- (NSMutableArray *)travelNewses
{
    if (_travelNewses == nil) {
        _travelNewses = [NSMutableArray array];
    }
    return _travelNewses;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ERColor(245, 245, 245);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.title = @"旅游新闻";

    // 添加刷新控件
    [self setupRefresh];
    self.tableView.mj_footer.hidden = YES;
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTravelNews)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTravelNews)];
}
- (void)loadNewTravelNews
{
    self.currentPage = 1;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"key"] = @"277fb36dce7f45f2b360f85b60283f26";
    param[@"page"] = @(self.currentPage);
    param[@"rows"] = @"20";
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [ERHttpTool GET:@"http://api.avatardata.cn/TravelNews/Query" parameters:param success:^(id responseObject) {
//        ERLog(@"%@",responseObject);
        
        NSMutableArray *nationalNewsArray = [NSMutableArray array];
        NSArray *dictArr = responseObject[@"result"];
        for (NSDictionary *dict in dictArr) {
            ERTravelNews *travelNews = [ERTravelNews travelNewsWithDict:dict];
            [nationalNewsArray addObject:travelNews];
        }
        [self.travelNewses removeAllObjects];
        [self.travelNewses addObjectsFromArray:nationalNewsArray];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.tableView.mj_footer.hidden = NO;
    } failure:^(NSError *error) {
//        ERLog(@"%@",error);
        [MBProgressHUD showError:@"数据加载失败...请重试"];
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)loadMoreTravelNews
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"key"] = @"277fb36dce7f45f2b360f85b60283f26";
    param[@"page"] = @(++self.currentPage);
    param[@"rows"] = @"20";
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [ERHttpTool GET:@"http://api.avatardata.cn/TravelNews/Query" parameters:param success:^(id responseObject) {
//        ERLog(@"%@",responseObject);
        
        NSMutableArray *nationalNewsArray = [NSMutableArray array];
        NSArray *dictArr = responseObject[@"result"];
        for (NSDictionary *dict in dictArr) {
            ERTravelNews *travelNews = [ERTravelNews travelNewsWithDict:dict];
            [nationalNewsArray addObject:travelNews];
        }
        [self.travelNewses addObjectsFromArray:nationalNewsArray];
        
        
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
    
    return self.travelNewses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ERTravelNewsCell *cell = [ERTravelNewsCell cellWithTableView:tableView];
    
    cell.travelNews = self.travelNewses[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERTravelNews *travelNews = self.travelNewses[indexPath.row];
    return travelNews.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERTravelNews *travelNews = self.travelNewses[indexPath.row];
    
    ERNewsDetailViewController *detailVc = [[ERNewsDetailViewController alloc] init];
    detailVc.url = travelNews.url;
    [self.navigationController pushViewController:detailVc animated:YES];
}

@end
