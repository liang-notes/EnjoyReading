//
//  ERAttentionViewController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/21.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERAttentionViewController.h"
#import "ERAttentionCategory.h"
#import "ERCategoryCell.h"
#import "MJExtension.h"
#import "ERHttpTool.h"
#import "MJRefresh.h"
#import "ERHotNews.h"
#import "ERHotNewsCell.h"
#import "ERHotNewsDetailViewController.h"
#import "MBProgressHUD+MJ.h"

#define ERSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]
@interface ERAttentionViewController ()<UITableViewDataSource,UITableViewDelegate>
/**  categoryTableView */
@property (nonatomic, weak) UITableView *categoryTableView;

/**  hotNewsTableView */
@property (nonatomic, weak) UITableView *hotNewsTableView;

/** 类别数据 */
@property (nonatomic, strong) NSArray *categories;

///** hotNews数据 */
//@property (nonatomic, strong) NSArray *hotNewses;

/** 请求参数 */
@property (nonatomic, strong) NSMutableDictionary *params;

@end

@implementation ERAttentionViewController
//- (NSArray *)categories
//{
//    if (_categories == nil) {
//        _categories = [NSArray array];
//    }
//    return _categories;
//}

//- (NSArray *)hotNewses
//{
//    if (_hotNewses == nil) {
//        _hotNewses = [NSArray array];
//    }
//    return _hotNewses;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化子控件
    [self setupTableView];

    [MBProgressHUD showMessage:@"正在加载中..."];
    // 添加刷新控件
    [self setupRefresh];
    [MBProgressHUD hideHUD];
    // 加载左侧的类别数据
    [self loadCategory];

}
/**
 *  初始化子控件
 */
- (void)setupTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = ERGlobalBackground;
    
    // 设置标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.text = @"推荐关注";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.frame = CGRectMake(0, 0, 80, 30);
    self.navigationItem.titleView = titleLabel;
    
    UITableView *categoryTableView = [[UITableView alloc] init];
    categoryTableView.dataSource = self;
    categoryTableView.delegate = self;
    categoryTableView.x = 0;
    categoryTableView.y = 0;
    categoryTableView.width = CategoryTableViewW;
    categoryTableView.height = ScreenH - categoryTableView.y;
    categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    categoryTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:categoryTableView];
    self.categoryTableView = categoryTableView;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    UITableView *hotNewsTableView = [[UITableView alloc] init];
    hotNewsTableView.dataSource = self;
    hotNewsTableView.delegate = self;
    hotNewsTableView.x = categoryTableView.width;
    hotNewsTableView.y = 0;
    hotNewsTableView.width = HotNewsTableViewW;
    hotNewsTableView.height = ScreenH - hotNewsTableView.y;
    hotNewsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    hotNewsTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:hotNewsTableView];
    self.hotNewsTableView = hotNewsTableView;
    self.hotNewsTableView.contentInset = self.categoryTableView.contentInset;
}
/**
 * 添加刷新控件
 */
- (void)setupRefresh
{
    self.hotNewsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHotNews)];
    
    self.hotNewsTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreHotNews)];
    self.hotNewsTableView.mj_footer.hidden = YES;
}

#pragma mark--加载新闻数据
- (void)loadMoreHotNews
{
    ERAttentionCategory *cate2 = ERSelectedCategory;

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"b4ef58c687c44c249309a27758225acf";
    params[@"id"] = cate2.id;
    params[@"page"] = @(++cate2.currentPage);
    params[@"rows"] = @20;
    self.params = params;
    
    [ERHttpTool GET:@"http://api.avatardata.cn/Top/List" parameters:params success:^(id responseObject) {
        ERLog(@"%@",responseObject);
        // 字典数组 -> 模型数组
        NSArray *hotNewses = [ERHotNews objectArrayWithKeyValuesArray:responseObject[@"result"]];
 
        // 添加到当前类别对应的用户数组中
        [cate2.hotNewses addObjectsFromArray:hotNewses];
  
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.hotNewsTableView reloadData];

        // 让底部控件结束刷新
        [self checkFooterState];

    } failure:^(NSError *error) {
        ERLog(@"%@",error);
        if (self.params != params) return;
        
        // 结束刷新
        [self.hotNewsTableView.mj_footer endRefreshing];
    }];

}
- (void)loadHotNews
{
    ERAttentionCategory *cate = ERSelectedCategory;
    cate.currentPage = 1;

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"b4ef58c687c44c249309a27758225acf";
    params[@"id"] = cate.id;
    params[@"page"] = @(cate.currentPage);
    params[@"rows"] = @20;
    self.params = params;
    
    [ERHttpTool GET:@"http://api.avatardata.cn/Top/List" parameters:params success:^(id responseObject) {
        ERLog(@"%@",responseObject);
         // 字典数组 -> 模型数组
        NSArray *hotNewses = [ERHotNews objectArrayWithKeyValuesArray:responseObject[@"result"]];
        
        // 清除所有旧数据
        [cate.hotNewses removeAllObjects];
        
        // 添加到当前类别对应的用户数组中
        [cate.hotNewses addObjectsFromArray:hotNewses];
        
        // 保存总数
        cate.total = [responseObject[@"total"] integerValue];
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.hotNewsTableView reloadData];
        
        // 结束刷新
        [self.hotNewsTableView.mj_header endRefreshing];
        
        // 让底部控件结束刷新
        [self checkFooterState];
        /*
//        self.hotNewses = [ERHotNews objectArrayWithKeyValuesArray:responseObject[@"result"]];
         self.hotNewses = [ERHotNews objectArrayWithKeyValuesArray:responseObject[@"result"]];
        [cate.hotNewses addObjectsFromArray:self.hotNewses];
        
        [self.hotNewsTableView reloadData];
        */
        
    } failure:^(NSError *error) {
        ERLog(@"%@",error);
        if (self.params != params) return;
        
        // 结束刷新
        [self.hotNewsTableView.mj_header endRefreshing];
    }];

}
/**
 * 时刻监测footer的状态
 */
- (void)checkFooterState
{
    ERAttentionCategory *rc = ERSelectedCategory;
    
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.hotNewsTableView.mj_footer.hidden = (rc.hotNewses.count == 0);
    
    // 让底部控件结束刷新
    if (rc.hotNewses.count == rc.total) { // 全部数据已经加载完毕
        [self.hotNewsTableView.mj_footer endRefreshingWithNoMoreData];
    } else { // 还没有加载完毕
        [self.hotNewsTableView.mj_footer endRefreshing];
    }
}

#pragma mark--加载分类数据
- (void)loadCategory
{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"b4ef58c687c44c249309a27758225acf";
    
    [ERHttpTool GET:@"http://api.avatardata.cn/Top/TopClass" parameters:params success:^(id responseObject) {
        ERLog(@"%@",responseObject);
        
        self.categories = [ERAttentionCategory objectArrayWithKeyValuesArray:responseObject[@"result"]];
        
        [self.categoryTableView reloadData];
        
        // 默认首行选中
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        // 让用户表格进入下拉刷新状态
        [self.hotNewsTableView.mj_header beginRefreshing];
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        ERLog(@"%@",error);
        [MBProgressHUD showError:@"网络不给力,请重试"];
        [MBProgressHUD hideHUD];
    }];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if ([tableView isEqual:self.categoryTableView]) return self.categories.count;

        // 监测footer的状态
        [self checkFooterState];

//        return self.hotNewses.count;
       // 右边的用户表格
        return [ERSelectedCategory hotNewses].count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.categoryTableView) {
        ERCategoryCell *cell = [ERCategoryCell cellWithTableView:self.categoryTableView];
        cell.category = self.categories[indexPath.row];
        return cell;
    }else{
        ERHotNewsCell *cell = [ERHotNewsCell cellWithTableView:self.hotNewsTableView];
//        cell.hotNews = self.hotNewses[indexPath.row];
        cell.hotNews = [ERSelectedCategory hotNewses][indexPath.row];
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView == self.categoryTableView) {
        ERAttentionCategory *cc = self.categories[indexPath.row];
        return cc.cellHeight;
    }else{
//        ERHotNews *hot = self.hotNewses[indexPath.row];
        ERHotNews *hot = [ERSelectedCategory hotNewses][indexPath.row];
        return hot.cellHeight;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        // 结束刷新
        [self.hotNewsTableView.mj_header endRefreshing];
        [self.hotNewsTableView.mj_footer endRefreshing];
        
        ERAttentionCategory *c = self.categories[indexPath.row];
        if (c.hotNewses.count) {
            // 显示曾经的数据
            [self.hotNewsTableView reloadData];
        }else{
            // 赶紧刷新表格,目的是: 马上显示当前category的用户数据, 不让用户看见上一个category的残留数据
            [self.hotNewsTableView reloadData];
            
            // 进入下拉刷新状态
            [self.hotNewsTableView.mj_header beginRefreshing];
        }
//        [self loadHotNews];
    }else{
        ERLog(@"点我了");
        ERHotNewsDetailViewController *detailVc = [[ERHotNewsDetailViewController alloc] init];
        ERHotNews *hot = [ERSelectedCategory hotNewses][indexPath.row];
        detailVc.id = hot.id;
        [self.navigationController pushViewController:detailVc animated:YES];

    }
   
    
}
@end
