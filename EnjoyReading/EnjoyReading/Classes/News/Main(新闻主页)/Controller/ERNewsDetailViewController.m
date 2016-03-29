//
//  ERNewsDetailViewController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/11.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERNewsDetailViewController.h"
#import "UIImageView+WebCache.h"

@interface ERNewsDetailViewController ()<UIWebViewDelegate>

@end

@implementation ERNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.title = self.nationalNews.title;
    UIWebView *webView = [[UIWebView alloc] init];
//    webView.backgroundColor = ERRandomColor;
    webView.frame = self.view.bounds;
    webView.delegate = self;
    webView.scalesPageToFit = YES ;
    [self.view addSubview:webView];
    
    NSString *urlStr = self.url;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [webView loadRequest:request];
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('adpic')[0].style.display = 'none'"];

    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
