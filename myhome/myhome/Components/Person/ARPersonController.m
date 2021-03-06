//
//  ARPersonController.m
//  myhome
//
//  Created by fudon on 2016/11/1.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "ARPersonController.h"
#import "FSShareView.h"
#import "HoldViewController.h"

@interface ARPersonController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray    *titles;
@property (nonatomic,assign) NSInteger  counter;

@end

@implementation ARPersonController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
    [self personDesignViews];
}

- (void)bbiAction
{
    [FuData pushToViewControllerWithClass:@"FSSetController" navigationController:self.navigationController param:nil configBlock:nil];
}

- (void)personDesignViews
{
    _titles = @[@"分享",@"反馈",@"关于",@"保留",@"保留"];
    
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(bbiAction)];
    bbi.tintColor = APPCOLOR;
    self.navigationItem.rightBarButtonItem = bbi;
    
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
        [FSShareManager emailShareWithSubject:@"App FB" messageBody:nil recipients:@[@"1245102331@qq.com"] fileData:nil fileName:nil fileType:nil controller:self];
    }else if (indexPath.row == 2){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ARAbout" ofType:@"html"];
        [FuData pushToViewControllerWithClass:@"FSHTMLController" navigationController:self.navigationController param:@{@"localUrlString":path,@"title":@"关于"} configBlock:nil];
    }else if (indexPath.row == 3){
        [FuData pushToViewControllerWithClass:@"FSAppToolController" navigationController:self.navigationController param:nil configBlock:nil];
    }else if (indexPath.row == 4){
        _counter ++;
        if (_counter == 3) {
            _counter = 0;
            
            // 跳转
            HoldViewController *hold = [[HoldViewController alloc] init];
            hold.first = YES;
            [self.navigationController pushViewController:hold animated:YES];
            [hold setBtnClickCallback:^{
                [FuData showMessage:@"会跳转"];
            }];
        }
    }
}

- (void)showShareView
{
    FSShareView *shareView = [[FSShareView alloc] initWithFrame:[UIScreen mainScreen].bounds list:@[@(FSShareTypeWechat),@(FSShareTypeQQ),@(FSShareTypeWeibo),@(FSShareTypeEmail),@(FSShareTypeMessage)] controller:self title:@"Title" detail:@"Detail" url:@"https://www.baidu.com" thumbImage:[UIImage new] recipientsOfMail:nil recipientsOfMessage:nil fileData:nil fileName:nil fileType:nil result:^(NSString *bResult) {
    }];
                              
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
