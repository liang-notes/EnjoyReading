//
//  ERWeChatChoosenViewController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/7.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERWeChatChoosenViewController.h"
#import "ERWxNews.h"
#import "ERWxNewsCell.h"
#import "ERHttpTool.h"
#import "ERSearchBar.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"
#import "ERNewsDetailViewController.h"
#import "UIImageView+WebCache.h"

@interface ERWeChatChoosenViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) NSMutableArray *wxNewses;

/** searchBar */
@property (nonatomic, strong) ERSearchBar *searchBar;

/**  记录页码 */
@property (nonatomic, assign) NSInteger currentPage;
/**  c */
@property (nonatomic, copy) NSString *str;

@end

@implementation ERWeChatChoosenViewController
-(NSMutableArray *)wxNewses
{
    if (_wxNewses == nil) {
        _wxNewses = [NSMutableArray array];
    }
    return _wxNewses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ERColor(245, 245, 245);
    self.title = @"微信精选";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 添加父控件
    UIView *vc = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35)];
    vc.backgroundColor = [UIColor clearColor];
    
    // 添加搜索按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.width = 60;
    btn.height = 35;
    btn.x = ScreenW - btn.width - 10;
    btn.y = 0;

    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitle:@"搜索一下" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [vc addSubview:btn];
    
    // 添加搜索框
    ERSearchBar *searchBar = [[ERSearchBar alloc] init];
    searchBar.x = 10;
    searchBar.y = 0;
    searchBar.width = ScreenW - btn.width - 10 - searchBar.x;
    searchBar.height = 35;
    self.searchBar = searchBar;
    self.searchBar.delegate = self;
    searchBar.placeholder = @"大家都在搜:北京、上海...";
    [vc addSubview:searchBar];

    self.tableView.tableHeaderView = vc;
    
    // 集成刷新控件
    [self setupRefresh];
    [MBProgressHUD showMessage:@"正在拼命加载数据..."];
    self.tableView.mj_footer.hidden = YES;
    [MBProgressHUD hideHUD];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewWxNews)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreWxNews)];
}

#pragma mark -- 加载数据
// 加载更多数据（上拉的时候）
- (void)loadMoreWxNews
{
    // 1.请求参数
//    NSString *str = @"萝莉";

//    NSString *str =self.searchBar.text;
//    str = @"萝莉";

    NSString *ss = [self.str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    ERLog(@"%@",ss);
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"453725eac531499e9de917cef50142a9";
    params[@"page"] = @(++self.currentPage);
    params[@"rows"] = @"5";
    params[@"keyword"] = ss;
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    
    [ERHttpTool GET:@"http://api.avatardata.cn/WxNews/Query" parameters:params success:^(id responseObject) {
        ERLog(@"%@",responseObject );

        NSArray *dictArray = responseObject[@"result"];
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            ERWxNews *wxNews = [ERWxNews wxNewsWithDict:dict];
            [modelArray addObject:wxNews];
        }
   
        [self.wxNewses addObjectsFromArray:modelArray];

        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        // 提醒用户
        [MBProgressHUD showError:@"加载失败,请重新加载"];
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];

}

// 加载更新数据（下拉的时候）
- (void)loadNewWxNews
{
    self.currentPage = 1;
    // 1.请求参数
    NSString *str = self.searchBar.text;
    str = (str.length) ? self.searchBar.text:@"萝莉";
    self.str = str;
    NSString *ss = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"453725eac531499e9de917cef50142a9";
    params[@"page"] = @(self.currentPage);
    params[@"rows"] = @"5";
    params[@"keyword"] = ss;

    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [ERHttpTool GET:@"http://api.avatardata.cn/WxNews/Query" parameters:params success:^(id responseObject) {
        ERLog(@"%@",responseObject);

        //字典数组转模型数组
        NSArray *dictArray = responseObject[@"result"];
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            ERWxNews *wxNews = [ERWxNews wxNewsWithDict:dict];
            [modelArray addObject:wxNews];
        }

        [self.wxNewses removeAllObjects];

        [self.wxNewses addObjectsFromArray:modelArray];

        [self.tableView reloadData];
        self.tableView.mj_footer.hidden = NO;
        [self.tableView.mj_header endRefreshing];
   
    } failure:^(NSError *error) {
        // 提醒用户
        [MBProgressHUD showError:@"加载失败,请重新加载"];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        self.tableView.mj_footer.hidden = YES;
    }];
    
}

// 监听搜索按钮的点击
- (void)btnClick
{
    if (self.searchBar.text == nil) return;
    // 1.请求数据
    [self loadNewWxNews];
    // 2.隐藏键盘
    [self.view endEditing:YES];
    
}

#pragma mark-- 键盘的代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.searchBar.text.length){
        [self loadNewWxNews];;
        [self.view endEditing:YES];
        return YES;
        
    }else{
        [self.view endEditing:YES];
        return YES;
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.wxNewses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERWxNewsCell *cell = [ERWxNewsCell cellWithTableView:tableView];
    
    cell.wxNews = self.wxNewses[indexPath.row];

    return cell;
}

/**
 *  返回每一行的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERWxNews *wx = self.wxNewses[indexPath.row];
    return wx.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERNewsDetailViewController *detailVc = [[ERNewsDetailViewController alloc] init];
    ERWxNews *wxNews = self.wxNewses[indexPath.row];
    detailVc.url = wxNews.url;
    [self.navigationController pushViewController:detailVc animated:YES];
}

@end
