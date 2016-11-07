//
//  FSShareEntity.m
//  myhome
//
//  Created by fudon on 2016/11/7.
//  Copyright © 2016年 fuhope. All rights reserved.
//

#import "FSShareEntity.h"

@implementation FSShareEntity

+ (FSShareEntity *)shareWTShareContentItem
{
    FSShareEntity * item = [[FSShareEntity alloc]init];
    item.title = @"分享测试";
    item.thumbImage = [UIImage imageNamed:@"fsshare_qq"];
    item.bigImage = [UIImage imageNamed:@"fsshare_qq"];
    item.summary = @"哈哈哈哈哈哈哈哈哈2!!!";
    item.urlString = @"https://www.baidu.com";
    item.sinaSummary = @"一般情况新浪微博的Summary和微信,QQ的是不同的,新浪微博的是一般带链接的,而且总共字数不能超过140字";
    return item;
}

@end
