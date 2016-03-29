//
//  ERHoroscopeController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/16.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHoroscopeController.h"
#import "ERHoroBgView.h"
#import "ERHoroscope.h"
#import "ERHoroDetailViewController.h"


@interface ERHoroscopeController ()<ERHoroBgViewDelegate>
/** 按钮的数组 */
@property (nonatomic, strong) NSMutableArray *btns;
/**  注释 */
@property (nonatomic, weak) ERHoroBgView *bgView;



@end

@implementation ERHoroscopeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"十二星座";
    UIImage *oldImage = [UIImage imageNamed:@"basicBack"];
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, 0.0);
    [oldImage drawInRect:self.view.bounds];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:newImage];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 64, ScreenW, ScreenH - 64);
    scrollView.contentSize = CGSizeMake(ScreenW, 600);
    scrollView.scrollEnabled = YES;
    [self.view addSubview:scrollView];
    
    
    // 添加星座控件
    ERHoroBgView *bgView = [[ERHoroBgView alloc] init];
    bgView.x = 0;
    bgView.y = 0;
    bgView.width = ScreenW;
    bgView.height = 600;
    bgView.delegate = self;
    [scrollView addSubview:bgView];
}

#pragma mark -- ERHoroBgViewDelegate代理方法
- (void)horoBgView:(ERHoroBgView *)horoBgView didSelectedButtonIndex:(NSInteger)index
{
    ERHoroDetailViewController *detailVc = [[ERHoroDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVc animated:YES];
    if (index == 0) {
        detailVc.consName = @"水瓶座";
    }else if (index == 1){
        detailVc.consName = @"双鱼座";
    }else if (index == 2){
        detailVc.consName = @"白羊座";
    }else if (index == 3){
        detailVc.consName = @"金牛座";
    }else if (index == 4){
        detailVc.consName = @"双子座";
    }else if (index == 5){
        detailVc.consName = @"巨蟹座";
    }else if (index == 6){
        detailVc.consName = @"狮子座";
    }else if (index == 7){
        detailVc.consName = @"处女座";
    }else if (index == 8){
        detailVc.consName = @"天秤座";
    }else if (index == 9){
        detailVc.consName = @"天蝎座";
    }else if (index == 10){
        detailVc.consName = @"射手座";
    }else{
        detailVc.consName = @"摩羯座";
    }
}

@end
