//
//  ERCarefullyChoosenController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/6.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERCarefullyChoosenController.h"
#import "ERNews.h"
#import "ERNewsCell.h"
#import "ERItemsView.h"
#import "ERWeChatChoosenViewController.h"
#import "ERJokesViewController.h"
#import "ERHistoryOfTodayController.h"
#import "ERBookListViewController.h"
#import "ERHealthViewController.h"
#import "ERDreamViewController.h"
#import "ERHoroscopeController.h"
#import "ERFoodMenuController.h"


//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"

#define ERMargin 10
#define ERMaxSections 100
#define ERCellIdentifier @"news"
@interface ERCarefullyChoosenController ()<UICollectionViewDataSource,UICollectionViewDelegate,ERItemsViewDelegate>

/** 存放新闻模型 */
@property (nonatomic, strong) NSArray *newses;
@property (weak, nonatomic) UICollectionView *collectionView;
@property (nonatomic, weak) ERItemsView *itemsView;
@property (nonatomic, weak) UILabel *titleLabel;
@end

@implementation ERCarefullyChoosenController

- (NSArray *)newses
{
    if (_newses == nil) {
        // 加载plist文件
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"newses.plist" ofType:nil];
        NSArray *dictArrary = [NSArray arrayWithContentsOfFile:filePath];
        NSMutableArray *newsArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArrary) {
            ERNews *news = [ERNews newsWithDict:dict];
            [newsArray addObject:news];
        }
        _newses = newsArray;
    }
    return _newses;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.text = @"精选话题";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.frame = CGRectMake(0, 0, 80, 30);
    self.navigationItem.titleView = titleLabel;

    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置背景颜色
    self.view.backgroundColor = ERGlobalBackground;
    
    // 添加所有子控件
    [self setupAllChildViews];

}

#pragma mark --初始化所有子控件
- (void)setupAllChildViews
{
    // 添加轮播图
    [self setupLunBocollectionView];
    
    // 添加标签
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"生活频道";
    titleLabel.font = [UIFont systemFontOfSize:16];
//    titleLabel.textColor = [UIColor blueColor];

    [self.view addSubview:titleLabel];
    // 添加标签约束
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(ERMargin);
        make.right.equalTo(self.view.right).offset(-ERMargin);
        make.height.equalTo(30);
        make.top.equalTo(self.collectionView.bottom);
    }];
    
    // 添加标签下面的内容
    ERItemsView *itemsView = [[ERItemsView alloc] init];
    itemsView.delegate = self;
    [self.view addSubview:itemsView];
    self.itemsView = itemsView;
    
    // 添加约束
    [itemsView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(ERMargin);
        make.right.equalTo(self.view.right).offset(-ERMargin);
        make.bottom.equalTo(self.view.bottom).offset(-ERMargin);
        make.top.equalTo(titleLabel.bottom).offset(-2*ERMargin);

    }];
}

#pragma mark -- WLLeftMenu的代理
- (void)itemsView:(ERItemsView *)menu didSelectedButtonIndex:(NSInteger)index
{

    if (index == 0) {
        ERLog(@"点击了历史上的今天");
        ERHistoryOfTodayController *historyVc = [[ERHistoryOfTodayController alloc] init];
        [self.navigationController pushViewController:historyVc animated:YES];

    }else if(index == 1){
        ERLog(@"点击了微信精选");
        ERWeChatChoosenViewController *chat = [[ERWeChatChoosenViewController alloc] init];
        [self.navigationController pushViewController:chat animated:YES];
        
    }else if(index == 2){
        ERLog(@"点击了幽默段子");
        ERJokesViewController *jokeVc = [[ERJokesViewController alloc] init];
        [self.navigationController pushViewController:jokeVc animated:YES];
        
    }else if(index == 3){
        ERLog(@"点击了热门小说");
        ERBookListViewController *bookVc = [[ERBookListViewController alloc] init];
        [self.navigationController pushViewController:bookVc animated:YES];

    }else if(index == 4){
        ERLog(@"点击了健康常识");
        
        ERHealthViewController *healthVc = [[ERHealthViewController alloc] init];
        [self.navigationController pushViewController:healthVc animated:YES];
    }else if(index == 5){
        ERLog(@"点击了营养菜谱");
        ERFoodMenuController *foodVc = [[ERFoodMenuController alloc] init];
        [self.navigationController pushViewController:foodVc animated:YES];
    }else if(index == 6){
        ERLog(@"点击了周公解梦");
        ERDreamViewController *dreamVc = [[ERDreamViewController alloc] init];
        [self.navigationController pushViewController:dreamVc animated:YES];

    }else if(index == 7){
        ERLog(@"点击了星座运势");
        ERHoroscopeController *horoscopeVc = [[ERHoroscopeController alloc] init];
        [self.navigationController pushViewController:horoscopeVc animated:YES];
    }
}


#pragma mark -- 添加轮播图
- (void)setupLunBocollectionView
{
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat collectionViewW = screenW - 2 * ERMargin;
    CGFloat collectionViewH = 130;
    CGFloat collectionViewX = (screenW - collectionViewW) * 0.5;
    CGFloat collectionViewY = 64 + ERMargin;
    
    // 添加轮播图
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(collectionViewW, collectionViewH);

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(collectionViewX, collectionViewY, collectionViewW, collectionViewH) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor blueColor];
    
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    // 添加约束
    [collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(ERMargin);
        make.right.equalTo(self.view.right).offset(-ERMargin);
        make.height.equalTo(130);
        make.top.equalTo(self.view.top).offset(ERMargin + 64);
    }];
    
    // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"ERNewsCell" bundle:nil] forCellWithReuseIdentifier:ERCellIdentifier];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:ERMaxSections/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];

}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.newses.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return ERMaxSections;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ERNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ERCellIdentifier forIndexPath:indexPath];

    cell.news = self.newses[indexPath.item];

    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake(300, 130);
//}

@end
