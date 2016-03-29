//
//  ERAgricultureNewsViewController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/11.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERAgricultureNewsViewController.h"
#import "ERQiwenNews.h"
#import "ERQiwenNewsCell.h"
#import "ERHttpTool.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "ERNewsDetailViewController.h"
#import "MBProgressHUD+MJ.h"

@interface ERAgricultureNewsViewController()

/** qiwinNewses模型数组 */
@property (nonatomic, strong) NSMutableArray *qiwinNewses;

/**  当前页码 */
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation ERAgricultureNewsViewController
- (NSMutableArray *)qiwinNewses
{
    if (_qiwinNewses == nil) {
        _qiwinNewses = [NSMutableArray array];
    }
    return _qiwinNewses;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ERColor(245, 245, 245);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"奇闻异事";
    // 添加刷新控件
    [self setupRefresh];
    self.tableView.mj_footer.hidden = YES;
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadQiwenNews)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreQiwenNews)];
}
- (void)loadQiwenNews
{
    self.currentPage = 1;

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"key"] = @"e47185d9a11047fa8dc060a04df4a8b9";
    param[@"page"] = @(self.currentPage);
    param[@"rows"] = @"10";
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [ERHttpTool GET:@"http://api.avatardata.cn/QiWenNews/Query" parameters:param success:^(id responseObject) {
        ERLog(@"%@",responseObject);
        
        NSMutableArray *qiwenNewsArray = [NSMutableArray array];
        NSArray *dictArr = responseObject[@"result"];
        for (NSDictionary *dict in dictArr) {
            ERQiwenNews *qiwenNews = [ERQiwenNews qiwenNewsWithDict:dict];
            [qiwenNewsArray addObject:qiwenNews];
        }
        [self.qiwinNewses removeAllObjects];
        [self.qiwinNewses addObjectsFromArray:qiwenNewsArray];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.tableView.mj_footer.hidden = NO;
    } failure:^(NSError *error) {
        ERLog(@"%@",error);
        [MBProgressHUD showError:@"数据加载失败...请重试"];
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)loadMoreQiwenNews
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"key"] = @"e47185d9a11047fa8dc060a04df4a8b9";
    param[@"page"] = @(++self.currentPage);
    param[@"rows"] = @"10";
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [ERHttpTool GET:@"http://api.avatardata.cn/QiWenNews/Query" parameters:param success:^(id responseObject) {
        ERLog(@"%@",responseObject);
        
        NSMutableArray *qiwenNewsArray = [NSMutableArray array];
        NSArray *dictArr = responseObject[@"result"];
        for (NSDictionary *dict in dictArr) {
            ERQiwenNews *qiwenNews = [ERQiwenNews qiwenNewsWithDict:dict];
            [qiwenNewsArray addObject:qiwenNews];
        }
        [self.qiwinNewses addObjectsFromArray:qiwenNewsArray];
        
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
    
    return self.qiwinNewses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ERQiwenNewsCell *cell = [ERQiwenNewsCell cellWithTableView:tableView];
    
    cell.qiwenNews = self.qiwinNewses[indexPath.row];
    
    
    return cell;
}

// 返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERQiwenNews *qiwenNews = self.qiwinNewses[indexPath.row];
    return qiwenNews.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERQiwenNews *qiwenNews = self.qiwinNewses[indexPath.row];
    
    ERNewsDetailViewController *detailVc = [[ERNewsDetailViewController alloc] init];
    detailVc.url = qiwenNews.url;
    [self.navigationController pushViewController:detailVc animated:YES];
}

@end
