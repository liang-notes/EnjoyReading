//
//  ERFoodMenuController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/17.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERFoodMenuController.h"
#import "ERFoodListFrame.h"
#import "ERFoodList.h"
#import "ERFoodListCell.h"
#import "MJRefresh.h"
#import "ERHttpTool.h"
#import "ERPopMenu.h"
#import "ERSearchBar.h"
#import "ERFoodDetailViewController.h"
#import "MBProgressHUD+MJ.h"

@interface ERFoodMenuController ()<ERPopMenuDelegate,UITextFieldDelegate>
/** VM模型数组 */
@property (nonatomic, strong) NSMutableArray *foodListFrames;

/**  当前页码 */
@property (nonatomic, assign) NSInteger currentPage;

/** 搜索栏 */
@property (nonatomic, strong) ERSearchBar *seachBar;

/** 弹出菜单 */
@property (nonatomic, strong) ERPopMenu *popMenu;

/**  总数 */
@property (nonatomic, assign) NSInteger totalNumber;

@end

@implementation ERFoodMenuController

- (NSMutableArray *)foodListFrames
{
    if (_foodListFrames == nil) {
        _foodListFrames = [NSMutableArray array];
    }
    return _foodListFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ERColor(245, 245, 245);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"营养菜谱列表";
    
    // 设置导航栏右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" highImageName:@"MainTagSubIconClick" target:self action:@selector(titleClick:)];
    [MBProgressHUD showMessage:@"正在拼命加载您喜欢的内容..."];
    // 添加刷新控件
    [self setupRefresh];
    self.tableView.mj_footer.hidden = YES;

    [MBProgressHUD hideHUD];
    // 自动刷新
    [self.tableView.mj_header beginRefreshing];
    
}

#pragma mark - 私有方法
// 按钮的点击
- (void)titleClick:(UIButton *)rigthButton
{
    ERLog(@"sss");
    
    ERSearchBar *searchBar = [[ERSearchBar alloc] init];
    searchBar.width = 200;
    searchBar.height = 40;
    searchBar.placeholder = @"请输入您喜欢的菜名...";
    self.seachBar = searchBar;
    searchBar.delegate = self;
    
    ERPopMenu *menu = [[ERPopMenu alloc ] initWithContentView:self.seachBar];
    menu.delegate = self;
    menu.arrowPosition = ERPopMenuArrowPositionRight;
    menu.dimBackground = YES;
    [menu showInRect:CGRectMake(0, 64, self.view.bounds.size.width, 60)];
    self.popMenu = menu;

}

/**
 *  弹出菜单消失的时候要做的事情
 */
- (void)popMenuDidDismissed:(ERPopMenu *)popMenu
{
    NSString *ss = self.seachBar.text;
    if (ss.length){;
    ERFoodDetailViewController *detailVc = [[ERFoodDetailViewController alloc] init];
    detailVc.name = ss;
    [self.navigationController pushViewController:detailVc animated:YES];
    }
    return;
}

#pragma mark-- 键盘的代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.popMenu dismiss];
    [self.view endEditing:YES];
    return YES;
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFoodLists)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreFoodLists)];
}

#pragma mark-- 加载数据
- (void)loadMoreFoodLists
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"1e056f27a4af46a89834a8a52eb1964a";
    params[@"page"] = @(++self.currentPage);
    params[@"rows"] = @5;
    
    [ERHttpTool GET:@"http://api.avatardata.cn/Cook/List" parameters:params success:^(id responseObject) {
        ERLog(@"%@",responseObject);
        // 字典数组
        NSArray *dictArray = responseObject[@"result"];
        NSMutableArray *foodListFrameArr = [NSMutableArray array];
        
        //字典转模型数组
        for (NSDictionary *dict in dictArray) {
            ERFoodListFrame *foodListFrame = [[ERFoodListFrame alloc] init];
            ERFoodList *foodList = [ERFoodList foodListWithDict:dict];
            foodListFrame.foodList = foodList;
            [foodListFrameArr addObject:foodListFrame];
        }
 
        [self.foodListFrames addObjectsFromArray:foodListFrameArr];
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
        // 每次刷新右边数据时, 都控制footer显示或者隐藏
        self.tableView.mj_footer.hidden = (self.foodListFrames.count == 0);
        // 让底部控件结束刷新
        if (self.foodListFrames.count == self.totalNumber) { // 全部数据已经加载完毕
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
- (void)loadFoodLists
{
    self.currentPage = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"1e056f27a4af46a89834a8a52eb1964a";
    params[@"page"] = @(self.currentPage);
    params[@"rows"] = @5;
    
    [ERHttpTool GET:@"http://api.avatardata.cn/Cook/List" parameters:params success:^(id responseObject) {
        ERLog(@"%@",responseObject);
        // 字典数组
        NSArray *dictArray = responseObject[@"result"];
        NSMutableArray *foodListFrameArr = [NSMutableArray array];
        
        // 记录总数
        self.totalNumber = [responseObject[@"total"] integerValue];
        //字典转模型数组
        for (NSDictionary *dict in dictArray) {
            ERFoodListFrame *foodListFrame = [[ERFoodListFrame alloc] init];
            ERFoodList *foodList = [ERFoodList foodListWithDict:dict];
            foodListFrame.foodList = foodList;
            [foodListFrameArr addObject:foodListFrame];
        }
        
        [self.foodListFrames removeAllObjects];
        [self.foodListFrames addObjectsFromArray:foodListFrameArr];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        // 每次刷新右边数据时, 都控制footer显示或者隐藏
        self.tableView.mj_footer.hidden = (self.foodListFrames.count == 0);
        // 让底部控件结束刷新
        if (self.foodListFrames.count == self.totalNumber) { // 全部数据已经加载完毕
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


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.foodListFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ERFoodListCell *cell = [ERFoodListCell cellWithTableView:tableView];
    
    ERFoodListFrame *foodListF = self.foodListFrames[indexPath.row];
    cell.foodListFrame = foodListF;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERFoodListFrame *foodListF = self.foodListFrames[indexPath.row];
    return foodListF.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERFoodListFrame *foodListF = self.foodListFrames[indexPath.row];
    ERFoodDetailViewController *detailVc = [[ERFoodDetailViewController alloc] init];
    detailVc.name = foodListF.foodList.name;
    [self.navigationController pushViewController:detailVc animated:YES];
}

@end
