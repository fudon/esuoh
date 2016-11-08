//
//  ARPersonController.m
//  myhome
//
//  Created by fudon on 2016/11/1.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "ARPersonController.h"
#import "FSShareView.h"
#import "FSWebController.h"

@interface ARPersonController ()<UITableViewDelegate,UITableViewDataSource>

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
    }else if (indexPath.row == 1){
        [[FSShareManager shareInstance] mailShareWithSubject:@"App反馈" messageBody:@"反馈内容" recipients:@[@"1245102331@qq.com"] fileData:nil fileName:nil controller:self];
    }else if (indexPath.row == 2){
        
    }else if (indexPath.row == 3){
//        FSWebController *webController = [[FSWebController alloc] init];
//        [self.navigationController pushViewController:webController animated:YES];
    }
}

- (void)showShareView
{
    FSShareView *shareView = [[FSShareView alloc] initWithFrame:[UIScreen mainScreen].bounds controller:self];
    [self.navigationController.tabBarController.view addSubview:shareView];
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
