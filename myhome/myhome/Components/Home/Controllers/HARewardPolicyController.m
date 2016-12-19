//
//  HARewardPolicyController.m
//  myhome
//
//  Created by FudonFuchina on 2016/12/9.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "HARewardPolicyController.h"
#import "FSShareView.h"

@interface HARewardPolicyController ()

@end

@implementation HARewardPolicyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"奖励政策";
    [self policyDesignViews];
}

- (void)bbiAction
{
    UIImage *image = IMAGENAMED(@"home_backImage");
    FSShareView *shareView = [[FSShareView alloc] initWithFrame:[UIScreen mainScreen].bounds list:@[@(FSShareTypeWechat),@(FSShareTypeQQ),@(FSShareTypeWeibo),@(FSShareTypeEmail),@(FSShareTypeMessage)] controller:self title:@"Title" detail:@"Detail" url:@"https://www.baidu.com" thumbImage:[UIImage new] recipientsOfMail:nil recipientsOfMessage:@[@"15201201688"] fileData:UIImageJPEGRepresentation(image, 1.0) fileName:@"图片" fileType:@"image/jpeg" result:^(NSString *bResult) {
        [FuData showMessage:bResult];
    }];
    [self.navigationController.tabBarController.view addSubview:shareView];
}

- (void)policyDesignViews
{
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(bbiAction)];
    bbi.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = bbi;
    
    UILabel *timeLabel = [FSViewManager labelWithFrame:CGRectMake(WIDTHFC / 4, 30, WIDTHFC / 2, 30) text:@"2016年12月14日 22:25" textColor:[UIColor whiteColor] backColor:RGBCOLOR(220, 220, 220, 1) font:FONTFC(14) textAlignment:NSTextAlignmentCenter];
    [self.scrollView addSubview:timeLabel];
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, timeLabel.bottom + 30, 30, 30)];
    imageView.image = IMAGENAMED(@"deviceInfo");
    [self.scrollView addSubview:imageView];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(imageView.right + 15, imageView.top, WIDTHFC - 120, 300)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:whiteView];
    
    UILabel *label = [FSViewManager labelWithFrame:CGRectMake(10, 5, whiteView.width - 20, whiteView.height - 10) text:@"尊敬的用户:\n\t从即日起，我们将对用户的推荐活动给予奖励：\n\n\t推荐简装客户，奖励2000元/人；\n\t推荐精装客户，奖励5000元/人；\n\t推荐豪装客户，奖励1万元/人。\n\n\t奖金将在客户完成装修后兑付;同时被推荐的客户减免等额的费用。\n\t呼朋唤友，对我说【我要推荐】" textColor:[UIColor blackColor] backColor:[UIColor whiteColor] font:FONTFC(14) textAlignment:NSTextAlignmentLeft];
    label.numberOfLines = 0;
    [label sizeToFit];
    label.frame = CGRectMake(10, 10, whiteView.width - 20,label.height);
    [whiteView addSubview:label];
    whiteView.height = label.height + 20;
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
