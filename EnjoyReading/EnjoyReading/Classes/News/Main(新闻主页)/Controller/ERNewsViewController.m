//
//  ERNewsViewController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/2/28.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERNewsViewController.h"
#import "ERNationalNewsController.h"
#import "ERInterNationalNewsViewController.h"
#import "ERAgricultureNewsViewController.h"
#import "ERCurrentNewsViewController.h"
#import "ERSportsNewsViewController.h"
#import "ERTechnologyNewsViewController.h"
#import "ERTravelNewsViewController.h"
#import "ERNewsLabel.h"
#import "ERConst.h"


@interface ERNewsViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic)  UIScrollView *titleScrollView;
@property (weak, nonatomic)  UIScrollView *contentScrollView;
@end

@implementation ERNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ERGlobalBackground;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置导航栏
    [self setupNavBar];
    
    // 添加子控制器
    [self setupChildVc];
    
    // 添加子控件
    [self setupChildView];
    
}

/**
 *  设置导航栏
 */
- (void)setupNavBar
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.text = @"新闻频道";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.frame = CGRectMake(0, 0, 80, 30);
    self.navigationItem.titleView = titleLabel;
}

/**
 *  添加子控制器
 */
- (void)setupChildVc
{
    
    ERCurrentNewsViewController *currentNews = [[ERCurrentNewsViewController alloc] init];
    currentNews.title = @"时事";
    [self addChildViewController:currentNews];
    
    ERNationalNewsController *nationalNews = [[ERNationalNewsController alloc] init];
    nationalNews.title = @"国内";
    [self addChildViewController:nationalNews];

    
    ERInterNationalNewsViewController *interNationalNews = [[ERInterNationalNewsViewController alloc] init];
    interNationalNews.title = @"国际";
    [self addChildViewController:interNationalNews];
    
    ERTechnologyNewsViewController *technologyNews = [[ERTechnologyNewsViewController alloc] init];
    technologyNews.title = @"科技";
    [self addChildViewController:technologyNews];
    
    ERSportsNewsViewController *sportsNews = [[ERSportsNewsViewController alloc] init];
    sportsNews.title = @"体育";
    [self addChildViewController:sportsNews];
    
    ERTravelNewsViewController *travelNews = [[ERTravelNewsViewController alloc] init];
    travelNews.title = @"旅游";
    [self addChildViewController:travelNews];
    
    ERAgricultureNewsViewController *agricultureNews = [[ERAgricultureNewsViewController alloc] init];
    agricultureNews.title = @"奇闻";
    [self addChildViewController:agricultureNews];
    
}

/**
 *  添加子控件
 */
- (void)setupChildView
{
    UIScrollView *titleScrollView = [[UIScrollView alloc] init];
    titleScrollView.showsHorizontalScrollIndicator = NO;
    titleScrollView.showsVerticalScrollIndicator = NO;
    titleScrollView.width = ScreenW;
    titleScrollView.height = 35;
    titleScrollView.y = 64;
    titleScrollView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    [self.view addSubview:titleScrollView];
    self.titleScrollView = titleScrollView;
    
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    contentScrollView.y = titleScrollView.y + titleScrollView.height;
    contentScrollView.width = ScreenW;
    contentScrollView.height = ScreenH - contentScrollView.y;
    contentScrollView.pagingEnabled = YES;
    [self.view addSubview:contentScrollView];
    
    self.contentScrollView = contentScrollView;
    self.contentScrollView.delegate = self;

    // 添加标题
    [self setupTitle];
    
    // 默认显示第0个子控制器
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

/**
 *  添加标题
 */
- (void)setupTitle
{
    CGFloat labelY = 0;
    CGFloat labelW = 80;
    CGFloat labelH = self.titleScrollView.frame.size.height;
    NSInteger count = 7;
    
    // 添加label
    for (NSInteger i = 0; i < count; i++) {
        ERNewsLabel *label = [[ERNewsLabel alloc] init];
        label.text = [self.childViewControllers[i] title] ;
        CGFloat labelX = i * labelW;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        // 添加手势监听
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        label.tag = i;
        [self.titleScrollView addSubview:label];
        
        if (i == 0) { // 最前面的label
            label.scale = 1.0;
        }
    }
    
    // 设置滚动范围contentSize
    self.titleScrollView.contentSize = CGSizeMake(count * labelW, 0);
    self.contentScrollView.contentSize = CGSizeMake(count * [UIScreen mainScreen].bounds.size.width, 0);
}

/**
 *  监听顶部label的点击
 */
- (void)labelClick:(UITapGestureRecognizer *)tap
{
    // 取出被点击label的索引
    NSInteger index = tap.view.tag;
    
    // 让底部的内容scrollView滚动到对应位置
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = index * self.contentScrollView.frame.size.width;
    [self.contentScrollView setContentOffset:offset animated:YES];
}
#pragma mark - <UIScrollViewDelegate>
/**
 * scrollView结束了滚动动画以后就会调用这个方法（比如- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;方法执行的动画完毕后）
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 一些临时变量
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 当前位置需要显示的控制器的索引
    NSInteger index = offsetX / width;
    
    // 让对应的顶部标题居中显示
    ERNewsLabel *label = self.titleScrollView.subviews[index];
    CGPoint titleOffset = self.titleScrollView.contentOffset;
    titleOffset.x = label.center.x - width * 0.5;
    // 左边超出处理
    if (titleOffset.x < 0) titleOffset.x = 0;
    // 右边超出处理
    CGFloat maxTitleOffsetX = self.titleScrollView.contentSize.width - width;
    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    
    [self.titleScrollView setContentOffset:titleOffset animated:YES];
    
    // 让其他label回到最初的状态
    for (ERNewsLabel *otherLabel in self.titleScrollView.subviews) {
        if (otherLabel != label) otherLabel.scale = 0.0;
    }
    
    // 取出需要显示的控制器
    UIViewController *willShowVc = self.childViewControllers[index];
    
    // 如果当前位置的位置已经显示过了，就直接返回
    if ([willShowVc isViewLoaded]) return;
    
    // 添加控制器的view到contentScrollView中;
    willShowVc.view.frame = CGRectMake(offsetX, 0, width, height);
    [scrollView addSubview:willShowVc.view];
}

/**
 * 手指松开scrollView后，scrollView停止减速完毕就会调用这个
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    ERLog(@"scrollViewDidEndDecelerating");
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/**
 * 只要scrollView在滚动，就会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (scale < 0 || scale > self.titleScrollView.subviews.count - 1) return;
    
    // 获得需要操作的左边label
    NSInteger leftIndex = scale;
    ERNewsLabel *leftLabel = self.titleScrollView.subviews[leftIndex];
    
    // 获得需要操作的右边label
    NSInteger rightIndex = leftIndex + 1;
    ERNewsLabel *rightLabel = (rightIndex == self.titleScrollView.subviews.count) ? nil : self.titleScrollView.subviews[rightIndex];
    
    // 右边比例
    CGFloat rightScale = scale - leftIndex;
    // 左边比例
    CGFloat leftScale = 1 - rightScale;
    
    // 设置label的比例
    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;
}

@end
