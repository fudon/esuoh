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

@property (nonatomic,strong) UIView         *barImageView;

@end

@implementation ARHomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我要装修";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    
    _barImageView = self.navigationController.navigationBar.subviews.firstObject;
    _barImageView.alpha = 0;
    
    UIBarButtonItem *leftBBI = [[UIBarButtonItem alloc] initWithTitle:@"沙" style:UIBarButtonItemStylePlain target:self action:@selector(leftBBIAction)];
    leftBBI.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBBI;
    
    UIBarButtonItem *rightBBI = [[UIBarButtonItem alloc] initWithTitle:@"参考" style:UIBarButtonItemStylePlain target:self action:@selector(leftBBIAction)];
    rightBBI.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBBI;
    
    CGFloat width = (self.view.width - 20 * 4) / 3;
    NSArray *picTitles = @[@"A",@"B",@"C"];
    NSArray *titles = @[@"新",@"二",@"楼"];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHFC, HEIGHTFC / 2)];
    
    for (int x = 0; x < 3; x ++) {
        UIButton *mainButton = [FSViewManager buttonWithFrame:CGRectMake(20 + (width + 20) * x, headView.height - width, width, width) title:nil titleColor:nil backColor:nil fontInt:0 tag:TAGBUTTON + x target:self selector:@selector(buttonClick:)];
        [headView addSubview:mainButton];
        
        UILabel *label = [FSViewManager labelWithFrame:CGRectMake(width / 2 - (width - 40) / 2, 0, width - 40, width - 40) text:picTitles[x] textColor:[UIColor whiteColor] backColor:[UIColor redColor] font:FONTBOLD(15) textAlignment:NSTextAlignmentCenter];
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = label.height / 2;
        [mainButton addSubview:label];
        
        UILabel *bottomLabel = [FSViewManager labelWithFrame:CGRectMake(0, width - 30, width, 30) text:titles[x] textColor:nil backColor:nil font:FONTFC(14) textAlignment:NSTextAlignmentCenter];
        [mainButton addSubview:bottomLabel];
    }
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTHFC, HEIGHTFC - 49) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navi_back_image"]];
    tableView.tableHeaderView = headView;
    
    //    [tableView setContentInset:UIEdgeInsetsMake(_halfHeight, 0, 0, 0)];
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

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat alpha = scrollView.contentOffset.y / 200;
    alpha = MIN(MAX(alpha, 0), 1);
    _barImageView.alpha = alpha;
    BOOL margin = (alpha > 0.7);
    UIColor *systemBlue = RGBCOLOR(21, 126, 251, 1);
    UIColor *whiteColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem.tintColor = margin?systemBlue:whiteColor;
    self.navigationItem.rightBarButtonItem.tintColor = margin?systemBlue:whiteColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:margin?systemBlue:whiteColor};
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
