//
//  ERSettingController.m
//  EnjoyReading
//
//  Created by 王亮 on 16/3/14.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import "ERSettingController.h"
#import "ERMineItem.h"
#import "ERLabelItem.h"
#import "ERGroup.h"
#import "ERMineCell.h"
#import "ERAboutController.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+MJ.h"
#import <MessageUI/MessageUI.h>

@interface ERSettingController ()<MFMailComposeViewControllerDelegate>
/** 组 */
@property (nonatomic, strong) NSMutableArray *groups;

/**  A */
@property (nonatomic, weak)  UIView *nightModeView;
/**  判断是否为夜间 */
@property (nonatomic, assign ,getter=isNight) BOOL states;
@end

@implementation ERSettingController
- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = ERColor(245, 245, 245);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupGroup];
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupNightMode) name:@"NIGHT" object:nil];
}

- (void)setupNightMode
{
    // 夜间模式
    UIView *nightModeView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    nightModeView.backgroundColor = [UIColor blackColor];
    nightModeView.alpha = 0.5;
    nightModeView.userInteractionEnabled = NO;
    [self.view addSubview:nightModeView];
    self.nightModeView = nightModeView;
}

- (void)setupGroup
{
    // 清除缓存
    ERGroup *group1 = [ERGroup group];
    [self.groups addObject:group1];
    
    ERLabelItem *cacheClean = [ERLabelItem itemWithTitle:@"清理缓存" icon:@"setting_cache"];
    group1.items = @[cacheClean];
    //获取sdwebImage的图片缓存
    NSString *title = nil;
    NSUInteger size = [SDImageCache sharedImageCache].getSize;
    
    if (size > 1024 * 1024) {
        CGFloat floatSize = size / 1024.0 / 1024.0;
        title = [NSString stringWithFormat:@"%.1fM",floatSize];
    }else if (size > 1024){
        CGFloat floatSize = size / 1024.0;
        title = [NSString stringWithFormat:@"%.fKb",floatSize];
    }else if (size > 0) {
        title = [NSString stringWithFormat:@"%ldb",(unsigned long)size];
    }

    cacheClean.text = title;
    
    __weak typeof(cacheClean) weakcacheClean = cacheClean;

    cacheClean.operation = ^{
        
        [MBProgressHUD showMessage:@"正在清除缓存...."];
        
        [[SDImageCache sharedImageCache] clearDisk];
        
        weakcacheClean.text = nil;
        [self.tableView reloadData];
        
        [MBProgressHUD hideHUD];
    };
    
    
    // 意见反馈
    ERGroup *group2 = [ERGroup group];
    [self.groups addObject:group2];
    ERMineItem *ideafeedback = [ERMineItem itemWithTitle:@"意见与反馈" icon:@"setting_feedback"];
    group2.items = @[ideafeedback];
    ideafeedback.operation = ^{
        
        [self sendEMail];
        
    };
    
    
    // 软件评分
    ERGroup *group3 = [ERGroup group];
    [self.groups addObject:group3];
    ERMineItem *mark = [ERMineItem itemWithTitle:@"为EnjoyReading评分" icon:@"setting_invite"];
    mark.operation = ^{
    ERLog(@"跳转到appstore");

    NSString *str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",
                         436957167 ];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

    };
    group3.items = @[mark];
    
    // 关于
    ERGroup *group4 = [ERGroup group];
    [self.groups addObject:group4];
    ERMineItem *about = [ERMineItem itemWithTitle:@"关于" icon:@"setting_about"];
    about.destVcClass = [ERAboutController class];
    group4.items = @[about];

}

- (void) alertWithTitle: (NSString *)_title_ msg: (NSString *)msg
{

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title_ message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

-(void)sendEMail
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (mailClass != nil)
    {
        if ([mailClass canSendMail])
        {
            [self displayComposerSheet];
        }
        else
        {
            [self launchMailAppOnDevice];
        }
    }
    else
    {
        [self launchMailAppOnDevice];
    }
}

//可以发送邮件的话
-(void)displayComposerSheet
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    
    mailPicker.mailComposeDelegate = self;
    
    //设置主题
    [mailPicker setSubject: @"意见与反馈"];
    
    // 添加发送者
    NSArray *toRecipients = [NSArray arrayWithObject: @"283175161@qq.com"];

    [mailPicker setToRecipients: toRecipients];

    NSString *emailBody = @"谢谢您将宝贵的意见反馈给我们...";
    [mailPicker setMessageBody:emailBody isHTML:YES];
    
    [self presentViewController:mailPicker animated:YES completion:nil];

}
-(void)launchMailAppOnDevice
{
    NSString *recipients = @"mailto:first@example.com&subject=my email!";
    //@"mailto:first@example.com?cc=second@example.com,third@example.com&subject=my email!";
    NSString *body = @"&body=email body!";
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
}
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSString *msg;
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            msg = @"邮件发送取消";
            break;
        case MFMailComposeResultSaved:
            msg = @"邮件保存成功";
            [self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultSent:
            msg = @"邮件发送成功";
            [self alertWithTitle:nil msg:msg];
            break;
        case MFMailComposeResultFailed:
            msg = @"邮件发送失败";
            [self alertWithTitle:nil msg:msg];
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ERGroup *group = self.groups[section];
    return group.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ERMineCell *cell = [ERMineCell cellWithTableView:tableView];
    ERGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    [cell setIndexPath:indexPath rowsInSection:group.items.count];
    return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取出这行对应的item模型
    ERGroup *group = self.groups[indexPath.section];
    ERMineItem *item = group.items[indexPath.row];
    
    // 2.判断有无需要跳转的控制器
    if (item.destVcClass) {
        UIViewController *destVc = [[item.destVcClass alloc] init];
        destVc.title = item.title;
        [self.navigationController pushViewController:destVc animated:YES];
    }
    
    // 3.判断有无想执行的操作
    if (item.operation) {
        item.operation();
    }
}

@end
