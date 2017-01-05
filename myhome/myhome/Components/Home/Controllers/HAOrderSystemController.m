//
//  HAOrderSystemController.m
//  myhome
//
//  Created by FudonFuchina on 2017/1/5.
//  Copyright © 2017年 fuhope. All rights reserved.
//

#import "HAOrderSystemController.h"
#import "FSInputView.h"
#import "FSDatePickerView.h"

@interface HAOrderSystemController ()

@property (nonatomic,assign) NSInteger     timeInterval;

@end

@implementation HAOrderSystemController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单";
    
    [self orderDesignViews];
}

- (void)rightBBIAction
{
    [FuData call:@"17600132168"];
}

- (void)orderDesignViews
{
    UIBarButtonItem *rightBBI = [[UIBarButtonItem alloc] initWithTitle:@"电话" style:UIBarButtonItemStyleDone target:self action:@selector(rightBBIAction)];
    rightBBI.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBBI;
    
    self.scrollView.showsVerticalScrollIndicator = NO;
    NSArray *titles = @[@"您的名字",@"手机号码",@"备填"];
    NSArray *placeholders = @[@"填写您的姓名",@"填写您的手机号码",@"预留"];
    for (int x = 0; x < titles.count; x ++) {
        FSInputView *inputView = [[FSInputView alloc] initWithFrame:CGRectMake(0, 20 + 45 * x, WIDTHFC, 44)];
        inputView.backgroundColor = [UIColor whiteColor];
        inputView.label.text = titles[x];
        inputView.textField.placeholder = placeholders[x];
        inputView.textField.font = FONTFC(15);
        [self.scrollView addSubview:inputView];
        if (x == 1) {
            inputView.textField.keyboardType = UIKeyboardTypeNumberPad;
        }
    }
    
    NSArray *times = @[@"预约时间",@"房屋地点"];
    NSArray *subTimes = @[@"我们派人上门时间",@"长沙市"];
    WEAKSELF(this);
    for (int x = 0; x < times.count; x ++) {
        FSTapCell *cell = [FSViewManager tapCellWithText:times[x] textColor:FS_TextColor_Normal font:FONTFC(16) detailText:subTimes[x] detailColor:nil detailFont:FONTFC(15) block:^(FSTapCell *bCell) {
            [this cellAction:bCell];
        }];
        cell.top = 155 + 45 * x;
        cell.tag = TAGCELL + x;
        cell.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:cell];
    }
    
    UIButton *button = [FSViewManager buttonWithFrame:CGRectMake(20, 280, WIDTHFC - 40, 40) title:@"我要装修" titleColor:[UIColor whiteColor] backColor:HAAPPCOLOR fontInt:0 tag:0 target:self selector:@selector(countAction)];
    [self.scrollView addSubview:button];
}

- (void)cellAction:(FSTapCell *)cell
{
    [self.view endEditing:YES];
    switch (cell.tag - TAGCELL) {
        case 0:
        {
            WEAKSELF(this);
            __weak FSTapCell *weakCell = cell;
            FSDatePickerView *picker = [[FSDatePickerView alloc] initWithFrame:CGRectMake(0, 0, WIDTHFC, HEIGHTFC) controller:self];
            [self.view.window addSubview:picker];
            picker.block = ^ (NSDate *bDate){
                this.timeInterval = (NSInteger)[bDate timeIntervalSince1970];
                weakCell.detailTextLabel.text = [FuData readableForTimeInterval:this.timeInterval];
            };
        }
            break;
          case 1:
        {
            
        }
            break;
        default:
            break;
    }
}

- (void)countAction
{
    [FuData showMessage:@"提示收到订单就会短信回复，然后派遣人员上门勘设"];
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
