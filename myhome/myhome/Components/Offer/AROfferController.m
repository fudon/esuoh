//
//  AROfferController.m
//  myhome
//
//  Created by fudon on 2016/11/1.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "AROfferController.h"
#import "FSViewManager.h"

@interface AROfferController ()

@end

@implementation AROfferController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布";
    
    NSArray *texts = @[@"小区",@"楼栋",@"楼层",@"合同面积",@"实际面积",@"",@"",@"",@"",@""];
    NSArray *units = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
    for (int x = 0; x < texts.count; x ++) {
        UILabel *label = [FSViewManager labelWithFrame:CGRectMake(10, 10 + 40.5 * x, 100, 40) text:texts[x] textColor:[UIColor lightGrayColor] backColor:nil font:FONTFC(14) textAlignment:NSTextAlignmentLeft];
        [self.scrollView addSubview:label];
        [self.scrollView addSubview:[FSViewManager seprateViewWithFrame:CGRectMake(0, label.bottom, WIDTHFC - 10, FS_LineThickness)]];
    }
    
    
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
