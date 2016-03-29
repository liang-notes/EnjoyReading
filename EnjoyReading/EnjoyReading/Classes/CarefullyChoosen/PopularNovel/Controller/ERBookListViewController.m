//
//  ERBookListViewController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/23.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERBookListViewController.h"
#import "MJExtension.h"
#import "ERBookList.h"
#import "ERBookListCell.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"
#import "ERPopularNovelController.h"
#import "ERHttpTool.h"

@interface ERBookListViewController ()
/** 模型数据 */
@property (nonatomic, strong) NSMutableArray *bookLists;

/**  当前页码 */
@property (nonatomic, assign) NSInteger currentPage;
@end

@implementation ERBookListViewController

- (NSMutableArray *)bookLists
{
    if (_bookLists == nil) {
        _bookLists = [NSMutableArray array];
    }
    return _bookLists;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ERColor(245, 245, 245);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"精选书籍";
    
    [self setupRefresh];
    self.tableView.mj_footer.hidden = YES;
    
    [self.tableView.mj_header beginRefreshing];
    

}
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadBookList)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreBookList)];
}

- (void)loadMoreBookList
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"7bf70b814c7845ce886d54902c9834f1";
    params[@"id"] = @6;
    params[@"page"] = @(++self.currentPage);
    params[@"rows"] = @10;
    
    [ERHttpTool GET:@"http://api.avatardata.cn/Book/List" parameters:params success:^(id responseObject) {
        ERLog(@"请求成功---%@",responseObject);
        
        NSArray *bookLists = [ERBookList objectArrayWithKeyValuesArray:responseObject[@"result"]];
        
        [self.bookLists addObjectsFromArray:bookLists];
        
        [self.tableView reloadData];
        self.tableView.mj_footer.hidden = NO;
        [self.tableView.mj_footer endRefreshing];
        
        
    } failure:^(NSError *error) {
        ERLog(@"请求失败---%@",error);
        
    }];
    
}

- (void)loadBookList
{
    self.currentPage = 1;

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"7bf70b814c7845ce886d54902c9834f1";
    params[@"id"] = @6;
    params[@"page"] = @(self.currentPage);
    params[@"rows"] = @10;
    
    [ERHttpTool GET:@"http://api.avatardata.cn/Book/List" parameters:params success:^(id responseObject) {
        ERLog(@"请求成功---%@",responseObject);
        
        NSArray *bookLists = [ERBookList objectArrayWithKeyValuesArray:responseObject[@"result"]];
        [self.bookLists removeAllObjects];
        [self.bookLists addObjectsFromArray:bookLists];
        
        [self.tableView reloadData];
        self.tableView.mj_footer.hidden = NO;
        [self.tableView.mj_header endRefreshing];

    } failure:^(NSError *error) {
        ERLog(@"请求失败---%@",error);
        
    }];
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.bookLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ERBookListCell *cell = [ERBookListCell cellWithTableView:tableView];
    cell.bookList = self.bookLists[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERBookList *cc = self.bookLists[indexPath.row];
    return cc.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERBookList *book = self.bookLists[indexPath.row];
    ERPopularNovelController *pop = [[ERPopularNovelController alloc] init];
    pop.idstr = book.id;
    pop.name = book.name;
    [self.navigationController pushViewController:pop animated:YES];
}


@end
