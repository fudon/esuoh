//
//  HARewardPolicyController.m
//  myhome
//
//  Created by FudonFuchina on 2016/12/9.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "HARewardPolicyController.h"

@interface HARewardPolicyController ()

@end

@implementation HARewardPolicyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"奖励政策";
    [self policyDesignViews];
}

- (void)policyDesignViews
{
    UILabel *timeLabel = [FSViewManager labelWithFrame:CGRectMake(WIDTHFC / 4, 10, WIDTHFC / 2, 30) text:@"2016年12月14日 22:25" textColor:[UIColor whiteColor] backColor:RGBCOLOR(220, 220, 220, 1) font:FONTFC(14) textAlignment:NSTextAlignmentCenter];
    [self.scrollView addSubview:timeLabel];
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, timeLabel.bottom + 30, 45, 45)];
    imageView.image = IMAGENAMED(@"deviceInfo");
    [self.scrollView addSubview:imageView];
    
    UILabel *label = [FSViewManager labelWithFrame:CGRectMake(imageView.right + 10, imageView.top, WIDTHFC - 100, 200) text:@"你知道吗？过去几个月的测试阶段，我已经和起晚个人类通过电话了，科幻电影吗？不，这已成现实，对我说【我要排队】" textColor:[UIColor blackColor] backColor:[UIColor whiteColor] font:FONTFC(14) textAlignment:NSTextAlignmentLeft];
    label.numberOfLines = 0;
    [label sizeToFit];
    label.frame = CGRectMake(imageView.right + 10, imageView.top, WIDTHFC - 100, label.height + 20);
    [self.scrollView addSubview:label];
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
