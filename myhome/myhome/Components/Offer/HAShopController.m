//
//  HAShopController.m
//  myhome
//
//  Created by FudonFuchina on 2016/11/30.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "HAShopController.h"
#import "FSShopClassView.h"
#import "HAShopCollectionCell.h"
#import <UIImageView+WebCache.h>

static NSString *const  collectionCellID = @"shopCollectionCell";

@interface HAShopController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView   *collectionView;
@property (nonatomic,strong) NSArray            *dataSource;

@end

@implementation HAShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"家装";
    [self shopHandleDatas];
}

- (void)shopHandleDatas
{
    self.dataSource = @[@"https://image.guazistatic.com/gz01161220/11/11/6cb40a85a8411864451d1f5534c5e813.jpg",@"https://image1.guazistatic.com/qn1612041855375ac439f17e7f42ac248894e69b75b3bc.png",@"https://image1.guazistatic.com/qn161204190405452d1bad4f1e9c3b2ec2ac85d522ff5d.png",@"https://image1.guazistatic.com/qn1612041905303b2a0ac789039006182cc4915f857b45.png",@"https://image1.guazistatic.com/qn161204181714c2c67c602f1c504111f8c6b56be30f83.png",@"https://image1.guazistatic.com/qn1612041855375ac439f17e7f42ac248894e69b75b3bc.png",@"https://image1.guazistatic.com/qn161204190405452d1bad4f1e9c3b2ec2ac85d522ff5d.png",@"https://image1.guazistatic.com/qn1612041905303b2a0ac789039006182cc4915f857b45.png",@"https://image1.guazistatic.com/qn161204181714c2c67c602f1c504111f8c6b56be30f83.png",@"https://image1.guazistatic.com/qn1612041855375ac439f17e7f42ac248894e69b75b3bc.png",@"https://image1.guazistatic.com/qn161204190405452d1bad4f1e9c3b2ec2ac85d522ff5d.png",@"https://image1.guazistatic.com/qn1612041905303b2a0ac789039006182cc4915f857b45.png",@"https://image1.guazistatic.com/qn161204181714c2c67c602f1c504111f8c6b56be30f83.png",@"https://image1.guazistatic.com/qn1612041855375ac439f17e7f42ac248894e69b75b3bc.png",@"https://image1.guazistatic.com/qn161204190405452d1bad4f1e9c3b2ec2ac85d522ff5d.png",@"https://image1.guazistatic.com/qn1612041905303b2a0ac789039006182cc4915f857b45.png",@"https://image1.guazistatic.com/qn161204181714c2c67c602f1c504111f8c6b56be30f83.png",@"https://image1.guazistatic.com/qn1612041855375ac439f17e7f42ac248894e69b75b3bc.png",@"https://image1.guazistatic.com/qn161204190405452d1bad4f1e9c3b2ec2ac85d522ff5d.png",@"https://image1.guazistatic.com/qn1612041905303b2a0ac789039006182cc4915f857b45.png",@"https://image1.guazistatic.com/qn161204181714c2c67c602f1c504111f8c6b56be30f83.png",@"https://image1.guazistatic.com/qn1612041855375ac439f17e7f42ac248894e69b75b3bc.png",@"https://image1.guazistatic.com/qn161204190405452d1bad4f1e9c3b2ec2ac85d522ff5d.png",@"https://image1.guazistatic.com/qn1612041905303b2a0ac789039006182cc4915f857b45.png",@"https://image1.guazistatic.com/qn161204181714c2c67c602f1c504111f8c6b56be30f83.png",@"https://image1.guazistatic.com/qn1612041855375ac439f17e7f42ac248894e69b75b3bc.png",@"https://image1.guazistatic.com/qn161204190405452d1bad4f1e9c3b2ec2ac85d522ff5d.png",@"https://image1.guazistatic.com/qn1612041905303b2a0ac789039006182cc4915f857b45.png",@"https://image1.guazistatic.com/qn161204181714c2c67c602f1c504111f8c6b56be30f83.png",@"https://image1.guazistatic.com/qn1612041855375ac439f17e7f42ac248894e69b75b3bc.png",@"https://image1.guazistatic.com/qn161204190405452d1bad4f1e9c3b2ec2ac85d522ff5d.png",@"https://image1.guazistatic.com/qn1612041905303b2a0ac789039006182cc4915f857b45.png",@"https://image1.guazistatic.com/qn161204181714c2c67c602f1c504111f8c6b56be30f83.png",@"https://image1.guazistatic.com/qn1612041855375ac439f17e7f42ac248894e69b75b3bc.png",@"https://image1.guazistatic.com/qn161204190405452d1bad4f1e9c3b2ec2ac85d522ff5d.png",@"https://image1.guazistatic.com/qn1612041905303b2a0ac789039006182cc4915f857b45.png",@"https://image1.guazistatic.com/qn161204181714c2c67c602f1c504111f8c6b56be30f83.png",@"https://image1.guazistatic.com/qn1612041855375ac439f17e7f42ac248894e69b75b3bc.png",@"https://image1.guazistatic.com/qn161204190405452d1bad4f1e9c3b2ec2ac85d522ff5d.png",@"https://image1.guazistatic.com/qn1612041905303b2a0ac789039006182cc4915f857b45.png",@"https://image1.guazistatic.com/qn161204181714c2c67c602f1c504111f8c6b56be30f83.png",@"https://image1.guazistatic.com/qn1612041855375ac439f17e7f42ac248894e69b75b3bc.png",@"https://image1.guazistatic.com/qn161204190405452d1bad4f1e9c3b2ec2ac85d522ff5d.png",@"https://image1.guazistatic.com/qn1612041905303b2a0ac789039006182cc4915f857b45.png",@"https://image1.guazistatic.com/qn161204181714c2c67c602f1c504111f8c6b56be30f83.png",@"https://image1.guazistatic.com/qn1612041855375ac439f17e7f42ac248894e69b75b3bc.png",@"https://image1.guazistatic.com/qn161204190405452d1bad4f1e9c3b2ec2ac85d522ff5d.png",@"https://image1.guazistatic.com/qn1612041905303b2a0ac789039006182cc4915f857b45.png"];
    [self shopDesignViews];
}

- (void)shopDesignViews
{
    FSShopClassView *shopClassView = [[FSShopClassView alloc] initWithFrame:CGRectMake(0, 64, 90, 455)];
    shopClassView.dataSource = @[@"瓷砖类",@"瓷砖类",@"瓷砖类",@"瓷砖类",@"瓷砖类",@"瓷砖类",@"瓷砖类",@"瓷砖类",@"瓷砖类",@"瓷砖类",];
    [self.view addSubview:shopClassView];
    [shopClassView setSelectedBlock:^(FSShopClassView *bView, NSInteger bIndex) {
        NSLog(@"%@",@(bIndex));
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(95, 64, self.view.bounds.size.width - 95, self.view.bounds.size.height - 49 - 64) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.contentSize = CGSizeMake(_collectionView.width, self.view.bounds.size.height);
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.alwaysBounceVertical = YES;
    [_collectionView registerClass:[HAShopCollectionCell class] forCellWithReuseIdentifier:collectionCellID];
    [self.view addSubview:_collectionView];
}

//设置每个item的大小，双数的为50*50 单数的为100*100
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (self.view.bounds.size.width - 105) / 2;

    if (indexPath.row%2 == 0) {
        return CGSizeMake(width, width);
    }else{
        return CGSizeMake(width, width);
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (HAShopCollectionCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HAShopCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    UIImage *image = [UIImage imageNamed:@"home_backImage"];
    if (cell.imageView) {
        CGFloat width = (self.view.bounds.size.width - 105) / 2;
        cell.imageView.frame = CGRectMake(0, 0, width, width);
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_dataSource[indexPath.row]] placeholderImage:image];
    }else{
        NSLog(@"WHY");
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",@(indexPath.row));
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
