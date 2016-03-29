//
//  ERDreamViewController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/16.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERDreamViewController.h"
#import "ERSearchBar.h"
#import "ERDream.h"
#import "ERDreamCell.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "ERHttpTool.h"

#define Margin 20

@interface ERDreamViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
/**  搜索栏 */
@property (nonatomic, weak) UIView *bgView;
/**  搜索栏 */
@property (nonatomic, weak) ERSearchBar *searchBar;
/**  搜索按钮 */
@property (nonatomic, weak) UIButton *btn;
/**  梦境解释内容 */
@property (nonatomic, weak) UITableView *explainTableView;
/** 梦的数据 */
@property (nonatomic, strong) NSMutableArray *dreams;

@end

@implementation ERDreamViewController
- (NSMutableArray *)dreams
{
    if (_dreams == nil) {
        _dreams = [NSMutableArray array];
    }
    return _dreams;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImage *oldImage = [UIImage imageNamed:@"jiemeng"];
//    
//    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, 0.0);
//    [oldImage drawInRect:self.view.bounds];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:newImage];
    self.view.backgroundColor = ERColor(178, 123, 43);
    self.title = @"周公解梦";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 添加子控件
    [self setupChildViews];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

/**
 *  点击了搜索按钮
 */
-(void)btnClick
{
    ERLog(@"点击了按钮");
    [self.view endEditing:YES];
    [self loadDreamExplain];
}
/**
 *  查询梦境解释
 */
- (void)loadDreamExplain
{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"d82028158453423787016e908612dfcc";
//    params[@"page"] = @1;
//    params[@"row"] = @20;
    params[@"keyword"] = self.searchBar.text;
    
    [ERHttpTool GET:@"http://api.avatardata.cn/ZhouGongJieMeng/LookUp" parameters:params success:^(id responseObject) {
        
        ERLog(@"%@",responseObject);
        
        NSArray *dreamArr = [ERDream objectArrayWithKeyValuesArray:responseObject[@"result"]];
        
        [self.dreams removeAllObjects];
        
        [self.dreams addObjectsFromArray:dreamArr];
        
        [self.explainTableView reloadData];
 
    } failure:^(NSError *error) {
        
        ERLog(@"%@",error);
        
    }];
    
}

/**
 *  添加子控件
 */
- (void)setupChildViews
{
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.width = 280;
    imageV.height = 120;
    imageV.x = (ScreenW - imageV.width) * 0.5;
    imageV.y = 64;
    imageV.image = [UIImage imageNamed:@"jiemeng_backgroung"];
    [self.view addSubview:imageV];
    
    ERSearchBar *searchBar =[[ERSearchBar alloc] init];
    searchBar.width = ScreenW - 100;
    searchBar.height = 2 * Margin;
    searchBar.x = Margin;
    searchBar.y = CGRectGetMaxY(imageV.frame);
    searchBar.delegate = self;
    searchBar.placeholder = @"请输入解梦关键词";
    [self.view addSubview:searchBar];
    self.searchBar = searchBar;
    
    UIButton *btn = [[UIButton alloc] init];
    btn.x = CGRectGetMaxX(searchBar.frame);
    btn.y = searchBar.y;
    btn.width = 3 * Margin;
    btn.height = searchBar.height ;
    [btn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, -5);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, CGRectGetMaxY(searchBar.frame), ScreenW, 40);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    label.text = @"梦境解释";
    label.textColor = ERColor(138, 45, 28);
    [self.view addSubview:label];
    
    UITableView *explainTableView = [[UITableView alloc] init];
    explainTableView.y = CGRectGetMaxY(label.frame);
    explainTableView.width = ScreenW;
    explainTableView.height = ScreenH - explainTableView.y;
    explainTableView.delegate = self;
    explainTableView.dataSource = self;
    explainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:explainTableView];
    self.explainTableView = explainTableView;
    self.explainTableView.backgroundColor = [UIColor clearColor];
    self.explainTableView.contentInset = UIEdgeInsetsMake(1, 0, 0, 0);

}


#pragma mark --dataSoure
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dreams.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    ERDreamCell *cell = [ERDreamCell cellWithTableView:self.explainTableView];
    cell.dream = self.dreams[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERDream *dream = self.dreams[indexPath.row];
    return dream.cellHeight;
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.searchBar.text.length){
        [self loadDreamExplain];
        [self.view endEditing:YES];
        return YES;
       
    }else{
        [self.view endEditing:YES];
        return YES;
    }
    
}
@end
