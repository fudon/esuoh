//
//  HAFlowController.m
//  myhome
//
//  Created by FudonFuchina on 2016/12/9.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "HAFlowController.h"

@interface HAFlowController ()

@property (nonatomic,strong) UITextField    *textField;

@end

@implementation HAFlowController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self flowDesignViews];
}

- (void)flowDesignViews
{
    NSLog(@"%@",self.type);
    self.title = @"查询";
    
    _textField = [FSViewManager textFieldWithFrame:CGRectMake(0, 10, WIDTHFC, 50) placeholder:@"请输入手机号" textColor:FS_TextColor_Normal backColor:[UIColor whiteColor]];
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:_textField];
    
    WEAKSELF(this);
    UIButton *button = [FSViewManager submitButtonWithTop:_textField.bottom + 20 block:^(FSBlockButton *bButton) {
        if (![FuData isValidateMobile:this.textField.text]) {
            [FuData showMessage:@"请输入正确手机号"];
            return;
        }
        NSLog(@"%@",this.textField.text);
    }];
    [self.scrollView addSubview:button];
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
