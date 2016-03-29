//
//  ERPopularNovelController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/15.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERPopularNovelController.h"
#import "ERHttpTool.h"
#import "ERPageBook.h"
#import "ERPageBookCell.h"
#import "MJExtension.h"

@interface ERPopularNovelController ()

/** 模型数组 */
@property (nonatomic, strong) NSArray *pageBooks;

@end

@implementation ERPopularNovelController
- (NSArray *)pageBooks
{
    if (_pageBooks == nil) {

        _pageBooks = [NSMutableArray array];

    }
    return _pageBooks;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ERColor(245, 245, 245);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = self.name;

    [self loadNovel];

}

- (void)loadNovel
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"fbda8f905cab48e99ff82b9f019a3912";
    params[@"id"] = self.idstr;

    [ERHttpTool GET:@"http://api.avatardata.cn/Book/Show" parameters:params success:^(id responseObject) {
        ERLog(@"请求成功---%@",responseObject);
        NSDictionary *dict = responseObject[@"result"];
        
        NSArray *pageBooks = [ERPageBook objectArrayWithKeyValuesArray:dict[@"list"]];
        
        NSMutableArray *array = [pageBooks mutableCopy];
        
        for (int i = 0; i<array.count/2.0; i++) {
            
            [array exchangeObjectAtIndex:i withObjectAtIndex:array.count-1-i];
            
        }
        
//        for (int i = 0; i < array.count; i++) {
//            ERPageBook *book = [[ERPageBook alloc] init];
//            book.title = [array[i] title];
//            book.id = [array[i] id];
//            book.message = [array[i] message];
//            [book save];
//        }
        
        self.pageBooks = array;
        
        [self.tableView reloadData];
        

        
        
    } failure:^(NSError *error) {
        ERLog(@"请求失败---%@",error);
        
    }];

}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.pageBooks.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ERPageBookCell *cell = [ERPageBookCell cellWithTableView:tableView];
    cell.pageBook = self.pageBooks[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ERPageBook *cc = self.pageBooks[indexPath.row];
    return cc.cellHeight;
}


@end
