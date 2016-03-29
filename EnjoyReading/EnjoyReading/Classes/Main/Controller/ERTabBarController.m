//
//  ERTabBarController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/2/28.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERTabBarController.h"
#import "ERNewsViewController.h"
#import "ERMeViewController.h"
#import "ERCarefullyChoosenController.h"
#import "ERTabBar.h"
#import "ERNavigationController.h"
#import "ERAttentionViewController.h"

@interface ERTabBarController ()<ERTabBarDelegate>
@property (nonatomic, strong) NSMutableArray *items;

/**  新闻 */
@property (nonatomic, weak) ERNewsViewController *news;
/**  精选 */
@property (nonatomic, weak) ERCarefullyChoosenController *carefullyChoosen;
/**  关注 */
@property (nonatomic, weak) ERAttentionViewController *friendTrends;
/**  我 */
@property (nonatomic, weak) ERMeViewController *me;

@end

@implementation ERTabBarController
- (NSMutableArray *)items
{
    if (_items == nil) {
        _items =  [NSMutableArray array];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加子控制器
    [self setupAllChildViewController];
    
    // 自定义tabBar
    [self setUpTabBar];
    
}

#pragma mark - 设置tabBar
- (void)setUpTabBar
{
    // 自定义tabBar
    ERTabBar *tabBar = [[ERTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    
    // 设置代理
    tabBar.delegate = self;
    
    // 给tabBar传递tabBarItem模型
    tabBar.items = self.items;
    
    // 添加自定义tabBar
    [self.tabBar addSubview:tabBar];
    
}

#pragma mark - 当点击tabBar上的按钮调用
- (void)tabBar:(ERTabBar *)tabBar didClickButton:(NSInteger)index
{
    if (index == 0 && self.selectedIndex == index) { //点击了首页，刷新
//        [_news setupRefresh];
    }
    self.selectedIndex = index;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 移除系统的tabBarButton
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
}

/**
 *  添加子控制器
 */
- (void)setupAllChildViewController
{
    // 新闻
    ERNewsViewController *news = [[ERNewsViewController alloc] init];
    [self setUpOneChildViewController:news image:[UIImage imageNamed:@"tabBar_news_icon"] selectedImage:[UIImage imageWithOriginalName:@"tabBar_news_click_icon"] title:@"新闻"];
    _news = news;
    
    // 精选
    ERCarefullyChoosenController *carefullyChoosen = [[ERCarefullyChoosenController alloc] init];
    [self setUpOneChildViewController:carefullyChoosen image:[UIImage imageNamed:@"tabBar_carefullyChoosen_icon"] selectedImage:[UIImage imageWithOriginalName:@"tabBar_carefullyChoosen_click_icon"] title:@"精选"];
    _carefullyChoosen = carefullyChoosen;
    
//    // 关注
//    ERFriendTrendsViewController *friendTrends = [[ERFriendTrendsViewController alloc] init];
//    [self setUpOneChildViewController:friendTrends image:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selectedImage:[UIImage imageWithOriginalName:@"tabBar_friendTrends_click_icon"] title:@"关注"];
//    _friendTrends = friendTrends;
    
    // 关注
    ERAttentionViewController *friendTrends = [[ERAttentionViewController alloc] init];
    [self setUpOneChildViewController:friendTrends image:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selectedImage:[UIImage imageWithOriginalName:@"tabBar_friendTrends_click_icon"] title:@"关注"];
    _friendTrends = friendTrends;
    
    // 我
    ERMeViewController *me = [[ERMeViewController alloc] init];
    [self setUpOneChildViewController:me image:[UIImage imageNamed:@"tabBar_me_icon"] selectedImage:[UIImage imageWithOriginalName:@"tabBar_me_click_icon"] title:@"我"];
    _me = me;


}

#pragma mark--添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)childVc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    childVc.title = title;
    childVc.tabBarItem.image = image;
    childVc.tabBarItem.selectedImage = selectedImage;
//    childVc.view.backgroundColor = ERGlobalBackground;
    
    // 保存tabBarItem模型到数组
    [self.items addObject:childVc.tabBarItem];
    
    // 包装一个导航控制器
    ERNavigationController *nav = [[ERNavigationController alloc] initWithRootViewController:childVc];
        nav.title = title;
    [self addChildViewController:nav];
    
}

@end
