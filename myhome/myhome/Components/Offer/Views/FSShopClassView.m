//
//  FSShopClassView.m
//  myhome
//
//  Created by FudonFuchina on 2016/12/4.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "FSShopClassView.h"
#import "FSMacro.h"

@interface FSShopClassView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView        *tableView;
@property (nonatomic,strong) UITableViewCell    *frontCell;

@end

@implementation FSShopClassView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self shopClassDesignViews];
    }
    return self;
}

- (void)setDataSource:(NSArray<NSString *> *)dataSource
{
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
        
        [_tableView reloadData];
    }
}

- (void)shopClassDesignViews
{
    _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor =  RGBCOLOR(250, 250, 250, 1);
    [self addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"shopClassCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (cell == self.frontCell) {
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor redColor];
    }else{
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = FS_TextColor_Normal;
    }
    cell.textLabel.text = @"电子产品";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor redColor];
    if (self.frontCell && self.frontCell != cell) {
        self.frontCell.backgroundColor = [UIColor whiteColor];
        self.frontCell.textLabel.textColor = FS_TextColor_Normal;
    }
    if (self.selectedBlock && self.frontCell != cell) {
        self.selectedBlock(self,indexPath.row);
    }
    self.frontCell = cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
