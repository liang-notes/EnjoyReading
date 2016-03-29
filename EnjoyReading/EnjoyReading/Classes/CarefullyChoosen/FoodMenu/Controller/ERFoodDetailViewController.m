//
//  ERFoodDetailViewController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/19.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERFoodDetailViewController.h"
#import "ERHttpTool.h"
#import "ERFoodDetailCell.h"
#import "ERFoodDetail.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+MJ.h"
#import "ERFoodMenuController.h"

@interface ERFoodDetailViewController ()<UIAlertViewDelegate>
/** 模型数组 */
@property (nonatomic, strong) NSMutableArray *foodDetails;
@property (nonatomic, weak) UIActivityIndicatorView *circle;
@end

@implementation ERFoodDetailViewController
-(NSMutableArray *)foodDetails
{
    if (_foodDetails == nil) {
        _foodDetails = [NSMutableArray array];
    }
    return _foodDetails;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ERColor(245, 245, 245);
    //    self.view.backgroundColor = [UIColor grayColor];
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIActivityIndicatorView *circle = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    circle.centerX = 0.5 * ScreenW;
    circle.centerY = 0.5 * ScreenH;
    [self.view addSubview:circle];
    self.circle = circle;
    [self.circle startAnimating];

    self.title = self.name;
    [self loadfoodDetail];

}

// 点击了返回之后要做的事
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;
{
    ERFoodMenuController *foodMenu = [[ERFoodMenuController alloc] init];
    [self.navigationController pushViewController:foodMenu animated:YES];
    ERLog(@"alertView");
}

- (void)loadfoodDetail
{

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"key"] = @"1e056f27a4af46a89834a8a52eb1964a";
    param[@"name"] = self.name;
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [ERHttpTool GET:@"http://api.avatardata.cn/Cook/Name" parameters:param success:^(id responseObject) {
        ERLog(@"%@",responseObject);
        NSArray *dictArray = responseObject[@"result"];
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            ERFoodDetail *foodDetail = [ERFoodDetail foodDetailWithDict:dict];
            [modelArray addObject:foodDetail];
        }
        [self.foodDetails addObjectsFromArray:modelArray];
        
        if (self.foodDetails.count > 0) {
            
            [self.tableView reloadData];
            [self.circle stopAnimating];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"此菜做法有待您来创造" message:nil delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
            [self.view addSubview:alert];
            [alert show];
        }

        
    } failure:^(NSError *error) {
        ERLog(@"eee%@",error);
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.foodDetails.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ERFoodDetailCell *cell = [ERFoodDetailCell cellWithTableView:tableView];
    
    ERFoodDetail *h = self.foodDetails[indexPath.row];
    cell.foodDetail = h;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERFoodDetail *h = self.foodDetails[indexPath.row];
    return h.cellHeight;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

@end
