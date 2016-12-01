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

@property (nonatomic,strong) UIView     *alphaView;
@property (nonatomic,strong) UILabel    *titleLabel;

@end

@implementation ARHomeController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _titleLabel = [FSViewManager labelWithFrame:CGRectMake(0, 0, WIDTHFC / 3, 44) text:@"我要装修" textColor:[UIColor whiteColor] backColor:nil font:nil textAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView = _titleLabel;
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    CGRect frame = self.navigationController.navigationBar.frame;
    _alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, frame.size.width, frame.size.height+20)];
    _alphaView.backgroundColor = [UIColor whiteColor];
    _alphaView.alpha = 0;
    _alphaView.userInteractionEnabled = NO;
    [self.navigationController.navigationBar insertSubview:_alphaView atIndex:0];
        
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
    tableView.backgroundColor = [UIColor clearColor];
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
    CGFloat alpha = scrollView.contentOffset.y / 64;
    _alphaView.alpha = MIN(MAX(alpha, 0), 1);
    BOOL margin = _alphaView.alpha > 0.5;
    self.navigationItem.leftBarButtonItem.tintColor = margin?nil:[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.tintColor = margin?nil:[UIColor whiteColor];
    self.titleLabel.textColor = margin?RGBCOLOR(21, 126, 251, 1):[UIColor whiteColor];
    
    [self setNeedsStatusBarAppearanceUpdate];
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
