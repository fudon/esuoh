//
//  ARHomeController.m
//  myhome
//
//  Created by fudon on 2016/11/1.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "ARHomeController.h"

@interface ARHomeController ()

@end

@implementation ARHomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *leftBBI = [[UIBarButtonItem alloc] initWithTitle:@"北京" style:UIBarButtonItemStylePlain target:self action:@selector(leftBBIAction)];
    self.navigationItem.leftBarButtonItem = leftBBI;
    
}

- (void)leftBBIAction
{
    
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
