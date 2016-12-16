//
//  HATypeController.m
//  myhome
//
//  Created by FudonFuchina on 2016/12/7.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "HATypeController.h"
#import "FSCyclicView.h"

@interface HATypeController ()

@end

@implementation HATypeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self typeDesignViews];
}

- (void)typeDesignViews
{
    UIBarButtonItem *leftBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
    self.navigationItem.rightBarButtonItem = leftBBI;
    
    FSCyclicView *cycView = [[FSCyclicView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 120)];
    cycView.urls = @[@"https://image1.guazistatic.com/qn161204181714c2c67c602f1c504111f8c6b56be30f83.png",@"https://image1.guazistatic.com/qn1612041855375ac439f17e7f42ac248894e69b75b3bc.png",@"https://image1.guazistatic.com/qn161204190405452d1bad4f1e9c3b2ec2ac85d522ff5d.png",@"https://image1.guazistatic.com/qn1612041905303b2a0ac789039006182cc4915f857b45.png",@"https://image1.guazistatic.com/qn161204181714c2c67c602f1c504111f8c6b56be30f83.png",@"https://image1.guazistatic.com/qn1612041855375ac439f17e7f42ac248894e69b75b3bc.png",@"https://image1.guazistatic.com/qn161204190405452d1bad4f1e9c3b2ec2ac85d522ff5d.png"];
    [self.scrollView addSubview:cycView];
}

- (void)addAction
{
    [FuData pushToViewControllerWithClass:@"FSFutureAlertController" navigationController:self.navigationController param:nil configBlock:nil];
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
