//
//  ERCurrentNewsViewController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/11.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERCurrentNewsViewController.h"
#import "ERCurrentNewsFrame.h"
#import "ERCurrentNews.h"
#import "ERCurrenrNewsCell.h"
#import "ERHttpTool.h"
#import "MJExtension.h"
#import "ERSearchBar.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"
#import "ERNewsDetailViewController.h"
#import "UIImageView+WebCache.h"

@interface ERCurrentNewsViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

/** 存放新闻VM模型 */
@property (nonatomic, strong) NSMutableArray *currentNewsFrames;
/**  自定义tableView */
@property (nonatomic, weak) UITableView *newsTableView;
/**
 *  搜索框
 */
@property (nonatomic, weak) ERSearchBar *searchBar;

/**  记录输入的文字 */
@property (nonatomic, copy) NSString *text;
@end

@implementation ERCurrentNewsViewController
- (NSMutableArray *)currentNewsFrames
{
    if (_currentNewsFrames == nil) {
        _currentNewsFrames = [NSMutableArray array];
    }
    return _currentNewsFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ERColor(245, 245, 245);
    // 添加tableView
    UITableView *newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.searchBar.frame.size.height, ScreenW, ScreenH - 44 - 35-30) style:UITableViewStylePlain];
    newsTableView.delegate = self;
    newsTableView.dataSource = self;
    newsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:newsTableView];
    self.newsTableView = newsTableView;
    
    // 添加搜索框
    ERSearchBar *searchBar = [[ERSearchBar alloc] init];
    searchBar.delegate = self;
    searchBar.placeholder = @"热点搜索:腾讯、网易...";
    self.searchBar = searchBar;
    searchBar.frame = CGRectMake(NewsCellMargin, 0, ScreenW - 2 * NewsCellMargin, 35);
    self.newsTableView.tableHeaderView = searchBar;
    
    // 添加刷新控件
    [self setupRefresh];
    self.newsTableView.mj_footer.hidden = YES;
    [self.newsTableView.mj_header beginRefreshing];

}

- (void)setupRefresh
{
    self.newsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNews)];
    self.newsTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreNews)];
}


- (void)loadMoreNews
{

    [self.newsTableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)loadNews
{
    NSString *text = self.searchBar.text;
    text = (text.length) ? self.searchBar.text : @"搜狐";
    NSString *keyword = [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"4026424d9d8447a6833c9a52cf794a36";
    params[@"keyword"] = keyword;
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [ERHttpTool GET:@"http://api.avatardata.cn/ActNews/Query" parameters:params success:^(id responseObject) {
        ERLog(@"%@",responseObject);
        // 字典数组转模型数组
        NSMutableArray *currentFs = [NSMutableArray array];
        NSArray *currentNewsArr = [ERCurrentNews objectArrayWithKeyValuesArray:responseObject[@"result"]];
        for (ERCurrentNews *currentNews in currentNewsArr) {
            ERCurrentNewsFrame *currentF = [[ERCurrentNewsFrame alloc] init];
            currentF.currentNews = currentNews;
            [currentFs addObject:currentF];
        }
        
        [self.currentNewsFrames removeAllObjects];
        
        [self.currentNewsFrames addObjectsFromArray:currentFs];
        if (self.currentNewsFrames.count) {
            [self.newsTableView reloadData];
            [self.newsTableView.mj_header endRefreshing];
            self.newsTableView.mj_footer.hidden = NO;
        }else{
            [self.newsTableView.mj_header endRefreshing];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没有查询到您搜索的内容" message:@"请重新输入关键字" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
            [alert show];
            ERLog(@"没有查询到结果");
        }
        

    } failure:^(NSError *error) {
        ERLog(@"%@",error);
        
        [MBProgressHUD showError:@"加载失败,请重试"];
        [self.newsTableView.mj_header endRefreshing];
        [MBProgressHUD hideHUD];
    }];
}


#pragma mark --键盘的代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    if (self.searchBar.text.length) {
        [self.newsTableView.mj_header beginRefreshing];
    }
    return YES;
}

#pragma mark --tableViewDataSoure
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.currentNewsFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERCurrenrNewsCell *cell = [ERCurrenrNewsCell cellWithTableView:self.newsTableView];
    
    ERCurrentNewsFrame *currentF = self.currentNewsFrames[indexPath.row];
    cell.currentNewsF = currentF;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERCurrentNewsFrame *currentF = self.currentNewsFrames[indexPath.row];
    return currentF.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERNewsDetailViewController *detail = [[ERNewsDetailViewController alloc] init];
    ERCurrentNewsFrame *currentF = self.currentNewsFrames[indexPath.row];
    detail.url = currentF.currentNews.url;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
