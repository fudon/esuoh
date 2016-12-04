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
#import "FSFlowView.h"

@interface ARHomeController ()

@property (nonatomic,strong) UIView             *barImageView;
@property (nonatomic,strong) UIImageView        *headImageView;
@property (nonatomic,assign) CGAffineTransform  headTransform;

@end

@implementation ARHomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我要装修";
    [self homeDeisgnViews];
}

- (void)homeDeisgnViews
{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = APPCOLOR;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    
//    _barImageView = self.navigationController.navigationBar.subviews.firstObject;
//    _barImageView.alpha = 0;
    
    UIBarButtonItem *leftBBI = [[UIBarButtonItem alloc] initWithTitle:@"长沙" style:UIBarButtonItemStylePlain target:self action:@selector(leftBBIAction)];
    leftBBI.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBBI;
    
    UIBarButtonItem *rightBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(rightBBIAction)];
    rightBBI.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBBI;
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTHFC, WIDTHFC * .625)];
    _headImageView.image = [UIImage imageNamed:@"home_backImage"];
    [self.scrollView addSubview:_headImageView];
    self.headTransform = _headImageView.transform;
    
    self.scrollView.frame = CGRectMake(0, 0, self.view.width, self.view.height - 49);
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    UILabel *callLabel = [FSViewManager labelWithFrame:CGRectMake(10, _headImageView.bottom, WIDTHFC - 10, 50) text:@"报价查询" textColor:FS_TextColor_Normal backColor:nil font:FONTFC(18) textAlignment:NSTextAlignmentLeft];
    [self.scrollView addSubview:callLabel];
    
    UITextField *textField = [FSViewManager textFieldWithFrame:CGRectMake(10, callLabel.bottom, WIDTHFC - 20, 50) placeholder:@"您的房屋面积•平米" textColor:FS_TextColor_Normal backColor:nil];
    textField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.scrollView addSubview:textField];
    [textField addSubview:[FSViewManager seprateViewWithFrame:CGRectMake(0, textField.height - FS_LineThickness, textField.width, FS_LineThickness)]];
    
    UIButton *queryButton = [FSViewManager buttonWithFrame:CGRectMake(10, textField.bottom + 20, WIDTHFC - 20, 44) title:@"点我查询" titleColor:[UIColor whiteColor] backColor:APPCOLOR fontInt:16 tag:0 target:self selector:@selector(buttonClick:)];
    [self.scrollView addSubview:queryButton];
    
    CGFloat width = (self.view.width - 20) / 4;
    NSArray *picTitles = @[@"A",@"B",@"C",@"D"];
    NSArray *titles = @[@"豪华",@"品牌",@"精致",@"简单"];

    for (int x = 0; x < 4; x ++) {
        UIButton *mainButton = [FSViewManager buttonWithFrame:CGRectMake(10 + width * x, queryButton.bottom + 40, width, width) title:nil titleColor:nil backColor:nil fontInt:0 tag:TAGBUTTON + x target:self selector:@selector(buttonClick:)];
        [self.scrollView addSubview:mainButton];

        UILabel *label = [FSViewManager labelWithFrame:CGRectMake(width / 2 - (width - 40) / 2, 0, width - 40, width - 40) text:picTitles[x] textColor:[UIColor whiteColor] backColor:APPCOLOR font:FONTBOLD(15) textAlignment:NSTextAlignmentCenter];
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = label.height / 2;
        [mainButton addSubview:label];

        UILabel *bottomLabel = [FSViewManager labelWithFrame:CGRectMake(0, width - 30, width, 30) text:titles[x] textColor:nil backColor:nil font:FONTFC(14) textAlignment:NSTextAlignmentCenter];
        [mainButton addSubview:bottomLabel];
    }

    UILabel *flowLabel = [FSViewManager labelWithFrame:CGRectMake(10, queryButton.bottom + 40 + width + 20, WIDTHFC - 10, 50) text:@"流程六步走" textColor:FS_TextColor_Normal backColor:nil font:FONTFC(18) textAlignment:NSTextAlignmentLeft];
    [self.scrollView addSubview:flowLabel];
    
    FSFlowView *flowView = [[FSFlowView alloc] initWithFrame:CGRectMake(0, flowLabel.bottom, WIDTHFC, WIDTHFC) titles:@[@"勘房",@"设计",@"签约",@"完成",@"验收",@"装修"] titleColor:[UIColor whiteColor] btnBackColor:APPCOLOR lineColor:APPCOLOR];
    [self.scrollView addSubview:flowView];
    
    [self addKeyboardNotificationWithBaseOn:flowView.bottom];
    self.scrollView.contentSize = CGSizeMake(WIDTHFC, flowView.bottom);
    
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

- (void)rightBBIAction
{
    [FuData pushToViewControllerWithClass:@"HAToolController" navigationController:self.navigationController param:nil configBlock:nil];
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
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat offsetY = scrollView.contentOffset.y;
//    if (offsetY < 0) {
//        NSLog(@"%f",offsetY);
//        CGFloat absValue = - offsetY;
//        CGFloat rate = absValue / HEIGHTFC;
//        self.headImageView.transform = CGAffineTransformScale(self.headTransform, 1 + rate, 1 + rate);
//    }else{
//        self.headImageView.top = - MIN(offsetY, self.headImageView.height);
//        self.headImageView.transform = self.headTransform;
//    }
//}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    int offsetY = (int)scrollView.contentOffset.y;
//    NSLog(@"%d",offsetY);
//    if (offsetY == 0) {
//        WEAKSELF(this);
//        [UIView animateWithDuration:.3 animations:^{
//            this.scrollView.contentOffset = CGPointMake(0, 0);
//            this.headImageView.top = 0;
//            this.barImageView.alpha = 0;
//        }];
//        
//        NSLog(@"CALL HERE");
//    }
//}

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
