//
//  FSSetController.m
//  myhome
//
//  Created by FudonFuchina on 2016/12/19.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "FSSetController.h"
#import "FSCacheManager.h"

@interface FSSetController ()

@property (nonatomic,strong) FSTapCell  *cell;

@end

@implementation FSSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self setDesignViews];
}

- (void)setDesignViews
{
    WEAKSELF(this);
    _cell = [FSViewManager tapCellWithText:@"清除缓存" textColor:FS_TextColor_Normal detailColor:APPCOLOR font:FONTFC(15) detailFont:FONTFC(14) block:^(FSTapCell *bCell) {
        [this showWaitView:YES];
        [FSCacheManager clearAllCache:^{
            [this showWaitView:NO];
            [FuData showMessage:@"清除成功"];
            this.cell.detailTextLabel.text = @"";
        }];
    }];
    _cell.top = 20;
    _cell.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:_cell];
    
    [FSCacheManager allCacheSize:^(NSUInteger bResult) {
        NSString *cache = [FuData KMGUnit:bResult];
        this.cell.detailTextLabel.text = cache;
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
