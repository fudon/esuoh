//
//  HAToolController.m
//  myhome
//
//  Created by FudonFuchina on 2016/12/3.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "HAToolController.h"
#import "FSQRController.h"
#import "FSImageLabelView.h"
#import "FSHardwareInfoController.h"
#import "FSAccessController.h"
#import "FSSameKindController.h"
#import "FSChineseCalendarController.h"
#import "FSStoreManager.h"
#import "FSFutureAlertController.h"
#import "FSMoveLabel.h"
#import "FSWSKController.h"
#import "BankNumberController.h"
#import "HoldViewController.h"
#import "FSBirthdayController.h"
#import "FSHTMLController.h"
#import "FSPdf.h"
#import "FSPartListController.h"
#import "FSLocationController.h"

@interface HAToolController ()

@property (nonatomic,strong) FSMoveLabel    *moveLabel;
@property (nonatomic,assign) BOOL           birthday;

@end

@implementation HAToolController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self checkFutureAlerts];
    });    
    [self checkBirthday];
}

- (void)checkBirthday
{
    NSArray *birthdays = [FSBirthdayController todayBirthdays];
    if (birthdays.count) {
        NSMutableString *title = [[NSMutableString alloc] initWithString:@"今天"];
        for (NSArray *array in birthdays) {
            [title appendFormat:@"%@、",array[0]];
        }
        [title deleteCharactersInRange:NSMakeRange(title.length - 1, 1)];
        [title appendFormat:@"过生日"];
        
        if (!_birthday) {
            _birthday = YES;
            WEAKSELF(this);
            [FuData alertViewWithTitle:title message:@"快去看看吧" btnTitle:@"查看" handler:^(UIAlertAction *action) {
                Class ControllerClass = NSClassFromString(@"FSBirthdayController");
                if (ControllerClass) {
                    [this.navigationController pushViewController:[[ControllerClass alloc] init] animated:YES];
                }
            } cancelTitle:@"取消" handler:nil completion:nil];
        }else{
            [FuData showMessage:title];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIApplication *application = [UIApplication sharedApplication];
    if (application.applicationIconBadgeNumber) {
        application.applicationIconBadgeNumber = 0;
    }
    
    self.title = @"小程序";
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"反馈" style:UIBarButtonItemStyleDone target:self action:@selector(bbiAction)];
    bbi.tintColor = APPCOLOR;
    self.navigationItem.rightBarButtonItem = bbi;
    
    NSArray *array = @[@"二维码",@"设备信息",@"导航",@"计算器",@"提醒",@"目录",@"五十K",@"银行卡号",@"农历",@"定位",@"十句话",@"知识"];
    NSArray *picArray = @[@"saoma_too",@"deviceInfo",@"navigation_web",@"apps_counter",@"apps_alert",@"apps_write",@"apps_puke",@"apps_bank",@"apps_nongli",@"apps_dingwei",@"apps_tenword",@"apps_write"];
    
    CGFloat width = (WIDTHFC - 100) / 4;
    WEAKSELF(this);
    for (int x = 0; x < array.count; x ++) {
        FSImageLabelView *imageView = [FSImageLabelView imageLabelViewWithFrame:CGRectMake(20 + (x % 4) * (width + 20), 10 + (x / 4) * (width + 45), width, width + 25) imageName:picArray[x] text:array[x]];
        imageView.block = ^ (FSImageLabelView *bImageLabelView){
            [this actionForType:bImageLabelView.tag];
        };
        imageView.tag = TAGIMAGEVIEW + x;
        [self.scrollView addSubview:imageView];
    }
}

- (void)checkFutureAlerts
{
    [FSFutureAlertController futureSevenDaysTODO:^(NSInteger bCount) {
        if (bCount) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *message = [[NSString alloc] initWithFormat:@"未来一周内您有%@件待办事项，点击「提醒」查看",@(bCount)];
                if (!_moveLabel) {
                    _moveLabel = [[FSMoveLabel alloc] initWithFrame:CGRectMake(0, self.view.height - 44 - 49, WIDTHFC, 44)];
                    _moveLabel.backgroundColor = HAAPPCOLOR;
                    [self.view addSubview:_moveLabel];
                    WEAKSELF(this);
                    [_moveLabel setTapBlock:^(FSMoveLabel *bLabel) {
                        [FuData pushToViewControllerWithClass:@"FSFutureAlertController" navigationController:this.navigationController param:nil configBlock:nil];
                    }];
                }
                _moveLabel.text = message;
            });
        }else{
            [_moveLabel removeFromSuperview];
            _moveLabel = nil;
        }
    }];
}

- (void)qiniuAction
{
    NSData *data = [@"china" dataUsingEncoding:NSUTF8StringEncoding];
    [FSStoreManager uploadUTF8Data:data key:@"china" completion:^{
        
    }];
}

- (void)bbiAction
{
    [FuData alertViewWithTitle:@"想要什么小功能?" message:@"开发一些简单有用的小工具" btnTitle:@"有想法" handler:^(UIAlertAction *action) {
        
    } cancelTitle:@"再想想" handler:nil completion:nil];
}

- (void)actionForType:(NSInteger)type
{
    switch (type - TAGIMAGEVIEW) {
        case 0:
        {
            WEAKSELF(this);
            [FuData actionSheet2WithTitle:@"操作方式" firstTitle:@"扫描二维码" style:UIAlertActionStyleDefault firstHandler:^(UIAlertAction *action) {
                FSQRController *qrController = [[FSQRController alloc] init];
                [this.navigationController pushViewController:qrController animated:YES];
            } secondTitle:@"生成二维码" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [FuData pushToViewControllerWithClass:@"FSMakeQRController" navigationController:self.navigationController param:nil configBlock:nil];
            } cancelHandler:nil completion:nil];
        }
            break;
        case 1:
        {
            FSHardwareInfoController *hwController = [[FSHardwareInfoController alloc] init];
            [self.navigationController pushViewController:hwController animated:YES];
        }
            break;
        case 2:
        {
            FSPartListController *plController = [[FSPartListController alloc] init];
            plController.title = @"分类网站";
            plController.dataList = [self configDatas];
            [self.navigationController pushViewController:plController animated:YES];
        }
            break;
        case 3:
        {
            FSAccessController *access = [[FSAccessController alloc] init];
            access.title = @"计算工具";
            access.datas = @[@{Picture_Name:@"a_4",Text_Name:@"记账本",Url_String:@"http://xw.qq.com"},
                             @{Picture_Name:@"my_history",Text_Name:@"贷款计算器",Url_String:@"http://3g.163.com"},
                             @{Picture_Name:@"tootoodingdan",Text_Name:@"个税计算器",Url_String:@"http://3g.163.com"},
                             @{Picture_Name:@"tootoodingdan",Text_Name:@"首付计算器",Url_String:@"http://3g.163.com"},
                             @{Picture_Name:@"tootoodingdan",Text_Name:@"计算器",Url_String:@"http://3g.163.com"},
                             @{Picture_Name:@"tootoodingdan",Text_Name:@"新账本",Url_String:@"http://3g.163.com"},
                             ];
            WEAKSELF(this);
            access.selectBlock = ^ (FSAccessController *bController,NSIndexPath *bIndexPath){
                NSArray *classArray = @[@"FSAccountDoorController",@"FSLoanCounterController",@"FSTaxOfIncomeController",@"FSHouseLoanController",@"FSCalculatorController",@"FSAccountsController"];
                Class ControllerClass = NSClassFromString(classArray[bIndexPath.row % classArray.count]);
                if (ControllerClass) {
                    [this.navigationController pushViewController:[[ControllerClass alloc] init] animated:YES];
                }
            };
            [self.navigationController pushViewController:access animated:YES];
        }
            break;
        case 4:
        {
            FSAccessController *access = [[FSAccessController alloc] init];
            access.title = @"提醒";
            access.datas = @[@{Picture_Name:@"a_4",Text_Name:@"待办提醒",Url_String:@"http://xw.qq.com"},
                             @{Picture_Name:@"my_history",Text_Name:@"生日提醒",Url_String:@"http://3g.163.com"},
                             ];
            WEAKSELF(this);
            access.selectBlock = ^ (FSAccessController *bController,NSIndexPath *bIndexPath){
                NSArray *classArray = @[@"FSFutureAlertController",@"FSBirthdayController"];
                Class ControllerClass = NSClassFromString(classArray[bIndexPath.row % classArray.count]);
                if (ControllerClass) {
                    [this.navigationController pushViewController:[[ControllerClass alloc] init] animated:YES];
                }
            };
            [self.navigationController pushViewController:access animated:YES];
        }
            break;
            case 5:
        {
            [FuData pushToViewControllerWithClass:@"FSAppDocumentController" navigationController:self.navigationController param:nil configBlock:nil];
        }
            break;
            case 6:
        {
            FSWSKController *wsk = [[FSWSKController alloc] init];
            [self.navigationController pushViewController:wsk animated:YES];
        }
            break;
            case 7:
        {
            BankNumberController *bank = [[BankNumberController alloc] init];
            [self.navigationController pushViewController:bank animated:YES];
        }
            break;
        case 8:
        {
            FSChineseCalendarController *ccController = [[FSChineseCalendarController alloc] init];
            [self.navigationController pushViewController:ccController animated:YES];
        }
            break;
            case 9:
        {
            FSLocationController *location = [[FSLocationController alloc] init];
            [self.navigationController pushViewController:location animated:YES];
        }
            break;
            case 10:
            case 11:
        {
            HoldViewController *hold = [[HoldViewController alloc] init];
            hold.first = YES;
            [self.navigationController pushViewController:hold animated:YES];
            WEAKSELF(this);
            [hold setBtnClickCallback:^{
                FSAccessController *access = [[FSAccessController alloc] init];
                access.title = @"学习";
                access.datas = @[@{Picture_Name:@"a_4",Text_Name:@"感悟",Url_String:@"http://xw.qq.com"},
                                 @{Picture_Name:@"my_history",Text_Name:@"数据",Url_String:@"http://3g.163.com"},
                                 @{Picture_Name:@"my_history",Text_Name:@"备用",Url_String:@"http://3g.163.com"},
                                 ];
                access.selectBlock = ^ (FSAccessController *bController,NSIndexPath *bIndexPath){
                    NSArray *paths = @[@"/Users/fudonfuchina/Desktop/data/life.txt",@"/Users/fudonfuchina/Desktop/data/pwd.txt"];
                    NSArray *fileP = @[@"life.pdf",@"pwd.pdf"];
                    NSString *content = [[NSString alloc] initWithContentsOfFile:paths[bIndexPath.row] encoding:NSUTF8StringEncoding error:nil];
                    NSString *filePath = [FuData documentsPath:fileP[bIndexPath.row]];
                    if (content.length > 10) {
                        NSString *path = [FSPdf pdfForString:content pdfName:fileP[bIndexPath.row]];
                        [FuData copyFile:path toPath:filePath];
                    }
                    FSHTMLController *webController = [[FSHTMLController alloc] init];
                    webController.localUrlString = filePath;
                    webController.title = fileP[bIndexPath.row];
                    [this.navigationController pushViewController:webController animated:YES];
                    if (bIndexPath.row == 1) {
                        [webController setPopBlock:^(FSBaseController *bVC) {
                            [this.navigationController popToRootViewControllerAnimated:NO];
                            this.navigationController.tabBarController.selectedIndex = 3;
                        }];
                    }
                };
                [this.navigationController pushViewController:access animated:YES];
            }];
        }
            break;
        default:
            break;
    }
}

- (NSArray *)configDatas
{
    NSArray *confitDatas = @[
                             @{
                                 @"text":@"购物消费",
                                 @"array":@[
                                         @{Picture_Name:@"snlogo.jpg",Text_Name:@"天猫",Url_String:@"https://m.tmall.com"},
                                         @{Picture_Name:@"jdlogo",Text_Name:@"京东商城",Url_String:@"http://m.jd.com"},
                                         @{Picture_Name:@"tblogo",Text_Name:@"淘宝",Url_String:@"https://m.taobao.com"},
                                         @{Picture_Name:@"snlogo.jpg",Text_Name:@"亚马逊",Url_String:@"https://www.amazon.cn"},
                                         @{Picture_Name:@"gmlogo.jpg",Text_Name:@"国美电器",Url_String:@"http://m.gome.com.cn"},
                                         @{Picture_Name:@"snlogo.jpg",Text_Name:@"苏宁易购",Url_String:@"http://m.suning.com"},
                                         @{Picture_Name:@"snlogo.jpg",Text_Name:@"唯品会",Url_String:@"http://m.vip.com"},
                                         @{Picture_Name:@"snlogo.jpg",Text_Name:@"1688",Url_String:@"http://m.1688.com"},
                                         @{Picture_Name:@"snlogo.jpg",Text_Name:@"聚美优品",Url_String:@"http://m.jumei.com"},
                                         @{Picture_Name:@"snlogo.jpg",Text_Name:@"一号店",Url_String:@"http://m.yhd.com"},
                                         @{Picture_Name:@"snlogo.jpg",Text_Name:@"蘑菇街",Url_String:@"http://m.mogujie.com"},
                                         @{Picture_Name:@"snlogo.jpg",Text_Name:@"酒仙网",Url_String:@"http://m.jiuxian.com"},
                                         @{Picture_Name:@"snlogo.jpg",Text_Name:@"小米官网",Url_String:@"http://m.mi.com"},
                                         ],
                                 },
                             
                             @{
                                 @"text":@"生活服务",
                                 @"array":@[
                                         @{Picture_Name:@"snlogo.jpg",Text_Name:@"美团",Url_String:@"http://i.meituan.com"},
                                         @{Picture_Name:@"snlogo.jpg",Text_Name:@"百度外卖",Url_String:@"http://waimai.baidu.com"},
                                         @{Picture_Name:@"snlogo.jpg",Text_Name:@"饿了么",Url_String:@"http://m.ele.me"},
                                         @{Picture_Name:@"snlogo.jpg",Text_Name:@"百度糯米",Url_String:@"https://m.nuomi.com"},
                                         @{Picture_Name:@"snlogo.jpg",Text_Name:@"大众点评",Url_String:@"http://m.dianping.com"},
                                         @{Picture_Name:@"snlogo.jpg",Text_Name:@"58同城",Url_String:@"http://m.58.com"},
                                         @{Picture_Name:@"snlogo.jpg",Text_Name:@"赶集网",Url_String:@"http://m.ganji.com"},
                                         ],
                                 },
                             
                             @{
                                 @"text":@"新闻信息",
                                 @"array":@[
                                           @{Picture_Name:@"tblogo",Text_Name:@"腾讯新闻",Url_String:@"http://xw.qq.com"},
                                           @{Picture_Name:@"jdlogo",Text_Name:@"网易",Url_String:@"http://3g.163.com"},
                                           @{Picture_Name:@"snlogo.jpg",Text_Name:@"新浪新闻",Url_String:@"http://www.sina.cn"},
                                           @{Picture_Name:@"snlogo.jpg",Text_Name:@"新浪博客",Url_String:@"http://blog.sina.cn"},
                                           @{Picture_Name:@"snlogo.jpg",Text_Name:@"新浪微博",Url_String:@"http://www.weibo.com"},
                                           @{Picture_Name:@"gmlogo.jpg",Text_Name:@"搜狐",Url_String:@"http://www.sohu.com"},
                                           @{Picture_Name:@"snlogo.jpg",Text_Name:@"凤凰",Url_String:@"http://i.ifeng.com"},
                                           @{Picture_Name:@"snlogo.jpg",Text_Name:@"简书",Url_String:@"http://www.jianshu.com"},
                                         ]
                                 },
                             
                             @{
                                 @"text":@"影视娱乐",
                                 @"array":@[
                                            @{Picture_Name:@"tblogo",Text_Name:@"优酷",Url_String:@"http://www.youku.com"},
                                            @{Picture_Name:@"jdlogo",Text_Name:@"爱奇艺",Url_String:@"http://m.iqiyi.com"},
                                            @{Picture_Name:@"snlogo.jpg",Text_Name:@"腾讯视频",Url_String:@"http://m.v.qq.com"},
                                            @{Picture_Name:@"snlogo.jpg",Text_Name:@"乐视视频",Url_String:@"http://m.le.com"},
                                            ],
                                 },
                             
                             @{
                                 @"text":@"搜索引擎",
                                 @"array":  @[@{Picture_Name:@"tblogo",Text_Name:@"hao123",Url_String:@"https://www.hao123.com"},
                                              @{Picture_Name:@"jdlogo",Text_Name:@"百度",Url_String:@"https://www.baidu.com"},
                                              ]
                                 }
                             ];
    return confitDatas;
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
