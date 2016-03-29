//
//  ERHealthDetailController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/18.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHealthDetailController.h"
#import "ERHealthFrame.h"
#import "ERHealthCell.h"
#import "ERHealth.h"
#import "MJRefresh.h"
#import "ERHttpTool.h"
#import "ERXiangQingViewController.h"
#import "MBProgressHUD+MJ.h"
#import "SDImageCache.h"

@interface ERHealthDetailController ()

/** VM模型数组 */
@property (nonatomic, strong) NSMutableArray *healthFrames;

/**  记录此页最大的id */
@property (nonatomic, copy) NSString *max_Idstr;
/**  所有的条数 */
@property (nonatomic, assign) NSInteger totalNumber;
@end

@implementation ERHealthDetailController
- (NSMutableArray *)healthFrames
{
    if (_healthFrames == nil) {
        _healthFrames = [NSMutableArray array];
    }
    return _healthFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [MBProgressHUD showMessage:@"正在拼命加载您喜欢的内容..."];
    [self setupRefresh];
    self.tableView.mj_footer.hidden = YES;

    [MBProgressHUD hideHUD];
    [self.tableView.mj_header beginRefreshing];

    
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHealthKnowledge)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreHealthKnowledge)];
    
}

- (void)loadHealthKnowledge
{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"key"] = @"ffe8a0409afc49139c3e541f4193481e";
    param[@"classify"] = self.classify;
    param[@"page"] = @1;
    param[@"rows"] = @5;
    param[@"id"] = @0;
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [ERHttpTool GET:@"http://api.avatardata.cn/Lore/News" parameters:param success:^(id responseObject) {
        ERLog(@"%@",responseObject);
        NSArray *dictArray = responseObject[@"result"];
        self.totalNumber = [responseObject[@"total"] integerValue];
        ERLog(@"totalNumber--%zd",self.totalNumber);
        NSMutableArray *healthFArr = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            ERHealth *health = [ERHealth healthWithDict:dict];
            ERHealthFrame *healthFrame = [[ERHealthFrame alloc] init];
            healthFrame.health = health;
            [healthFArr addObject:healthFrame];
        }
        [self.healthFrames removeAllObjects];
        [self.healthFrames addObjectsFromArray:healthFArr];

        // 保存此页获得的最大id
        ERHealthFrame *h2 = [self.healthFrames lastObject];
        self.max_Idstr = h2.health.idstr;
        ERLog(@"aaa%@",self.max_Idstr);
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        // 每次刷新右边数据时, 都控制footer显示或者隐藏
        self.tableView.mj_footer.hidden = (self.healthFrames.count == 0);
        // 让底部控件结束刷新
        if (self.healthFrames.count == self.totalNumber) { // 全部数据已经加载完毕
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else { // 还没有加载完毕
            [self.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSError *error) {
        ERLog(@"%@",error);
        [MBProgressHUD showError:@"数据加载失败...请重试"];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreHealthKnowledge
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"key"] = @"ffe8a0409afc49139c3e541f4193481e";
    param[@"classify"] = self.classify;
    param[@"page"] = @1;
    param[@"rows"] = @10;
    param[@"id"] = self.max_Idstr;
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [ERHttpTool GET:@"http://api.avatardata.cn/Lore/News" parameters:param success:^(id responseObject) {
        ERLog(@"%@",responseObject);
        NSArray *dictArray = responseObject[@"result"];
        NSMutableArray *healthFArr = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            ERHealth *health = [ERHealth healthWithDict:dict];
            ERHealthFrame *healthFrame = [[ERHealthFrame alloc] init];
            healthFrame.health = health;
            [healthFArr addObject:healthFrame];
        }

        [self.healthFrames addObjectsFromArray:healthFArr];

        // 保存此页获得的最大id
        ERHealthFrame *h1 = [self.healthFrames lastObject];
        self.max_Idstr = h1.health.idstr;
        ERLog(@"ccc%@",self.max_Idstr);
        ERLog(@"ddd%zd",self.healthFrames.count);
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        // 每次刷新右边数据时, 都控制footer显示或者隐藏
        self.tableView.mj_footer.hidden = (self.healthFrames.count == 0);
        // 让底部控件结束刷新
        if (self.healthFrames.count == self.totalNumber) { // 全部数据已经加载完毕
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else { // 还没有加载完毕
            [self.tableView.mj_footer endRefreshing];
        }

    } failure:^(NSError *error) {
        ERLog(@"%@",error);
        [MBProgressHUD showError:@"数据加载失败...请重试"];
        [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.healthFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ERHealthCell *cell = [ERHealthCell cellWithTableView:tableView];
    
    ERHealthFrame *h = self.healthFrames[indexPath.row];
    cell.healthFrame = h;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERHealthFrame *h = self.healthFrames[indexPath.row];
    return h.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERHealthFrame *h = self.healthFrames[indexPath.row];
    ERXiangQingViewController *xiangQingVc = [[ERXiangQingViewController alloc] init];
    xiangQingVc.idstr = h.health.idstr;
    [self.navigationController pushViewController:xiangQingVc animated:YES];
}

@end
