//
//  ERCollectController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/14.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERCollectController.h"
#import "ERCollectionCell.h"
#import "ERHotNews.h"
#import "ERNewsDetailViewController.h"
#import "LHDB.h"


@interface ERCollectController ()
/** 模型数组 */
@property (nonatomic, strong) NSMutableArray *models;
/** imageView */
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation ERCollectController

- (NSMutableArray *)models
{
    if (_models == nil) {
        _models = [NSMutableArray array];
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = ERColor(245, 245, 245);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;



    NSArray* selectArray = [ERHotNews selectWithPredicate:nil];
    ERLog(@"selectArray = %@",selectArray);
    [self.models addObjectsFromArray:selectArray];


    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.width = 300;
    imageView.height = 300;
    imageView.x = (ScreenW - imageView.size.width) * 0.5;
    imageView.y = 64;
    imageView.image = [UIImage imageNamed:@"mine-collectview"];
    [self.view addSubview:imageView];
    self.imageView = imageView;
    if (self.models.count) {
        self.imageView.hidden = YES;
    }else{
        self.imageView.hidden = NO;
    }
    
//    ERHotNews *h = [ERNewsTool hotNews];
//    [self.models addObject:h]; 
}


#pragma mark ---数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERCollectionCell *cell = [ERCollectionCell cellWithTableView:tableView];
    cell.hotNews = self.models[indexPath.row];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERHotNews *ha = self.models[indexPath.row];
    return ha.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERNewsDetailViewController *detailVc = [[ERNewsDetailViewController alloc] init];
    ERHotNews *ss = self.models[indexPath.row];
    detailVc.url = ss.fromurl;
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {  // 点击了“删除”

        //删除数据
        [ERHotNews deleteWithPredicate:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteCollect" object:nil];
        
        // 删除模型
        [self.models removeObjectAtIndex:indexPath.row];

        // 刷新表格
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];

    } else if (editingStyle == UITableViewCellEditingStyleInsert) { // 点击了+
        ERLog(@"+++++ %zd", indexPath.row);
    }
}

@end
