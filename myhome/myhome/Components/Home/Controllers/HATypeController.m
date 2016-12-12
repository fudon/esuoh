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
    
    
    FSCyclicView *cycView = [[FSCyclicView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
    cycView.imageList = @[[UIImage imageNamed:@"home_backImage"],[UIImage imageNamed:@"homeTest_placeholder"],[UIImage imageNamed:@"homeTest_image"]];
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
