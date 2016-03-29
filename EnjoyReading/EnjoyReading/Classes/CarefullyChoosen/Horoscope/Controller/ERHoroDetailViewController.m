//
//  ERHoroDetailViewController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/16.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERHoroDetailViewController.h"
#import "PDColoredProgressView.h"
#import "ERHttpTool.h"

#define Margin 10
#define TextFont [UIFont systemFontOfSize:18];
#define TitleFont [UIFont systemFontOfSize:20];

@interface ERHoroDetailViewController ()
@property (nonatomic, strong) PDColoredProgressView *pView1;
@property (nonatomic, strong) PDColoredProgressView *pView2;
@property (nonatomic, strong) PDColoredProgressView *pView3;
@property (nonatomic, strong) PDColoredProgressView *pView4;
@property (nonatomic, strong) PDColoredProgressView *pView5;
/**  时间标签 */
@property (nonatomic, weak) UIScrollView *scrollView;
/**  时间标签 */
@property (nonatomic, weak) UILabel *timeLabel;
/**  总运指数 */
@property (nonatomic, weak) UILabel *allLabel;
/**  爱情指数 */
@property (nonatomic, weak) UILabel *loveLabel;
/**  财运指数 */
@property (nonatomic, weak) UILabel *moneyLabel;
/**  工作指数 */
@property (nonatomic, weak) UILabel *workLabel;
/**  健康指数 */
@property (nonatomic, weak) UILabel *healthLabel;
/**  贵人星座 */
@property (nonatomic, weak) UILabel *qFriendLabel;
/**  幸运数字 */
@property (nonatomic, weak) UILabel *numberLabel;
/**  幸运颜色 */
@property (nonatomic, weak) UILabel *colorLabel;
/**  运势提醒 */
@property (nonatomic, weak) UILabel *summaryLabel;

@end

@implementation ERHoroDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.title = [NSString stringWithFormat:@"%@今日运势",self.consName];
    UIImage *oldImage = [UIImage imageNamed:@"basicBack"];
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, 0.0);
    [oldImage drawInRect:self.view.bounds];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:newImage];
    

//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"更多运势" target:self action:@selector(moreLuck)];
    
    [self loadLuck];
    [self setupChildViews];

}

- (void)setupChildViews
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 64, ScreenW, ScreenH - 64);
    scrollView.contentSize = CGSizeMake(ScreenW, 600);
    scrollView.scrollEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    CGFloat labelHeight = 30;
    CGFloat leftMargin = 10;
    
    /**  时间标签 */
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.x = leftMargin;
    timeLabel.y = 0;
    timeLabel.width = ScreenW - 2 * leftMargin;
    timeLabel.height = 35;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = TitleFont;
    timeLabel.textColor = [UIColor whiteColor];
    [scrollView addSubview:timeLabel];
    self.timeLabel = timeLabel;

    /**  总运指数 */
    UILabel *allLabel = [[UILabel alloc] init];
    allLabel.x = leftMargin;
    allLabel.y = CGRectGetMaxY(_timeLabel.frame) + Margin;
    allLabel.width = ScreenW - 2 * leftMargin;
    allLabel.height = labelHeight;
    allLabel.font = TextFont;
    allLabel.textColor = [UIColor whiteColor];
    [scrollView addSubview:allLabel];
    self.allLabel = allLabel;
    
    /**  爱情指数 */
    UILabel *loveLabel = [[UILabel alloc] init];
    loveLabel.x = leftMargin;
    loveLabel.y = CGRectGetMaxY(_allLabel.frame);
    loveLabel.width = ScreenW - 2 * leftMargin;
    loveLabel.height = labelHeight;
    loveLabel.font = TextFont;
    loveLabel.textColor = [UIColor whiteColor];
    [scrollView addSubview:loveLabel];
    self.loveLabel = loveLabel;
    
    /**  财运指数 */
    UILabel *moneyLabel = [[UILabel alloc] init];
    moneyLabel.x = leftMargin;
    moneyLabel.y = CGRectGetMaxY(_loveLabel.frame);
    moneyLabel.width = ScreenW - 2 * leftMargin;
    moneyLabel.height = labelHeight;
    moneyLabel.font = TextFont;
    moneyLabel.textColor = [UIColor whiteColor];
    [scrollView addSubview:moneyLabel];
    self.moneyLabel = moneyLabel;
    
    /**  工作指数 */
    UILabel *workLabel = [[UILabel alloc] init];
    workLabel.x = leftMargin;
    workLabel.y = CGRectGetMaxY(_moneyLabel.frame);
    workLabel.width = ScreenW - 2 * leftMargin;
    workLabel.height = labelHeight;
    workLabel.font = TextFont;
    workLabel.textColor = [UIColor whiteColor];
    [scrollView addSubview:workLabel];
    self.workLabel = workLabel;
    
    /**  健康指数 */
    UILabel *healthLabel = [[UILabel alloc] init];
    healthLabel.x = leftMargin;
    healthLabel.y = CGRectGetMaxY(_workLabel.frame);
    healthLabel.width = ScreenW - 2 * leftMargin;
    healthLabel.height = labelHeight;
    healthLabel.font = TextFont;
    healthLabel.textColor = [UIColor whiteColor];
    [scrollView addSubview:healthLabel];
    self.healthLabel = healthLabel;
    
    /**  贵人星座 */
    UILabel *qFriendLabel = [[UILabel alloc] init];
    qFriendLabel.x = leftMargin;
    qFriendLabel.y = CGRectGetMaxY(_healthLabel.frame) +  Margin;
    qFriendLabel.width = ScreenW - 2 * leftMargin;
    qFriendLabel.height = labelHeight;
    qFriendLabel.font = TitleFont;
    qFriendLabel.textColor = [UIColor whiteColor];
    [scrollView addSubview:qFriendLabel];
    self.qFriendLabel = qFriendLabel;
    
    /**  幸运数字 */
    UILabel *numberLabel = [[UILabel alloc] init];
    numberLabel.x = leftMargin;
    numberLabel.y = CGRectGetMaxY(_qFriendLabel.frame);
    numberLabel.width = ScreenW - 2 * leftMargin;
    numberLabel.height = labelHeight;
    numberLabel.font = TextFont;
    numberLabel.textColor = [UIColor whiteColor];
    [scrollView addSubview:numberLabel];
    self.numberLabel = numberLabel;
    
    /**  幸运颜色 */
    UILabel *colorLabel = [[UILabel alloc] init];
    colorLabel.x = leftMargin;
//     colorLabel.backgroundColor = ERRandomColor;
    colorLabel.y = CGRectGetMaxY(_numberLabel.frame);
    colorLabel.width = ScreenW - 2 * leftMargin;
    colorLabel.height = labelHeight;
    colorLabel.font = TextFont;
    colorLabel.textColor = [UIColor whiteColor];
    [scrollView addSubview:colorLabel];
    self.colorLabel = colorLabel;
    
    /**  运势提醒 */
    UILabel *summaryLabel = [[UILabel alloc] init];
//    summaryLabel.backgroundColor = ERRandomColor;
//    summaryLabel.adjustsLetterSpacingToFitWidth = YES;
    summaryLabel.numberOfLines = 0;
    summaryLabel.textColor = [UIColor whiteColor];
    summaryLabel.x = leftMargin;
    summaryLabel.y = CGRectGetMaxY(_colorLabel.frame) + Margin;
    summaryLabel.width = ScreenW - 2 * leftMargin;
    summaryLabel.height = 200;
    summaryLabel.font = TitleFont;
    [scrollView addSubview:summaryLabel];
    self.summaryLabel = summaryLabel;
}


- (void)loadLuck
{

    NSString *ss = [self.consName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"key"] = @"e01fd924f8b54387a0f484066573fb41";
    param[@"consName"] = ss;
    param[@"type"] = @"today";
    
    [ERHttpTool GET:@"http://api.avatardata.cn/Constellation/Query" parameters:param success:^(id responseObject) {
        
        ERLog(@"%@",responseObject[@"result1"]);
        
        NSDictionary *horoDictionary = responseObject[@"result1"];
        
        _timeLabel.text = horoDictionary[@"datetime"];

        // 文字转换
        NSString *s1 = horoDictionary[@"all"];
        s1 = [s1 stringByReplacingOccurrencesOfString:@"%" withString:@""];
        // 总运指数赋值
        _allLabel.text = [NSString stringWithFormat:@"总运指数:                                       %@分",s1];
        CGFloat a1 = [s1 integerValue]/100.0;
        // 进度条赋值
        if (horoDictionary.count) {
            PDColoredProgressView *pView1 = [[PDColoredProgressView alloc] initWithProgressViewStyle: UIProgressViewStyleDefault];
            pView1.width = 170;
            pView1.x = 90;
            pView1.centerY = CGRectGetMidY(_allLabel.frame);
            pView1.progress = a1;
            [pView1 setTintColor: [UIColor orangeColor]];
            [self.scrollView addSubview:pView1];
            self.pView1 = pView1;

        }        
        // 文字转换
        NSString *s2 = horoDictionary[@"love"];
        s2 = [s2 stringByReplacingOccurrencesOfString:@"%" withString:@""];
        // 总运指数赋值
        _loveLabel.text = [NSString stringWithFormat:@"爱情指数:                                       %@分",s2];
        CGFloat a2 = [s2 integerValue]/100.0;
        // 进度条赋值
        if (horoDictionary.count) {
            PDColoredProgressView *pView2 = [[PDColoredProgressView alloc] initWithProgressViewStyle: UIProgressViewStyleDefault];
            pView2.width = 170;
            pView2.x = 90;
            pView2.centerY = CGRectGetMidY(_loveLabel.frame);
            pView2.progress = a2;
            [pView2 setTintColor: [UIColor orangeColor]];
            [self.scrollView addSubview:pView2];
            self.pView2 = pView2;
        }
        // 文字转换
        NSString *s3 = horoDictionary[@"money"];
        s3 = [s3 stringByReplacingOccurrencesOfString:@"%" withString:@""];
        // 总运指数赋值
        _moneyLabel.text = [NSString stringWithFormat:@"财运指数:                                       %@分",s3];
        CGFloat a3 = [s3 integerValue]/100.0;
        // 进度条赋值
        if (horoDictionary.count) {
            PDColoredProgressView *pView3 = [[PDColoredProgressView alloc] initWithProgressViewStyle: UIProgressViewStyleDefault];
            pView3.width = 170;
            pView3.x = 90;
            pView3.centerY = CGRectGetMidY(_moneyLabel.frame);
            pView3.progress = a3;
            [pView3 setTintColor: [UIColor orangeColor]];
            [self.scrollView addSubview:pView3];
            self.pView3 = pView3;;
        }
        
        // 文字转换
        NSString *s4 = horoDictionary[@"work"];
        s4 = [s4 stringByReplacingOccurrencesOfString:@"%" withString:@""];
        // 总运指数赋值
        _workLabel.text = [NSString stringWithFormat:@"工作指数:                                       %@分",s4];
        CGFloat a4 = [s4 integerValue]/100.0;
        // 进度条赋值
        if (horoDictionary.count) {
            PDColoredProgressView *pView4 = [[PDColoredProgressView alloc] initWithProgressViewStyle: UIProgressViewStyleDefault];
            pView4.width = 170;
            pView4.x = 90;
            pView4.centerY = CGRectGetMidY(_workLabel.frame);
            pView4.progress = a4;
            [pView4 setTintColor: [UIColor orangeColor]];
            [self.scrollView addSubview:pView4];
            self.pView4 = pView4;;
        }
        
        // 文字转换
        NSString *s5 = horoDictionary[@"health"];
        s5 = [s5 stringByReplacingOccurrencesOfString:@"%" withString:@""];
        // 总运指数赋值
        _healthLabel.text = [NSString stringWithFormat:@"健康指数:                                       %@分",s5];
        CGFloat a5 = [s5 integerValue]/100.0;
        // 进度条赋值
        if (horoDictionary.count) {
            PDColoredProgressView *pView5 = [[PDColoredProgressView alloc] initWithProgressViewStyle: UIProgressViewStyleDefault];
            pView5.width = 170;
            pView5.x = 90;
            pView5.centerY = CGRectGetMidY(_healthLabel.frame);
            pView5.progress = a5;
            [pView5 setTintColor: [UIColor orangeColor]];
            [self.scrollView addSubview:pView5];
            self.pView5 = pView5;
        }
        _qFriendLabel.text = [NSString stringWithFormat:@"贵人星座:%@",horoDictionary[@"QFriend"]];
        _numberLabel.text = [NSString stringWithFormat:@"幸运数字:  %@",horoDictionary[@"number"]];
        _colorLabel.text = [NSString stringWithFormat:@"幸运颜色:%@",horoDictionary[@"color"]];
        _summaryLabel.text = [NSString stringWithFormat:@"运势提醒:\n       %@",horoDictionary[@"summary"]];
        
    } failure:^(NSError *error) {
        ERLog(@"%@",error);
    }];
}


//- (void)moreLuck
//{
//    ERLog(@"更多运势");
//    
//}

@end
