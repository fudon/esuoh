//
//  ARToolController.m
//  myhome
//
//  Created by fudon on 2016/11/1.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "ARToolController.h"
#import "FSButtonsView.h"

@interface ARToolController ()

@end

@implementation ARToolController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"装修案例";
    [self toolDesignViews];
}

- (void)bbiAction
{
    
}

- (void)toolDesignViews
{
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"微店" style:UIBarButtonItemStyleDone target:self action:@selector(bbiAction)];
    bbi.tintColor = APPCOLOR;
    self.navigationItem.rightBarButtonItem = bbi;
    
    FSButtonsView *buttons = [[FSButtonsView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 44) items:@[@"豪装",@"精装",@"简装"] normalColor:FS_TextColor_Normal selectedColor:APPCOLOR];
    [self.view addSubview:buttons];
    [buttons setClickBlock:^(FSButtonsView *bButtons, NSInteger bSelectedIndex) {
        
    }];
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
