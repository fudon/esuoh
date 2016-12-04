//
//  HAShopCollectionCell.m
//  myhome
//
//  Created by FudonFuchina on 2016/12/4.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "HAShopCollectionCell.h"

@implementation HAShopCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:frame];
        _imageView.clipsToBounds = YES;
        _imageView.backgroundColor = [UIColor redColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imageView];
    }
    return self;
}

@end
