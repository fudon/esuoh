//
//  FSAppToolController.m
//  myhome
//
//  Created by fudon on 2017/1/6.
//  Copyright © 2017年 fuhope. All rights reserved.
//

#import "FSAppToolController.h"

@interface FSAppToolController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray    *titles;

@end

@implementation FSAppToolController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self appToolDesignViews];
}

- (void)bbiAction
{

}

- (void)appToolDesignViews
{
    _titles = @[@"制图",@"备用",@"备用",@"备用"];
    
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"备用" style:UIBarButtonItemStyleDone target:self action:@selector(bbiAction)];
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
        [FuData pushToViewControllerWithClass:@"FSMakeImageController" navigationController:self.navigationController param:nil configBlock:nil];
    }else if (indexPath.row == 1){

    }else if (indexPath.row == 2){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ARAbout" ofType:@"html"];
        [FuData pushToViewControllerWithClass:@"FSHTMLController" navigationController:self.navigationController param:@{@"localUrlString":path,@"title":@"关于"} configBlock:nil];
    }else if (indexPath.row == 3){
        [FuData pushToViewControllerWithClass:@"FSAppToolController" navigationController:self.navigationController param:nil configBlock:nil];
    }
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
