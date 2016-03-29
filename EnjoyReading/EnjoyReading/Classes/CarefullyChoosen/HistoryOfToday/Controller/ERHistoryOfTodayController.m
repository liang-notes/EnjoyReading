//
//  ERHistoryOfTodayController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/9.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHistoryOfTodayController.h"
#import "ERHistory.h"
#import "ERHistoryCell.h"
#import "MJExtension.h"
#import "ERHttpTool.h"
#import "ERPopMenu.h"
#import "ERParam.h"
#import "MBProgressHUD+MJ.h"

@interface ERHistoryOfTodayController ()<ERPopMenuDelegate,UITextFieldDelegate,UIPickerViewDelegate>

/** 所有历史事件 */
@property (nonatomic, strong) NSMutableArray *histories;

/** 时间选择器 */
@property (nonatomic, weak) UIDatePicker *datePickView;
/** 中间标题 */
@property (nonatomic, weak) UITextField *dateChoose;
@property (nonatomic, weak) ERPopMenu *menu;

/** 参数 */
@property (nonatomic, strong) ERParam *param;

@end

@implementation ERHistoryOfTodayController
- (NSMutableArray *)histories
{
    if (_histories == nil) {
        _histories = [NSMutableArray array];
    }
    return _histories;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = ERColor(245, 245, 245);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置导航栏的内容
    [self setupNavBar];

    // 加载数据
    [self loadNewHistory];
    
}

- (void)setupNavBar
{
    // 设置导航栏中间显示
    UITextField *dateChoose = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 35)];
//    dateChoose.backgroundColor = [UIColor redColor];
    self.dateChoose = dateChoose;
    self.dateChoose.delegate = self;
    self.navigationItem.titleView = dateChoose;
    
    // 日期格式转换
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSString *now = [format stringFromDate:[NSDate date]];
    self.dateChoose.text = now;

    
    // 设置导航栏右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"MainTagSubIcon" highImageName:@"MainTagSubIconClick" target:self action:@selector(titleClick:)];
}

#pragma mark -- <UITextFieldDelegate>
// 是否允许开始编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    return NO;
}
#pragma mark - 私有方法
// 按钮的点击
- (void)titleClick:(UIButton *)rigthButton
{
    ERLog(@"sss");


    UIDatePicker *datePickView = [[UIDatePicker alloc] init];
    self.datePickView = datePickView;
    datePickView.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    datePickView.datePickerMode = UIDatePickerModeDate;
    datePickView.backgroundColor = ERColor(240, 240, 240);
    
    ERPopMenu *menu = [[ERPopMenu alloc ] initWithContentView:datePickView];
    menu.delegate = self;
    menu.arrowPosition = ERPopMenuArrowPositionRight;
    menu.dimBackground = YES;
    [menu showInRect:CGRectMake(0, 64, self.view.bounds.size.width, 200)];

    // 监听UIDatePicker的滚动
    [datePickView addTarget:self action:@selector(datechange:) forControlEvents:UIControlEventValueChanged];

}

- (void)datechange:(UIDatePicker *)datepicker
{
    // 日期格式转换
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [format stringFromDate:datepicker.date];
    self.dateChoose.text = dateStr;
    
}

#pragma mark --popMenu代理方法
- (void)popMenuDidDismissed:(ERPopMenu *)popMenu
{
    
    [self loadNewHistory];
}


- (void)loadNewHistory
{

    [MBProgressHUD showMessage:@"正在加载历史数据..."];
    [MBProgressHUD hideHUD];
    
    ERParam *params = [[ERParam alloc] init];
    params.key = @"fc61c118533942efa20fa52bece7fa4b";
    params.yue = self.dateChoose.text;
    params.ri = self.dateChoose.text;
    params.type = @"2";
    params.row = @"10";
    
    [ERHttpTool GET:@"http://api.avatardata.cn/HistoryToday/LookUp" parameters:params.keyValues success:^(id responseObject) {
        
        ERLog(@"%@",responseObject);
        NSArray *historyArr = [ERHistory objectArrayWithKeyValuesArray:responseObject[@"result"]];
        [self.histories removeAllObjects];
        [self.histories addObjectsFromArray:historyArr];

        [self.tableView reloadData];
    
        
    } failure:^(NSError *error) {
        ERLog(@"%@",error);
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.histories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ERHistoryCell *cell = [ERHistoryCell cellWithTableView:tableView];
    
    cell.history = self.histories[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERHistory *history = self.histories[indexPath.row];
    return history.cellHeight;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

@end
