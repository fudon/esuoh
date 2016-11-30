//
//  ARHomeController.m
//  myhome
//
//  Created by fudon on 2016/11/1.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "ARHomeController.h"
#import "FuSoft.h"
#import "HACityController.h"

@interface ARHomeController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ARHomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我要装修";
    
    UIBarButtonItem *leftBBI = [[UIBarButtonItem alloc] initWithTitle:@"长沙" style:UIBarButtonItemStylePlain target:self action:@selector(leftBBIAction)];
    self.navigationItem.leftBarButtonItem = leftBBI;
    
    CGFloat width = (self.view.width - 20 * 4) / 3;
    NSArray *picTitles = @[@"新",@"二",@"楼"];
    NSArray *titles = @[@"新房",@"二手房",@"楼盘信息"];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHFC, width + 10)];
    
    for (int x = 0; x < 3; x ++) {
        UIButton *mainButton = [FSViewManager buttonWithFrame:CGRectMake(20 + (width + 20) * x, 10, width, width) title:nil titleColor:nil backColor:nil fontInt:0 tag:TAGBUTTON + x target:self selector:@selector(buttonClick:)];
        [headView addSubview:mainButton];
        
        UILabel *label = [FSViewManager labelWithFrame:CGRectMake(width / 2 - (width - 40) / 2, 0, width - 40, width - 40) text:picTitles[x] textColor:[UIColor whiteColor] backColor:[UIColor redColor] font:FONTBOLD(15) textAlignment:NSTextAlignmentCenter];
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = label.height / 2;
        [mainButton addSubview:label];
        
        UILabel *bottomLabel = [FSViewManager labelWithFrame:CGRectMake(0, width - 30, width, 30) text:titles[x] textColor:nil backColor:nil font:FONTFC(14) textAlignment:NSTextAlignmentCenter];
        [mainButton addSubview:bottomLabel];
    }
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTHFC, HEIGHTFC - 64 - 49) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    tableView.tableHeaderView = headView;
}

- (void)buttonClick:(UIButton *)button
{
    
}

- (void)leftBBIAction
{
    [FuData pushToViewControllerWithClass:@"HACityController" navigationController:self.navigationController param:@{} configBlock:^(HACityController *vc) {
        vc.selectedCityBlock = ^ (NSDictionary *bCity){
            NSLog(@"%@",bCity);
        };
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"homeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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
