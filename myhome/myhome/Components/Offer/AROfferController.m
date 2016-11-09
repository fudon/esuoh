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
    
    [self addKeyboardNotificationWithBaseOn:650];
//    self.navigationItem.rightBarButtonItem = [FSViewManager bbiWithTitle:@"发布" target:self action:@selector(offerAction)];
    self.navigationItem.rightBarButtonItem = [FSViewManager bbiWithSystemType:UIBarButtonSystemItemAction target:self action:@selector(offerAction)];
    self.navigationItem.titleView = [FSViewManager segmentedControlWithTitles:@[@"发布租房",@"发布售房"] target:self action:@selector(segmentControllerAction:)];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, WIDTHFC, HEIGHTFC)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:whiteView];
    
    // 期限为月数，最低6月，从下月开始
    NSArray *texts = @[@"小区:",@"楼栋:",@"楼层:",@"房号:",@"合同面积:",@"实际面积:",@"期望月租:",@"出租期:",@"地址:",@"预约:",@"其他"];
    NSArray *units = @[@"小区名字",@"几号楼",@"几层",@"多少号",@"平方米",@"平方米",@"元",@"多少月",@"详细地址",@"预约时间",@"备注"];
    WEAKSELF(this);
    for (int x = 0; x < texts.count; x ++) {
        UILabel *label = [FSViewManager labelWithFrame:CGRectMake(10, (50 + FS_LineThickness) * x, 100, 50) text:texts[x] textColor:nil backColor:nil font:FONTFC(15) textAlignment:NSTextAlignmentLeft];
        [whiteView addSubview:label];
        if (x != texts.count - 1) {
            [whiteView addSubview:[FSViewManager seprateViewWithFrame:CGRectMake(10, label.bottom, WIDTHFC - 10, FS_LineThickness)]];
        }
        
        CGRect frame = CGRectMake(0, label.top, WIDTHFC - 5, label.height);
        if (x == 7 || x == 9) {
            FSTapLabel *tapLabel = [FSViewManager tapLabelWithFrame:frame text:units[x] textColor:RGBCOLOR(200, 200, 200, 1) backColor:nil font:FONTFC(15) textAlignment:NSTextAlignmentRight block:^(FSTapLabel *bLabel) {
                [this tapLabelAction:bLabel];
            }];
            tapLabel.tag = TAGLABEL + x;
            [whiteView addSubview:tapLabel];
        }else{
            UITextField *textField = [FSViewManager textFieldWithFrame:frame placeholder:units[x] textColor:nil backColor:nil];
            textField.font = FONTFC(15);
            textField.tag = TAGTEXTFIELD + x;
            textField.textAlignment = NSTextAlignmentRight;
            [whiteView addSubview:textField];
        }
    }
    whiteView.height = texts.count * (50 + FS_LineThickness);
    self.scrollView.contentSize = CGSizeMake(WIDTHFC, 74 + texts.count * (50 + FS_LineThickness));
}

- (void)segmentControllerAction:(UISegmentedControl *)control
{
    NSLog(@"%@",@(control.selectedSegmentIndex));
}

- (void)tapLabelAction:(FSTapLabel *)label
{
    switch (label.tag - TAGLABEL) {
        case 7:
        {
            
        }
            break;
            case 9:
        {
            
        }
            break;
        default:
            break;
    }
}

- (void)offerAction
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
