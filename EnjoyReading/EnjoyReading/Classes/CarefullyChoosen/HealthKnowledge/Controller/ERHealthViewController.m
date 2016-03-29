//
//  ERHealthViewController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/16.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHealthViewController.h"
#import "ERWaterflowView.h"
#import "ERWaterflowViewCell.h"
#import "ERHttpTool.h"
#import "ERHealthTypeCell.h"
#import "ERHealthType.h"
#import "ERHealthDetailController.h"

@interface ERHealthViewController ()<ERWaterflowViewDataSource,ERWaterflowViewDelegate>

/** 健康知识的种类 */
@property (nonatomic, strong) NSMutableArray *healthTypes;

@property (nonatomic, weak) ERWaterflowView *waterflowView;
@end

@implementation ERHealthViewController
- (NSMutableArray *)healthTypes
{
    if (_healthTypes == nil) {
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"healthType.plist" ofType:nil];
        NSMutableArray *healthTypeArr = [NSMutableArray array];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:filePath];
        for (NSDictionary *dict in dictArray) {
            ERHealthType *healthType = [ERHealthType healthTypeWithDict:dict];
            [healthTypeArr addObject:healthType];
        }
        _healthTypes = healthTypeArr;
    }
    return _healthTypes;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ERColor(245, 245, 245);
    
    self.title = @"健康知识分类";
    
    // 1.瀑布流控件
    ERWaterflowView *waterflowView = [[ERWaterflowView alloc] init];
//    waterflowView.backgroundColor = [UIColor redColor];
    // 跟随着父控件的尺寸而自动伸缩
    waterflowView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    waterflowView.frame = self.view.bounds;
    waterflowView.dataSource = self;
    waterflowView.delegate = self;
    [self.view addSubview:waterflowView];
    self.waterflowView = waterflowView;
}

#pragma mark - 数据源方法
- (NSUInteger)numberOfCellsInWaterflowView:(ERWaterflowView *)waterflowView
{
    return self.healthTypes.count;
}

- (ERWaterflowViewCell *)waterflowView:(ERWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index
{
    ERHealthTypeCell *cell = [ERHealthTypeCell cellWithWaterflowView:waterflowView];
    
    cell.healthType = self.healthTypes[index];
    
    return cell;
}

- (NSUInteger)numberOfColumnsInWaterflowView:(ERWaterflowView *)waterflowView
{
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        // 竖屏
        return 3;
    } else {
        return 5;
    }
}

#pragma mark - 代理方法
- (CGFloat)waterflowView:(ERWaterflowView *)waterflowView heightAtIndex:(NSUInteger)index
{
    ERHealthType *healthType = self.healthTypes[index];
    // 根据cell的宽度 和 图片的宽高比 算出 cell的高度
    return waterflowView.cellWidth * healthType.h / healthType.w;
}

- (void)waterflowView:(ERWaterflowView *)waterflowView didSelectAtIndex:(NSUInteger)index
{
    ERHealthType *healthType = self.healthTypes[index];
    ERHealthDetailController *detailVc = [[ERHealthDetailController alloc] init];
    detailVc.classify = healthType.uid;
    detailVc.title = healthType.name;
    [self.navigationController pushViewController:detailVc animated:YES];
    
}


@end
