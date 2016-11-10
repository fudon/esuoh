//
//  HACityController.m
//  myhome
//
//  Created by fudon on 2016/11/10.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "HACityController.h"
#import "FuSoft.h"

@interface HACityController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *cityArray;
@property (nonatomic,strong) NSArray *titlesArray;

@end

@implementation HACityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择城市";
    self.cityArray = [self cityArrayDataSource];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:_cityArray.count];
    for (int x = 0; x < self.cityArray.count; x ++) {
        NSDictionary *dic = self.cityArray[x];
        NSString *commonName = [dic objectForKey:@"common_name"];
        if (commonName) {
            [array addObject:commonName];
        }
    }
    _titlesArray = array;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTHFC, HEIGHTFC - 64) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.sectionIndexColor = RGBCOLOR(34, 172, 56, 1);
    tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    [self.view addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cityArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dic = self.cityArray[section];
    NSArray *array = [dic objectForKey:@"data_list"];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"selectCityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.font = FONTFC(14);
//        cell.textLabel.textColor = GZS_TextColor_Normal;
    }
    
    NSDictionary *dic = self.cityArray[indexPath.section];
    NSArray *array = [dic objectForKey:@"data_list"];
    if (dic) {
        cell.textLabel.text = [array[indexPath.row] objectForKey:@"name"];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dic = self.cityArray[section];
    return [dic objectForKey:@"common_name"];
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.titlesArray;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
//    _latterLabel.alpha = 1.0;
//    _latterLabel.text = title;
    [self performSelector:@selector(selectCityPageShowZimuRemove) withObject:nil afterDelay:1.0];
    
    return index;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.cityArray[indexPath.section];
    NSArray *array = [dic objectForKey:@"data_list"];
//    if (_block) {
//        _block(self,array[indexPath.row]);
//    }
}

- (void)selectCityPageShowZimuRemove{
    WEAKSELF(weakSelf);
    [UIView animateWithDuration:0.5 animations:^{
//        weakSelf.latterLabel.alpha = 0;
    }];
}

- (NSArray *)cityArrayDataSource//https://zhidao.baidu.com/question/368493711.html
{
    return @[
             @{@"common_name":@"A",
               @"data_list":@[
                       @{@"name":@"澳门"},
                       ]},
             
             @{@"common_name":@"B",
               @"data_list":@[
                       @{@"name":@"北京"},
                       ]},
             
             @{@"common_name":@"C",
               @"data_list":@[
                       @{@"name":@"成都"},
                       @{@"name":@"长春"},
                       @{@"name":@"长沙"},
                       @{@"name":@"重庆"},
                       ]},
             
             @{@"common_name":@"D",
               @"data_list":@[
                       @{@"name":@"安徽"},
                       ]},
             
             @{@"common_name":@"E",
               @"data_list":@[
                       @{@"name":@"安徽"},
                       ]},
             
             @{@"common_name":@"F",
               @"data_list":@[
                       @{@"name":@"福州"},
                       ]},
             
             @{@"common_name":@"G",
               @"data_list":@[
                       @{@"name":@"广州"},
                       @{@"name":@"贵阳"},
                       ]},
             
             @{@"common_name":@"H",
               @"data_list":@[
                       @{@"name":@"哈尔滨"},
                       @{@"name":@"杭州"},
                       @{@"name":@"合肥"},
                       @{@"name":@"海口"},
                       @{@"name":@"呼和浩特"},
                       ]},
             
             @{@"common_name":@"I",
               @"data_list":@[
                       @{@"name":@"安徽"},
                       ]},
             
             @{@"common_name":@"J",
               @"data_list":@[
                       @{@"name":@"济南"},
                       ]},
             
             @{@"common_name":@"K",
               @"data_list":@[
                       @{@"name":@"昆明"},
                       ]},
             
             @{@"common_name":@"L",
               @"data_list":@[
                       @{@"name":@"兰州"},
                       @{@"name":@"拉萨"},
                       ]},
             
             @{@"common_name":@"M",
               @"data_list":@[
                       @{@"name":@"安徽"},
                       ]},
             
             @{@"common_name":@"N",
               @"data_list":@[
                       @{@"name":@"南宁"},
                       @{@"name":@"南京"},
                       @{@"name":@"南昌"},
                       ]},
             
             @{@"common_name":@"O",
               @"data_list":@[
//                       @{@"name":@"安徽"},
                       ]},
             
             @{@"common_name":@"P",
               @"data_list":@[
//                       @{@"name":@"安徽"},
                       ]},
             
             @{@"common_name":@"Q",
               @"data_list":@[
//                       @{@"name":@"安徽"},
                       ]},
             
             @{@"common_name":@"R",
               @"data_list":@[
//                       @{@"name":@"安徽"},
                       ]},
             
             @{@"common_name":@"S",
               @"data_list":@[
                       @{@"name":@"深圳"},
                       @{@"name":@"石家庄"},
                       @{@"name":@"沈阳"},
                       @{@"name":@"上海"},
                       ]},
             
             @{@"common_name":@"T",
               @"data_list":@[
                       @{@"name":@"太原"},
                       @{@"name":@"台北"},
                       @{@"name":@"天津"},
                       ]},
             
             @{@"common_name":@"U",
               @"data_list":@[
                       @{@"name":@"安徽"},
                       ]},
             
             @{@"common_name":@"V",
               @"data_list":@[
                       @{@"name":@"安徽"},
                       ]},
             
             @{@"common_name":@"W",
               @"data_list":@[
                       @{@"name":@"武汉"},
                       @{@"name":@"乌鲁木齐"},
                       ]},
             
             @{@"common_name":@"X",
               @"data_list":@[
                       @{@"name":@"西安"},
                       @{@"name":@"西宁"},
                       @{@"name":@"香港"},
                       ]},
             
             @{@"common_name":@"Y",
               @"data_list":@[
                       @{@"name":@"银川"},
                       ]},
             
             @{@"common_name":@"Z",
               @"data_list":@[
                       @{@"name":@"郑州"},
                       ]},
             ];
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
