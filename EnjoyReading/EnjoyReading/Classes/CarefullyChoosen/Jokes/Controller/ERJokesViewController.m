//
//  ERJokesViewController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/8.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERJokesViewController.h"
#import "ERHttpTool.h"
#import "MJExtension.h"
#import "ERJoke.h"
#import "ERJokeCell.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"

@interface ERJokesViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 用来装joke模型 */
@property (nonatomic, strong) NSMutableArray *jokes;

/**  当前页码 */
@property (nonatomic, assign) CGFloat currentPage;

/**  记录总数 */
@property (nonatomic, assign) NSInteger totalNumber;

@end

@implementation ERJokesViewController
- (NSMutableArray *)jokes
{
    if (_jokes == nil) {
        _jokes = [NSMutableArray array];
    }
    return _jokes;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"幽默段子";
    self.view.backgroundColor = ERColor(245, 245, 245);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [MBProgressHUD showMessage:@"正在拼命加载您喜欢的内容..."];
    // 添加刷新控件
    [self setupRefresh];
    self.tableView.mj_footer.hidden = YES;
    
    [MBProgressHUD hideHUD];
    
    // 自动加载数据
    [self.tableView.mj_header beginRefreshing];
}

// 添加刷新控件
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewJokes)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreJokes)];
}

#pragma mark --加载数据
- (void)loadMoreJokes
{
    self.tableView.mj_footer.hidden = NO;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"3110ae6e836243dcad51547901bb9c76";
    params[@"page"] = @(++self.currentPage);
    params[@"rows"] = @"10";
    
    [ERHttpTool GET:@"http://api.avatardata.cn/Joke/NewstJoke" parameters:params success:^(id responseObject) {
        ERLog(@"%@",responseObject);
        NSArray *jokesArr = [ERJoke objectArrayWithKeyValuesArray:responseObject[@"result"]];
    
        [self.jokes addObjectsFromArray:jokesArr];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"加载失败,请重试"];
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        [MBProgressHUD hideHUD];
        
    }];

}
- (void)loadNewJokes
{

    self.currentPage = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"3110ae6e836243dcad51547901bb9c76";
    params[@"page"] = @(self.currentPage);
    params[@"rows"] = @"10";
    
    [ERHttpTool GET:@"http://api.avatardata.cn/Joke/NewstJoke" parameters:params success:^(id responseObject) {

        ERLog(@"%@",responseObject);
        NSArray *jokesArr = [ERJoke objectArrayWithKeyValuesArray:responseObject[@"result"]];
        
        [self.jokes removeAllObjects];
        
        [self.jokes addObjectsFromArray:jokesArr];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
         self.tableView.mj_footer.hidden = NO;
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"加载失败,请重试"];
        [MBProgressHUD hideHUD];
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
    }];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.jokes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ERJokeCell *cell = [ERJokeCell cellWithTableView:tableView];
    
    cell.joke = self.jokes[indexPath.row];
    
    return cell;
}

// 返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERJoke *joke = self.jokes[indexPath.row];
    return joke.cellHeight;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}



@end
