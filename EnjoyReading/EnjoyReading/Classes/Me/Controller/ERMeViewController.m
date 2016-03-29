//
//  ERMeViewController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/2/28.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERMeViewController.h"
#import "ERGroup.h"
#import "ERArrowItem.h"
#import "ERSwichItem.h"
#import "ERLabelItem.h"
#import "ERMineItem.h"
#import "ERMineCell.h"
#import "ERSettingController.h"
#import "ERMessageController.h"
#import "ERCollectController.h"
#import "ERNewsPushController.h"

@interface ERMeViewController ()
/** groups */
@property (nonatomic, strong) NSMutableArray *groups;
/**  登录按钮 */
@property (nonatomic, weak) UIButton *loginBtn;

//@property (nonatomic, weak) UIView *nightModeView;
// 开关状态
@property (nonatomic, strong) ERSwichItem *state;

@end

@implementation ERMeViewController
- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
        
    }
    return _groups;
    
}
//* 屏蔽tableView的样式 
- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.text = @"我";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.frame = CGRectMake(0, 0, 80, 30);
    self.navigationItem.titleView = titleLabel;

    // 设置tableView属性
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionFooterHeight = NewsCellMargin;
    self.tableView.sectionHeaderHeight = 0;
    self.view.backgroundColor = ERColor(245, 245, 245);
    
//    UIButton *loginBtn = [[UIButton alloc] init];
//    loginBtn.frame = CGRectMake(0, 0, ScreenW, 150);
//    [loginBtn setBackgroundColor:ERColor(78, 123, 177)];
//    [loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
//    self.loginBtn = loginBtn;
//    self.tableView.tableHeaderView = loginBtn;

    // 初始化模型数据
    [self setupGroup];

//    // 注册通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupNightMode) name:@"NIGHT" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NIGHT" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupNightMode
{
    // 夜间模式
    UIView *nightModeView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    nightModeView.backgroundColor = [UIColor blackColor];
    nightModeView.alpha = 0.5;
    nightModeView.userInteractionEnabled = NO;
    [self.view addSubview:nightModeView];
}

/**
 *  初始化模型数据
 */
- (void)setupGroup
{
    [self setupGroup0];
    [self setupGroup1];
}

- (void)setupGroup0
{
    // 1.创建组
    ERGroup *group0 = [ERGroup group];
    [self.groups addObject:group0];
    
    // 2.设置组的所有行数据
    ERArrowItem *myNote = [ERArrowItem itemWithTitle:@"我的消息" icon:@"message_icon"];
    myNote.destVcClass = [ERMessageController class];
    
    ERArrowItem *mycollect = [ERArrowItem itemWithTitle:@"我的收藏" icon:@"collect"];
    mycollect.destVcClass = [ERCollectController class];
    
    ERArrowItem *news = [ERArrowItem itemWithTitle:@"新闻推送"icon:@"hot_status"];
    news.destVcClass = [ERNewsPushController class];
    group0.items = @[myNote,mycollect,news];
  
}

- (void)setupGroup1
{
    // 1.创建组
    ERGroup *group1 = [ERGroup group];
    [self.groups addObject:group1];
    
//    // 2.设置组的所有行数据
//    ERSwichItem *state = [ERSwichItem itemWithTitle:@"夜间模式" icon:@"mine-sun-icon"];
//    self.state = state;
//    state.operation = ^{
////        self.state.mode = YES;
//    // 发出通知
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"NIGHT" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NIGHT" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    };

//    ERArrowItem *download = [ERArrowItem itemWithTitle:@"离线下载" icon:@"download"];
    ERArrowItem *set = [ERArrowItem itemWithTitle:@"设置" icon:@"setting-icon"];
    set.destVcClass = [ERSettingController class];

    group1.items = @[ set];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    ERGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERMineCell *cell = [ERMineCell cellWithTableView:tableView];
    ERGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    // 设置cell所处的行号 和 所处组的总行数
    [cell setIndexPath:indexPath rowsInSection:group.items.count];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    ERGroup *group = self.groups[section];
    return group.footer;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ERGroup *group = self.groups[section];
    return group.header;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取出这行对应的item模型
    ERGroup *group = self.groups[indexPath.section];
    ERMineItem *item = group.items[indexPath.row];
    
    // 2.判断有无需要跳转的控制器
    if (item.destVcClass) {
        UIViewController *destVc = [[item.destVcClass alloc] init];
        destVc.title = item.title;
        [self.navigationController pushViewController:destVc animated:YES];
    }
    
    // 3.判断有无想执行的操作
    if (item.operation) {
        item.operation();
    }
}

@end
