//
//  ARPersonController.m
//  myhome
//
//  Created by fudon on 2016/11/1.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "ARPersonController.h"
#import "FSShareView.h"
#import <MessageUI/MessageUI.h>

@interface ARPersonController ()<UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate>

@property (nonatomic,strong) NSArray    *titles;

@end

@implementation ARPersonController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
    [self personDesignViews];
}

- (void)personDesignViews
{
    _titles = @[@"分享",@"反馈",@"关于",@"设置"];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTHFC, HEIGHTFC - 64) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHFC, 10)];
    tableView.tableHeaderView = headView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"personCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self showShareView];
    }
}

- (void)showShareView
{
    __weak ARPersonController *this = self;
    FSShareView *shareView = [[FSShareView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.navigationController.tabBarController.view addSubview:shareView];
    shareView.block = ^ (FSShareView *bView,NSInteger bTag){
        [this shareTo:bTag];
    };
}

- (void)shareTo:(NSInteger)tag
{
    if (tag == WTShareTypeWeiBo) {
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:WTShareTypeWeiBo shareResult:^(NSString *shareResult) {
            [FuData showAlertViewWithTitle:shareResult];
        }];
        
    }else if (tag == WTShareTypeQQ){
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:WTShareTypeQQ shareResult:^(NSString *shareResult) {
            [FuData showAlertViewWithTitle:shareResult];
        }];
    }else if (tag == WTShareTypeQQZone){
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:WTShareTypeQQZone shareResult:^(NSString *shareResult) {
            [FuData showAlertViewWithTitle:shareResult];
        }];
    }else if (tag == WTShareTypeWeiXinTimeline){
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:WTShareTypeWeiXinTimeline shareResult:^(NSString *shareResult) {
            [FuData showAlertViewWithTitle:shareResult];
        }];
    }else if (tag == WTShareTypeWeiXinSession){
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:WTShareTypeWeiXinSession shareResult:^(NSString *shareResult) {
            [FuData showAlertViewWithTitle:shareResult];
        }];
    }else if (tag == WTShareTypeWeiXinFavorite){
        [FSShareManager wt_shareWithContent:[FSShareEntity shareWTShareContentItem] shareType:WTShareTypeWeiXinFavorite shareResult:^(NSString *shareResult) {
            [FuData showAlertViewWithTitle:shareResult];
        }];
    }else if (tag == WTShareTypeWeiMessage){
        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        picker.messageComposeDelegate = self;
        picker.body =  @"分享的短信内容吗？";
        if (picker) {
            [self presentViewController:picker animated:YES completion:nil];
        }
    }else if (tag == WTShareTypeWeiEmail){
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        if (!picker) {
            [self showTitle:@"设备不支持发送邮件"];
            return;
        }
        picker.mailComposeDelegate = self;
        [picker setSubject:@"最好的软件"];
        [picker setMessageBody:@"分享的内容" isHTML:NO];
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    if (result == MFMailComposeResultSent) {
        [FuData showAlertViewWithTitle:@"发送成功" message:@"谢谢您的支持"];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
        case MessageComposeResultSent:
        {
            [FuData showAlertViewWithTitle:@"发送成功"];
        }
            break;
            
        case MessageComposeResultFailed:
            break;
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
