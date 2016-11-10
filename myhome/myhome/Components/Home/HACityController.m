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
    self.navigationItem.rightBarButtonItem = [FSViewManager bbiWithSystemType:UIBarButtonSystemItemSearch target:self action:@selector(searchCity)];
    
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

- (void)searchCity
{
    
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
    [FuData showMessage:title];
    
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
             @{@"common_name":@"热点",
               @"data_list":@[
                       @{@"name":@"北京"},
                       @{@"name":@"深圳"},
                       @{@"name":@"上海"},
                       @{@"name":@"广州"},
                       @{@"name":@"杭州"},
                       @{@"name":@"天津"},
                       @{@"name":@"南京"},
                       @{@"name":@"成都"},
                       @{@"name":@"郑州"},
                       @{@"name":@"武汉"},
                       @{@"name":@"厦门"},
                       @{@"name":@"苏州"},
                       @{@"name":@"东莞"},
                       @{@"name":@"长沙"},
                       @{@"name":@"重庆"},
                       @{@"name":@"三亚"},
                       @{@"name":@"宁波"},
                       @{@"name":@"珠海"},
                       ]},
             
             @{@"common_name":@"A",
               @"data_list":@[
                       @{@"name":@"鞍山"},
                       @{@"name":@"安阳"},
                       @{@"name":@"安庆"},
                       @{@"name":@"安康"},
                       @{@"name":@"安顺"},
                       @{@"name":@"阿坝"},
                       @{@"name":@"阿克苏"},
                       @{@"name":@"阿里"},
                       @{@"name":@"阿拉尔"},
                       @{@"name":@"阿拉善盟"},
                       @{@"name":@"澳门"},
                       ]},
             
             @{@"common_name":@"B",
               @"data_list":@[
                       @{@"name":@"包头"},
                       @{@"name":@"蚌埠"},
                       @{@"name":@"北海"},
                       @{@"name":@"保定"},
                       @{@"name":@"滨州"},
                       @{@"name":@"宝鸡"},
                       @{@"name":@"本溪"},
                       @{@"name":@"巴音郭楞"},
                       @{@"name":@"巴中"},
                       @{@"name":@"巴彦淖尔市"},
                       @{@"name":@"亳州"},
                       @{@"name":@"白银"},
                       @{@"name":@"白城"},
                       @{@"name":@"百色"},
                       @{@"name":@"白山"},
                       @{@"name":@"博尔塔拉"},
                       @{@"name":@"毕节"},
                       @{@"name":@"西双版纳"},
                       @{@"name":@"保山"},
                       ]},
             
             @{@"common_name":@"C",
               @"data_list":@[
                       @{@"name":@"长春"},
                       @{@"name":@"常德"},
                       @{@"name":@"常州"},
                       @{@"name":@"沧州"},
                       @{@"name":@"昌吉"},
                       @{@"name":@"赤峰"},
                       @{@"name":@"郴州"},
                       @{@"name":@"承德"},
                       @{@"name":@"长治"},
                       @{@"name":@"池州"},
                       @{@"name":@"滁州"},
                       @{@"name":@"朝阳"},
                       @{@"name":@"潮州"},
                       @{@"name":@"楚雄"},
                       @{@"name":@"巢湖"},
                       @{@"name":@"昌都"},
                       @{@"name":@"长葛"},
                       @{@"name":@"崇左"},
                       ]},
             
             @{@"common_name":@"D",
               @"data_list":@[
                       @{@"name":@"大连"},
                       @{@"name":@"丹东"},
                       @{@"name":@"大理"},
                       @{@"name":@"德阳"},
                       @{@"name":@"德州"},
                       @{@"name":@"东营"},
                       @{@"name":@"大庆"},
                       @{@"name":@"大同"},
                       @{@"name":@"达州"},
                       @{@"name":@"大丰"},
                       @{@"name":@"德宏"},
                       @{@"name":@"定州"},
                       @{@"name":@"迪庆"},
                       @{@"name":@"定西"},
                       @{@"name":@"大兴安岭"},
                       ]},
             
             @{@"common_name":@"E",
               @"data_list":@[
                       @{@"name":@"鄂尔多斯"},
                       @{@"name":@"恩施"},
                       @{@"name":@"鄂州"},
                       ]},
             
             @{@"common_name":@"F",
               @"data_list":@[
                       @{@"name":@"福州"},
                       @{@"name":@"佛山"},
                       @{@"name":@"阜阳"},
                       @{@"name":@"抚顺"},
                       @{@"name":@"阜新"},
                       @{@"name":@"抚州"},
                       @{@"name":@"防城港"},
                       ]},
             
             @{@"common_name":@"G",
               @"data_list":@[
                       @{@"name":@"贵阳"},
                       @{@"name":@"赣州"},
                       @{@"name":@"桂林"},
                       @{@"name":@"广安"},
                       @{@"name":@"贵港"},
                       @{@"name":@"广元"},
                       @{@"name":@"甘孜"},
                       @{@"name":@"甘南"},
                       @{@"name":@"馆陶"},
                       @{@"name":@"果洛"},
                       @{@"name":@"固原"},
                       ]},
             
             @{@"common_name":@"H",
               @"data_list":@[
                       @{@"name":@"哈尔滨"},
                       @{@"name":@"合肥"},
                       @{@"name":@"海口"},
                       @{@"name":@"呼和浩特"},
                       @{@"name":@"惠州"},
                       @{@"name":@"邯郸"},
                       @{@"name":@"黄冈"},
                       @{@"name":@"淮南"},
                       @{@"name":@"黄山"},
                       @{@"name":@"鹤壁"},
                       @{@"name":@"衡阳"},
                       @{@"name":@"湖州"},
                       @{@"name":@"衡水"},
                       @{@"name":@"汉中"},
                       @{@"name":@"淮安"},
                       @{@"name":@"黄石"},
                       @{@"name":@"菏泽"},
                       @{@"name":@"怀化"},
                       @{@"name":@"淮北"},
                       @{@"name":@"葫芦岛"},
                       @{@"name":@"河源"},
                       @{@"name":@"红河"},
                       @{@"name":@"哈密"},
                       @{@"name":@"鹤岗"},
                       @{@"name":@"呼伦贝尔"},
                       @{@"name":@"海北"},
                       @{@"name":@"海东"},
                       @{@"name":@"海南"},
                       @{@"name":@"河池"},
                       @{@"name":@"黑河"},
                       @{@"name":@"和县"},
                       @{@"name":@"贺州"},
                       @{@"name":@"贺州"},
                       @{@"name":@"海拉尔"},
                       @{@"name":@"霍邱"},
                       @{@"name":@"和田"},
                       @{@"name":@"黄南"},
                       @{@"name":@"海西"},
                       ]},
             
             @{@"common_name":@"J",
               @"data_list":@[
                       @{@"name":@"济南"},
                       @{@"name":@"锦州"},
                       @{@"name":@"吉林"},
                       @{@"name":@"金华"},
                       @{@"name":@"九江"},
                       @{@"name":@"济宁"},
                       @{@"name":@"嘉兴"},
                       @{@"name":@"江门"},
                       @{@"name":@"荆门"},
                       @{@"name":@"景德镇"},
                       @{@"name":@"吉安"},
                       @{@"name":@"揭阳"},
                       @{@"name":@"晋中"},
                       @{@"name":@"焦作"},
                       @{@"name":@"晋城"},
                       @{@"name":@"荆州"},
                       @{@"name":@"佳木斯"},
                       @{@"name":@"酒泉"},
                       @{@"name":@"鸡西"},
                       @{@"name":@"济源"},
                       @{@"name":@"金昌"},
                       @{@"name":@"嘉峪关"},
                       ]},
             
             @{@"common_name":@"K",
               @"data_list":@[
                       @{@"name":@"昆明"},
                       @{@"name":@"昆山"},
                       @{@"name":@"开封"},
                       @{@"name":@"喀什"},
                       @{@"name":@"卡拉玛依"},
                       @{@"name":@"垦利"},
                       ]},
             
             @{@"common_name":@"L",
               @"data_list":@[
                       @{@"name":@"兰州"},
                       @{@"name":@"拉萨"},
                       @{@"name":@"洛阳"},
                       @{@"name":@"泸州"},
                       @{@"name":@"廊坊"},
                       @{@"name":@"柳州"},
                       @{@"name":@"莱芜"},
                       @{@"name":@"六安"},
                       @{@"name":@"丽江"},
                       @{@"name":@"临沂"},
                       @{@"name":@"聊城"},
                       @{@"name":@"连云港"},
                       @{@"name":@"丽水"},
                       @{@"name":@"娄底"},
                       @{@"name":@"乐山"},
                       @{@"name":@"辽阳"},
                       @{@"name":@"临汾"},
                       @{@"name":@"龙岩"},
                       @{@"name":@"漯河"},
                       @{@"name":@"凉山"},
                       @{@"name":@"六盘水"},
                       @{@"name":@"辽源"},
                       @{@"name":@"克孜勒苏"},
                       @{@"name":@"来宾"},
                       @{@"name":@"临沧"},
                       @{@"name":@"临夏"},
                       @{@"name":@"临猗"},
                       @{@"name":@"林芝"},
                       @{@"name":@"陇南"},
                       @{@"name":@"吕梁"},
                       ]},
             
             @{@"common_name":@"M",
               @"data_list":@[
                       @{@"name":@"牡丹江"},
                       @{@"name":@"绵阳"},
                       @{@"name":@"茂名"},
                       @{@"name":@"马鞍山"},
                       @{@"name":@"牡丹江"},
                       @{@"name":@"眉山"},
                       @{@"name":@"梅州"},
                       @{@"name":@"明港"},
                       ]},
             
             @{@"common_name":@"N",
               @"data_list":@[
                       @{@"name":@"南宁"},
                       @{@"name":@"南昌"},
                       @{@"name":@"南充"},
                       @{@"name":@"南通"},
                       @{@"name":@"南阳"},
                       @{@"name":@"宁德"},
                       @{@"name":@"内江"},
                       @{@"name":@"南平"},
                       @{@"name":@"那曲"},
                       @{@"name":@"怒江"},
                       ]},
             
             @{@"common_name":@"P",
               @"data_list":@[
                       @{@"name":@"平顶山"},
                       @{@"name":@"攀枝花"},
                       @{@"name":@"盘锦"},
                       @{@"name":@"萍乡"},
                       @{@"name":@"濮阳"},
                       @{@"name":@"莆田"},
                       @{@"name":@"普洱"},
                       @{@"name":@"平凉"},
                       ]},
             
             @{@"common_name":@"Q",
               @"data_list":@[
                       @{@"name":@"青岛"},
                       @{@"name":@"秦皇岛"},
                       @{@"name":@"泉州"},
                       @{@"name":@"曲靖"},
                       @{@"name":@"齐齐哈尔"},
                       @{@"name":@"衢州"},
                       @{@"name":@"清远"},
                       @{@"name":@"钦州"},
                       @{@"name":@"庆阳"},
                       @{@"name":@"黔东南"},
                       @{@"name":@"潜江"},
                       @{@"name":@"清徐"},
                       @{@"name":@"黔南"},
                       @{@"name":@"七台河"},
                       @{@"name":@"黔西南"},
                       ]},
             
             @{@"common_name":@"R",
               @"data_list":@[
                       @{@"name":@"日照"},
                       @{@"name":@"日喀则"},
                       @{@"name":@"瑞安"},
                       ]},

             @{@"common_name":@"S",
               @"data_list":@[
                       @{@"name":@"石家庄"},
                       @{@"name":@"沈阳"},
                       @{@"name":@"韶关"},
                       @{@"name":@"绍兴"},
                       @{@"name":@"汕头"},
                       @{@"name":@"十堰"},
                       @{@"name":@"三门峡"},
                       @{@"name":@"三明"},
                       @{@"name":@"商丘"},
                       @{@"name":@"宿迁"},
                       @{@"name":@"绥化"},
                       @{@"name":@"邵阳"},
                       @{@"name":@"遂宁"},
                       @{@"name":@"上饶"},
                       @{@"name":@"四平"},
                       @{@"name":@"石河子"},
                       @{@"name":@"顺德"},
                       @{@"name":@"宿州"},
                       @{@"name":@"松原"},
                       @{@"name":@"沭阳"},
                       @{@"name":@"石嘴山"},
                       @{@"name":@"随州"},
                       @{@"name":@"朔州"},
                       @{@"name":@"汕尾"},
                       @{@"name":@"三沙"},
                       @{@"name":@"商洛"},
                       @{@"name":@"山南"},
                       @{@"name":@"神农架"},
                       @{@"name":@"双鸭山"},
                       ]},
             
             @{@"common_name":@"T",
               @"data_list":@[
                       @{@"name":@"太原"},
                       @{@"name":@"台湾"},
                       @{@"name":@"唐山"},
                       @{@"name":@"泰州"},
                       @{@"name":@"泰安"},
                       @{@"name":@"台州"},
                       @{@"name":@"铁岭"},
                       @{@"name":@"通辽"},
                       @{@"name":@"铜陵"},
                       @{@"name":@"天水"},
                       @{@"name":@"通化"},
                       @{@"name":@"台山"},
                       @{@"name":@"铜川"},
                       @{@"name":@"吐鲁番"},
                       @{@"name":@"天门"},
                       @{@"name":@"图木舒克"},
                       @{@"name":@"桐城"},
                       @{@"name":@"铜仁"},
                       ]},
             
             @{@"common_name":@"W",
               @"data_list":@[
                       @{@"name":@"无锡"},
                       @{@"name":@"乌鲁木齐"},
                       @{@"name":@"威海"},
                       @{@"name":@"潍坊"},
                       @{@"name":@"温州"},
                       @{@"name":@"芜湖"},
                       @{@"name":@"梧州"},
                       @{@"name":@"渭南"},
                       @{@"name":@"乌海"},
                       @{@"name":@"文山"},
                       @{@"name":@"武威"},
                       @{@"name":@"乌兰察布"},
                       @{@"name":@"瓦房店"},
                       @{@"name":@"五家渠"},
                       @{@"name":@"武夷山"},
                       @{@"name":@"吴忠"},
                       @{@"name":@"五指山"},
                       @{@"name":@"中卫"},
                       ]},
             
             @{@"common_name":@"X",
               @"data_list":@[
                       @{@"name":@"西安"},
                       @{@"name":@"西宁"},
                       @{@"name":@"香港"},
                       @{@"name":@"徐州"},
                       @{@"name":@"襄樊"},
                       @{@"name":@"襄阳"},
                       @{@"name":@"新乡"},
                       @{@"name":@"信阳"},
                       @{@"name":@"咸阳"},
                       @{@"name":@"邢台"},
                       @{@"name":@"孝感"},
                       @{@"name":@"许昌"},
                       @{@"name":@"忻州"},
                       @{@"name":@"宣城"},
                       @{@"name":@"咸宁"},
                       @{@"name":@"兴安盟"},
                       @{@"name":@"新余"},
                       @{@"name":@"湘西"},
                       @{@"name":@"仙桃"},
                       @{@"name":@"锡林郭勒"},
                       ]},
             
             @{@"common_name":@"Y",
               @"data_list":@[
                       @{@"name":@"银川"},
                       @{@"name":@"扬州"},
                       @{@"name":@"烟台"},
                       @{@"name":@"宜昌"},
                       @{@"name":@"岳阳"},
                       @{@"name":@"阳江"},
                       @{@"name":@"永州"},
                       @{@"name":@"玉林"},
                       @{@"name":@"盐城"},
                       @{@"name":@"运城"},
                       @{@"name":@"宜春"},
                       @{@"name":@"营口"},
                       @{@"name":@"榆林"},
                       @{@"name":@"宜宾"},
                       @{@"name":@"益阳"},
                       @{@"name":@"义乌"},
                       @{@"name":@"玉溪"},
                       @{@"name":@"伊犁"},
                       @{@"name":@"阳泉"},
                       @{@"name":@"延安"},
                       @{@"name":@"鹰潭"},
                       @{@"name":@"延边"},
                       @{@"name":@"云浮"},
                       @{@"name":@"雅安"},
                       @{@"name":@"阳春"},
                       @{@"name":@"鄢陵"},
                       @{@"name":@"伊春"},
                       @{@"name":@"玉树"},
                       @{@"name":@"乐清"},
                       @{@"name":@"禹州"},
                       @{@"name":@"永新"},
                       ]},
             
             @{@"common_name":@"Z",
               @"data_list":@[
                       @{@"name":@"温州"},
                       @{@"name":@"湛江"},
                       @{@"name":@"遵义"},
                       @{@"name":@"中山"},
                       @{@"name":@"镇江"},
                       @{@"name":@"淄博"},
                       @{@"name":@"张家口"},
                       @{@"name":@"株洲"},
                       @{@"name":@"漳州"},
                       @{@"name":@"肇庆"},
                       @{@"name":@"枣庄"},
                       @{@"name":@"舟山"},
                       @{@"name":@"驻马店"},
                       @{@"name":@"自贡"},
                       @{@"name":@"资阳"},
                       @{@"name":@"周口"},
                       @{@"name":@"章丘"},
                       @{@"name":@"张家界"},
                       @{@"name":@"诸城"},
                       @{@"name":@"庄河"},
                       @{@"name":@"正定"},
                       @{@"name":@"张北"},
                       @{@"name":@"张掖"},
                       @{@"name":@"昭通"},
                       @{@"name":@"赵县"},
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
