//
//  ERHotNewsDetailViewController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/22.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHotNewsDetailViewController.h"
#import "ERHttpTool.h"
#import "ERHotNewsDetail.h"
#import "ERHotNewsDetailCell.h"

@interface ERHotNewsDetailViewController ()
/** 模型 */
@property (nonatomic, strong) NSMutableArray *hotNewsDetails;
@end

@implementation ERHotNewsDetailViewController
- (NSMutableArray *)hotNewsDetails
{
    if (_hotNewsDetails == nil) {
        _hotNewsDetails = [NSMutableArray array];
    }
    return _hotNewsDetails;
}
- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = ERColor(245, 245, 245);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    [self loadDetail];
}

#pragma mark--加载分类数据
- (void)loadDetail
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"b4ef58c687c44c249309a27758225acf";
    params[@"id"] = self.id;
    
    [ERHttpTool GET:@"http://api.avatardata.cn/Top/Show" parameters:params success:^(id responseObject) {
        ERLog(@"%@",responseObject[@"result"]);
        
        ERHotNewsDetail *hotNewsDetail = [ERHotNewsDetail hotNewsDetailWithDict:responseObject[@"result"]];
        [self.hotNewsDetails addObject:hotNewsDetail];
        
        [self.tableView reloadData];

        
    } failure:^(NSError *error) {
        ERLog(@"%@",error);
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.hotNewsDetails.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ERHotNewsDetailCell *cell = [ERHotNewsDetailCell cellWithTableView:tableView];
    cell.hotNewsDetail = self.hotNewsDetails[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERHotNewsDetail *cc = self.hotNewsDetails[indexPath.row];
    return cc.cellHeight;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
